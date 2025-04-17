import 'dart:async';
import 'dart:isolate';
import 'dart:math';

import 'package:async/async.dart';
import 'package:brachys_armor_set_searcher/data/isolate.dart';
import 'package:brachys_armor_set_searcher/main.dart';
import 'package:brachys_armor_set_searcher/screen/search_results.dart';
import 'package:flutter/material.dart';

import 'equipment.dart';

class SearchArguments {
  final Weapon weapon;
  final Map<SkillTemplate, Stack<SkillTemplate>> requiredSkills;
  final Map<Deco, int>? decorations;
  final Map<Charm, List<Charm>>? charms;
  final int minRarity, maxRarity;
  final Set<Armor> blacklistedArmor;
  final List<int> weaponSlots;

  SearchArguments(
      {required this.weapon,
      required this.requiredSkills,
      required this.decorations,
      required this.charms,
      this.minRarity = 0,
      this.maxRarity = 12,
      required this.blacklistedArmor,
      required this.weaponSlots});

  factory SearchArguments.of({
    required Weapon weapon,
    required List<Stack<SkillTemplate>> requiredSkills,
    required Map<Deco, int>? decorations,
    required Map<Charm, List<Charm>>? charms,
    int minRarity = 0,
    int maxRarity = 12,
    required Set<Armor> blacklistedArmor,
    required List<int> weaponSlots,
  }) {
    Map<SkillTemplate, Stack<SkillTemplate>> skills = {};
    for (var s in requiredSkills) {
      skills[s.value] = s;
    }
    return SearchArguments(
        weapon: weapon,
        requiredSkills: skills,
        decorations: decorations,
        charms: charms,
        minRarity: minRarity,
        blacklistedArmor: blacklistedArmor,
        weaponSlots: weaponSlots);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['skills'] = requiredSkills.map((s, stack) => MapEntry(s.name, stack.amount));
    json['decorations'] = decorations?.map((d, i) => MapEntry(d.name, i));
    json['charms'] = charms?.map((c, l) => MapEntry(c.name, l.map((c1) => c1.name).toList()));
    json['minRarity'] = minRarity;
    json['maxRarity'] = maxRarity;
    json['blacklistedArmor'] = blacklistedArmor.map((a) => a.name).toList();
    json['weaponSlots'] = weaponSlots;
    return json;
  }

  factory SearchArguments.fromJson(Map<String, dynamic> json) {
    return SearchArguments.of(
        weapon: All.dummyWeapon,
        requiredSkills:
            (json['skills'] as Map<String, int>).entries.map((e) => Stack(value: All.allSkills[e.key]!, amount: e.value)).toList(),
        decorations: (json['decorations'] as Map<String, int>?)?.map((d, i) => MapEntry(All.decosByString[d]!, i)),
        charms: (json['charms'] as Map<String, List<String>>?)
            ?.map((c, l) => MapEntry(All.equipment[c] as Charm, l.map((c1) => All.equipment[c] as Charm).toList())),
        minRarity: json['minRarity'],
        maxRarity: json['maxRarity'],
        blacklistedArmor: (json['blacklistedArmor'] as List<String>).map((a) => All.equipment[a] as Armor).toSet(),
        weaponSlots: json['weaponSlots']);
  }
}

class _ValueArmor implements Comparable<_ValueArmor> {
  final Armor armor;
  final int value;

  _ValueArmor(this.armor, this.value);

  factory _ValueArmor.create(Armor armor, Map<SkillTemplate, Stack<SkillTemplate>> skills) {
    int skillValue = _evaluateSkillValue(armor.primary, armor.primaryLv, skills);
    skillValue += _evaluateSkillValue(armor.secondary, armor.secondaryLv, skills);
    skillValue += _evaluateSkillValue(armor.ternary, armor.ternaryLv, skills);
    skillValue += _evaluateSkillValue(armor.setBonus, 1, skills);
    skillValue += _evaluateSkillValue(armor.groupBonus, 1, skills);
    int slotValue = armor.primarySlotSize + armor.secondarySlotSize + armor.ternarySlotSize;
    return _ValueArmor(armor, skillValue * 12 + slotValue * 10);
  }

  static int _evaluateSkillValue(SkillTemplate? skill, int lvl, Map<SkillTemplate, Stack<SkillTemplate>> skills) {
    return skill != null && skills.containsKey(skill) ? lvl : 0;
  }

  @override
  int compareTo(_ValueArmor other) {
    return other.value.compareTo(value);
  }
}

class _SearchConfig {
  final SearchArguments args;
  late final int estimatedCombinations;
  final List<Armor> helmets = [];
  final List<Armor> chests = [];
  final List<Armor> arms = [];
  final List<Armor> waists = [];
  final List<Armor> legs = [];
  final List<Charm> charms = [];
  final List<Deco> decos = [];

  _SearchConfig(this.args) {
    for (Stack<SkillTemplate> skill in args.requiredSkills.values) {
      _addArmor(helmets, All.helmets[skill.value]);
      _addArmor(chests, All.chests[skill.value]);
      _addArmor(arms, All.arms[skill.value]);
      _addArmor(waists, All.waists[skill.value]);
      _addArmor(legs, All.legs[skill.value]);
      var charms1 = All.charms[skill.value];
      if (charms1 != null) {
        if (args.charms != null) {
          for (var charm in charms1) {
            var fam = args.charms![charm];
            if (fam != null && fam.isNotEmpty) {
              charms.add(fam.last);
            }
          }
        } else {
          charms.addAll(charms1);
        }
      }
      Set<Deco> decoSet = {};
      for (var deco in All.decosMap[skill.value] ?? []) {
        if (hasDeco(deco)) {
          decoSet.add(deco);
        }
      }
      decos.addAll(decoSet);
      decos.sort((d1, d2) => d2.size.compareTo(d1.size));
    }
    _sortList(helmets);
    _sortList(chests);
    _sortList(arms);
    _sortList(waists);
    _sortList(legs);
    estimatedCombinations = helmets.length * chests.length * arms.length * waists.length * legs.length * charms.length;
    log('Searching $estimatedCombinations combinations');
  }

  void _sortList(List<Armor> list) {
    var copy = list.map((a) => _ValueArmor.create(a, args.requiredSkills)).toList(growable: false);
    copy.sort();
    list.clear();
    list.addAll(copy.map((as) => as.armor));
  }

  bool hasDeco(Deco deco) {
    return getDecoAmount(deco) > 0;
  }

  int getDecoAmount(Deco deco) {
    if (args.decorations == null) {
      if (deco.secondary != null) {
        return max(deco.primary.maxLevel, deco.secondary!.maxLevel);
      }
      return deco.primary.maxLevel;
    }
    return args.decorations![deco] ?? 0;
  }

  void _addArmor(List<Armor> validArmor, List<Armor>? allArmor) {
    if (allArmor != null) {
      for (var armor in allArmor) {
        if (armor.rarity >= args.minRarity && armor.rarity <= args.maxRarity && !args.blacklistedArmor.contains(armor)) {
          validArmor.add(armor);
        }
      }
    }
  }
}

class SearchResult {
  SearchResult();

  int totalArmorSets = 0;

  DataStream<int> processedArmorSets = DataStream(StreamController());
  DataStream<ArmorSet> armorSetStream = DataStream(StreamController());
}

abstract class ArmorFilter {
  String get displayName;

  bool testArmor(Armor armor);

  Color get color;
}

class MinRarityFilter extends ArmorFilter {
  MinRarityFilter(this.rarity);

  final int rarity;

  @override
  String get displayName => "min rarity $rarity";

  @override
  bool testArmor(Armor armor) {
    return armor.rarity >= rarity;
  }

  @override
  Color get color => Colors.blue;
}

class MaxRarityFilter extends ArmorFilter {
  MaxRarityFilter(this.rarity);

  final int rarity;

  @override
  String get displayName => "max rarity $rarity";

  @override
  bool testArmor(Armor armor) {
    return armor.rarity <= rarity;
  }

  @override
  Color get color => Colors.blue;
}

class ArmorPieceFilter extends ArmorFilter {
  final Armor armor;
  final bool blacklist;

  ArmorPieceFilter(this.armor, this.blacklist);

  @override
  String get displayName => armor.name;

  @override
  bool testArmor(Armor armor) {
    return (armor == this.armor) != blacklist;
  }

  @override
  Color get color => blacklist ? Colors.red : Colors.green;
}

class Stack<T> {
  final T value;
  int amount;

  Stack({required this.value, this.amount = 1}) {
    amount = max(0, amount);
  }

  bool decr([int by = 1]) {
    amount = max(0, amount - by);
    return isEmpty;
  }

  void incr([int by = 1]) {
    amount = max(0, amount + by);
  }

  bool get isEmpty => amount <= 0;

  Stack<T> copy([int? newAmount]) {
    return Stack(value: value, amount: newAmount ?? amount);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is Stack && value == other.value && amount == other.amount);
  }

  @override
  int get hashCode => Object.hash(value, amount);
}

class DecoStack extends Stack<Deco> implements Comparable<DecoStack> {
  int totalPoints;

  DecoStack({required super.value, super.amount, this.totalPoints = 0});

  void checkTotalPoints(Map<SkillTemplate, Stack<SkillTemplate>> skills) {
    totalPoints = 0;
    Stack<SkillTemplate>? skill = skills[value.primary];
    if (skill != null) totalPoints += min(skill.amount, value.primaryLvl);
    if (value.hasSec) {
      skill = skills[value.secondary!];
      if (skill != null) totalPoints += min(skill.amount, 1);
    }
  }

  @override
  DecoStack copy([int? newAmount]) {
    return DecoStack(value: value, amount: newAmount ?? amount);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (runtimeType == other.runtimeType && other is DecoStack && value.name == other.value.name);
  }

  @override
  int get hashCode => value.name.hashCode;

  @override
  int compareTo(DecoStack other) {
    int i = other.totalPoints.compareTo(totalPoints); // higher total skill points first
    return i != 0 ? i : value.size.compareTo(other.value.size); // lower size first
  }
}

void testSearch() {
  var skills = ['burst', 'antivirus', 'weakness-exploit', 'critical-boost']
      .map((s) => Skill.fromString(s))
      .map((s) => Stack(value: s, amount: s.maxLevel));
  SearchArguments args = SearchArguments.of(
      weapon: All.dummyWeapon,
      requiredSkills: skills.toList(),
      decorations: null,
      charms: null,
      blacklistedArmor: {},
      weaponSlots: [3, 3, 3]);
  _SearchConfig cfg = _SearchConfig(args);
  var tryer = _ArmorSetTryer.of(config: cfg, decos: cfg.decos);
  ArmorSet? set = tryer.tryArmor(cfg.helmets[0], cfg.chests[0], cfg.arms[0], cfg.waists[0], cfg.legs[0], cfg.charms[0]);
  print(set != null);
}

void cancelArmorSearch() {
  print('Try canceling search. Current port: $_controlPort');
  _controlPort?.send('cancel');
  _controlPort = null;
}

Future<SearchResult> searchAllArmorCombinations2(SearchArguments arguments) async {
  SearchResult result = SearchResult._();

  final receivePort = ReceivePort();

  int count = 0;
  //double lastProg = 0.0;
  receivePort.listen((msg) {
    if (msg is int) {
      if (msg == -1) {
        count++;
        //double prog = count / result.totalArmorSets;
        //if (prog - lastProg >= 0.01) { // this makes the ui lag a lot more than the line below and i have no idea why
        if (count % 1000 == 0) {
          //lastProg = prog;
          result.processedArmorSets.add(count);
        }
      } else {
        result.totalArmorSets = msg;
      }
    } else if (msg is Map<String, dynamic>) {
      result.armorSetStream.add(ArmorSet.fromJson(msg));
    } else if (msg is SendPort) {
      print('Got control Port');
      _controlPort = msg;
    } else if (msg == 'done') {
      print('Isolate done');
      result.processedArmorSets.add(count);
      result.processedArmorSets.close();
      result.armorSetStream.close();
    } else if (msg is String) {
      print('Msg from Isolate: $msg');
    }
  });
  //CancellationToken

  //cancellableCompute(callback, message, cancellationToken)
  await Isolate.spawn((SendPort sendPort) async {}, receivePort.sendPort, debugName: 'set_searcher_isolate');
  return result;
}

void _doSearch(SendPort sendPort) {
  ReceivePort controlReceivePort = ReceivePort('Control port isolate side');
  sendPort.send(controlReceivePort.sendPort);

  _SearchConfig config = _SearchConfig(arguments);
  sendPort.send(config.estimatedCombinations);

  var t = DateTime.now().millisecondsSinceEpoch;
  await _ArmorSetTryer.search(config, sendPort, controlReceivePort);
  print('Time to search: ${DateTime.now().millisecondsSinceEpoch - t} ms');
}

// everything here runs in an isolate
class _ArmorSetTryer {
  static search(_SearchConfig config, SendPort sendPort, ReceivePort controlPort) async {
    final controlQueue = StreamQueue(controlPort);
    var tryer = _ArmorSetTryer.of(config: config, decos: config.decos);
    sendPort.send('Searching');
    bool canceled = false;
    for (var helm in config.helmets) {
      for (var chest in config.chests) {
        for (var arm in config.arms) {
          for (var waist in config.waists) {
            for (var leg in config.legs) {
              if (canceled) {
                sendPort.send('done');
                return;
              }
              await _searchInner(sendPort, config, tryer, helm, chest, arm, waist, leg);
              isCanceled(sendPort, controlQueue).then((c) => canceled = c); // must use then to not block computation
              await Future.delayed(Duration.zero); // give the async canceled check time to compute
            }
          }
        }
      }
    }
    sendPort.send('done');
  }

  static Future _searchInner(
      SendPort sendPort, _SearchConfig config, _ArmorSetTryer tryer, Armor helm, Armor chest, Armor arm, Armor waist, Armor leg) async {
    for (var charm in config.charms) {
      ArmorSet? set = tryer.tryArmor(helm, chest, arm, waist, leg, charm);
      sendPort.send(-1);
      if (set != null) {
        sendPort.send(set.toJson());
      }
    }
  }

  static Future<bool> isCanceled(SendPort sendPort, StreamQueue queue) async {
    // if we use while here it will empty the stream completely and therefore close the communication and the isolate
    if (await queue.hasNext) {
      var msg = await queue.next;
      if (msg is String) {
        sendPort.send('Got Control msg $msg');
        if (msg == 'cancel') {
          return true;
        }
      }
    }
    return false;
  }

  static final List<Deco> emptyDecos = List.empty();

  final _SearchConfig config;
  final List<Armor> armor = List.filled(5, All.dummyArmor);
  Charm charm = All.dummyCharm;
  final List<Deco> decos;
  final Map<SkillTemplate, Stack<SkillTemplate>> skills = {};
  final _DecoTryer weaponTryer;
  final _DecoTryer armorTryer;
  final _DecoTryer setBonusTryer;
  final _DecoTryer groupBonusTryer;
  String? error;

  _ArmorSetTryer(
      {required this.config,
      required this.decos,
      required this.weaponTryer,
      required this.armorTryer,
      required this.setBonusTryer,
      required this.groupBonusTryer});

  factory _ArmorSetTryer.of({required _SearchConfig config, required List<Deco> decos}) {
    return _ArmorSetTryer(
        config: config,
        decos: decos,
        weaponTryer: _DecoTryer(SkillCategory.weapon, config),
        armorTryer: _DecoTryer(SkillCategory.armor, config),
        groupBonusTryer: _DecoTryer(SkillCategory.groupBonus, config),
        setBonusTryer: _DecoTryer(SkillCategory.setBonus, config));
  }

  ArmorSet? tryArmor(Armor helm, Armor chest, Armor arm, Armor waist, Armor leg, Charm charm) {
    armor[0] = helm;
    armor[1] = chest;
    armor[2] = arm;
    armor[3] = waist;
    armor[4] = leg;
    this.charm = charm;
    skills.clear();
    for (Stack<SkillTemplate> skill in config.args.requiredSkills.values) {
      skills[skill.value] = skill.copy();
    }
    addEquipmentSkills(config.args.weapon);
    addEquipmentSkills(helm);
    addEquipmentSkills(chest);
    addEquipmentSkills(arm);
    addEquipmentSkills(waist);
    addEquipmentSkills(leg);
    addEquipmentSkills(charm);
    if (skills.isEmpty) {
      // clear decos used before for new set
      weaponTryer.usedDecos.clear();
      armorTryer.usedDecos.clear();
      return _makeArmorSet(); // requirements are already met before any decos
    }
    if (decos.isEmpty) {
      error = 'No decos provided and armor has not enough';
      return null;
    }
    setBonusTryer.init(emptyDecos, skills.values);
    groupBonusTryer.init(emptyDecos, skills.values);
    if (!setBonusTryer.tryDecos() || !groupBonusTryer.tryDecos()) return null; // fast early check
    weaponTryer.init(decos, skills.values);
    armorTryer.init(decos, skills.values);
    weaponTryer.addEquipmentSlots(config.args.weapon);
    armorTryer.addEquipmentSlots(helm);
    armorTryer.addEquipmentSlots(chest);
    armorTryer.addEquipmentSlots(arm);
    armorTryer.addEquipmentSlots(waist);
    armorTryer.addEquipmentSlots(leg);
    if (weaponTryer.tryDecos() && armorTryer.tryDecos()) {
      return _makeArmorSet();
    }
    return null;
  }

  addEquipmentSkills(Equipment eq) {
    _skill(skills, eq.primary, eq.primaryLv);
    if (eq.secondary != null) _skill(skills, eq.secondary!, eq.secondaryLv);
    if (eq.ternary != null) _skill(skills, eq.ternary!, eq.ternaryLv);
    if (eq is Armor) {
      if (eq.groupBonus != null) _skill(skills, eq.groupBonus!, 1);
      if (eq.setBonus != null) _skill(skills, eq.setBonus!, 1);
    }
  }

  int _compareDeco(Deco a, Deco b) {
    int i = b.size.compareTo(a.size);
    return i != 0 ? i : a.name.compareTo(b.name);
  }

  ArmorSet _makeArmorSet() {
    weaponTryer.usedDecos.sort(_compareDeco);
    armorTryer.usedDecos.sort(_compareDeco);
    List<Deco?> weaponDecos = List.filled(3, null);
    for (Deco deco in weaponTryer.usedDecos) {
      int size = deco.size;
      while (size <= 3) {
        // try inserting in matching size first
        if (_insertDeco(config.args.weapon, weaponDecos, deco, size)) {
          break;
        }
        size++; // no empty slot found, try bigger size
      }
      if (size == 4) print('Decos was inserted before, but no fitting slot in weapon was found');
    }
    Map<Armor, List<Deco?>> pieces = {
      armor[0]: List.filled(3, null),
      armor[1]: List.filled(3, null),
      armor[2]: List.filled(3, null),
      armor[3]: List.filled(3, null),
      armor[4]: List.filled(3, null)
    };
    for (Deco deco in armorTryer.usedDecos) {
      int size = deco.size;
      outer:
      while (size <= 3) {
        for (Armor armor in this.armor) {
          if (_insertDeco(armor, pieces[armor]!, deco, size)) {
            break outer;
          }
        }
        size++;
      }
      if (size == 4) print('Decos was inserted before, but no fitting slot in armor was found');
    }
    List<EquipmentPiece> piecesList = [];
    pieces.forEach((k, v) => piecesList.add(EquipmentPiece(equipment: k, decorations: v)));
    piecesList.sort();
    return ArmorSet(weaponDecos: weaponDecos, pieces: piecesList, charm: charm);
  }

  bool _insertDeco(SlottedEquipment eq, List<Deco?> slots, Deco deco, int size) {
    if (eq.primarySlotSize == size && slots[0] == null) {
      slots[0] = deco;
      return true;
    }
    if (eq.secondarySlotSize == size && slots[1] == null) {
      slots[1] = deco;
      return true;
    }
    if (eq.ternarySlotSize == size && slots[2] == null) {
      slots[2] = deco;
      return true;
    }
    return false;
  }

  /// removes a certain amount of required skill levels
  static _skill(Map<SkillTemplate, Stack<SkillTemplate>> skills, SkillTemplate skill, int amount) {
    Stack<SkillTemplate>? lv = skills[skill];
    if (lv != null && lv.decr(amount)) {
      skills.remove(skill);
    }
  }

  bool isValid() {
    return armor[0] != All.dummyArmor && skills.isEmpty;
  }
}

class _DecoTryer {
  final SkillCategory type;
  final _SearchConfig config;
  final List<Deco> decos = [];
  final List<int> slots = List.filled(4, 0);
  final Map<SkillTemplate, Stack<SkillTemplate>> skills = {};
  final Map<SkillTemplate, List<DecoStack>> skillDecoMap = {};
  final List<Deco> usedDecos = [];
  String? error;

  _DecoTryer(this.type, this.config);

  init(List<Deco> decos, Iterable<Stack<SkillTemplate>> skills) {
    slots[0] = 0;
    slots[1] = 0;
    slots[2] = 0;
    slots[3] = 0;
    this.decos.clear();
    this.decos.addAll(decos.where((d) => d.category == type));
    this.skills.clear();
    for (var skill in skills) {
      if (skill.value.category == type) {
        this.skills[skill.value] = skill;
      }
    }
  }

  addEquipmentSlots(SlottedEquipment eq) {
    if (eq.primarySlotSize > 0) slots[eq.primarySlotSize]++;
    if (eq.secondarySlotSize > 0) slots[eq.secondarySlotSize]++;
    if (eq.ternarySlotSize > 0) slots[eq.ternarySlotSize]++;
  }

  bool tryDecos() {
    if (decos.isEmpty || !hasAnySlots) {
      return skills.isEmpty;
    }
    // TODO rewrite this
    // test map
    // we simulate inserting every deco we have regardless of space at the same time
    // if the skill levels dont add to the required levels it is impossible to make this set
    Map<SkillTemplate, Stack<SkillTemplate>> reqSkills = skills.map((key, value) => MapEntry(key, value.copy()));
    skillDecoMap.clear();
    usedDecos.clear();
    for (var deco in decos) {
      // check if deco skills are still required
      if (!skills.containsKey(deco.primary) && (!deco.hasSec || !skills.containsKey(deco.secondary!))) continue;
      var decoStack = DecoStack(value: deco, amount: config.getDecoAmount(deco));
      decoStack.checkTotalPoints(skills);
      // add primary skill
      _ArmorSetTryer._skill(reqSkills, deco.primary, deco.primaryLvl * decoStack.amount);
      skillDecoMap.putIfAbsent(deco.primary, () => []).add(decoStack);
      if (deco.hasSec) {
        // add secondary skill
        _ArmorSetTryer._skill(reqSkills, deco.secondary!, decoStack.amount);
        skillDecoMap.putIfAbsent(deco.secondary!, () => []).add(decoStack);
      }
    }
    if (reqSkills.isNotEmpty) {
      // not all skill requirements met
      error = 'Decos cant make required skills';
      return false;
    }
    _cleanDecoList();
    if (skillDecoMap.isEmpty) return false;
    return _insertDecos();
  }

  bool get hasAnySlots => slots[1] > 0 || slots[2] > 0 || slots[3] > 0;

  bool canInsert(DecoStack deco) {
    return deco.amount > 0 && slots[deco.value.size] > 0;
  }

  bool hasSlotForDecoSize(int size) {
    while (size <= 3) {
      if (slots[size] > 0) return true;
      size++;
    }
    return false;
  }

  bool _insertDefiniteDecos() {
    // inserts any deco for which skills we only have one deco available
    // so in order to get this skill this deco must be inserted
    while (true) {
      DecoStack? deco;
      for (List<DecoStack> decos in skillDecoMap.values) {
        if (decos.length == 1 && canInsert(decos[0])) {
          deco = decos[0];
          break;
        }
      }
      if (deco == null) return false;
      _insertDeco(deco);
      if (skills.isEmpty || skillDecoMap.isEmpty) return true;
    }
  }

  int _getBestDecoValue(SkillTemplate skill) {
    return skillDecoMap[skill]![0].totalPoints;
  }

  Stack<SkillTemplate> _findBestSkill() {
    Stack<SkillTemplate>? highestReqSkill;
    int bestDecoValueForSkill = 0;
    for (Stack<SkillTemplate> skill in skills.values) {
      if (highestReqSkill == null) {
        highestReqSkill = skill;
        bestDecoValueForSkill = _getBestDecoValue(skill.value);
        continue;
      }
      int bestDecoValue = _getBestDecoValue(skill.value);
      if (bestDecoValue < bestDecoValueForSkill) continue;
      if (bestDecoValue > bestDecoValueForSkill || skill.amount > highestReqSkill.amount) {
        highestReqSkill = skill;
        bestDecoValueForSkill = bestDecoValue;
      }
    }
    return highestReqSkill!;
  }

  bool _insertBestDeco() {
    Stack<SkillTemplate> highestReqSkill = _findBestSkill();
    _insertDeco(skillDecoMap[highestReqSkill.value]![0]);
    return skills.isEmpty || skillDecoMap.isEmpty;
  }

  void _insertDeco(DecoStack deco) {
    _ArmorSetTryer._skill(skills, deco.value.primary, deco.value.primaryLvl);
    if (deco.value.hasSec) _ArmorSetTryer._skill(skills, deco.value.secondary!, 1);
    usedDecos.add(deco.value);
    deco.decr();
    int size = deco.value.size;
    while (size <= 3) {
      if (slots[size] > 0) {
        slots[size]--;
        break;
      }
      size++;
    }
    if (size > 3) print('Before inserting there was space for deco, but now there isn\'t anymore!');
    _cleanDecoList();
  }

  bool _insertDecos() {
    while (true) {
      if (_insertDefiniteDecos() || _insertBestDeco()) {
        return skills.isEmpty; // all skills matched, success
      }
    }
  }

  void _cleanDecoList() {
    skillDecoMap.removeWhere((key, value) {
      value.removeWhere((deco) {
        deco.checkTotalPoints(skills);
        return deco.totalPoints == 0 || deco.amount <= 0 || !hasSlotForDecoSize(deco.value.size);
      });
      if (value.isEmpty) return true;
      value.sort();
      return false;
    });
    for (Stack<SkillTemplate> skill in skills.values) {
      if (skillDecoMap[skill.value] == null) {
        // no decos available for a skill
        skillDecoMap.clear();
        return;
      }
    }
  }
}
