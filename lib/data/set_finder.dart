import 'dart:async';
import 'dart:isolate';
import 'dart:math';

import 'package:async/async.dart';
import 'package:brachys_armor_set_searcher/main.dart';
import 'package:flutter/material.dart';

import 'equipment.dart';

class SearchArguments {
  final Map<SkillTemplate, Stack<SkillTemplate>> requiredSkills;
  final Map<Deco, int>? decorations;
  final int minRarity, maxRarity;
  final Set<Armor> blacklistedArmor;
  final List<int> weaponSlots;

  SearchArguments(
      {required this.requiredSkills,
      required this.decorations,
      this.minRarity = 0,
      this.maxRarity = 12,
      required this.blacklistedArmor,
      required this.weaponSlots});

  factory SearchArguments.of({
    required List<Stack<SkillTemplate>> requiredSkills,
    required Map<Deco, int>? decorations,
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
        requiredSkills: skills,
        decorations: decorations,
        minRarity: minRarity,
        blacklistedArmor: blacklistedArmor,
        weaponSlots: weaponSlots);
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
      if (charms1 != null) charms.addAll(charms1);
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
  SearchResult._();

  int totalArmorSets = 0;
  StreamController<int> processedArmorSets = StreamController();
  StreamController<List<ArmorSet>> armorSetStream = StreamController();
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
  var skills = ['burst', 'antivirus', 'weakness-exploit'].map((s) => Skill.fromString(s)).map((s) => Stack(value: s, amount: s.maxLevel));
  SearchArguments args =
      SearchArguments.of(requiredSkills: skills.toList(), decorations: null, blacklistedArmor: {}, weaponSlots: [3, 3, 3]);
  _SearchConfig cfg = _SearchConfig(args);
  var tryer = _ArmorSetTryer(config: cfg, decos: cfg.decos);
  ArmorSet? set = tryer.tryArmor(cfg.helmets[0], cfg.chests[0], cfg.arms[0], cfg.waists[0], cfg.legs[0], cfg.charms[0]);
  print(set != null);
}

SendPort? _controlPort;

void cancelArmorSearch() {
  print('Try canceling search. Current port: $_controlPort');
  _controlPort?.send('cancel');
  _controlPort = null;
}

Future<SearchResult> searchAllArmorCombinations(SearchArguments arguments) async {
  SearchResult result = SearchResult._();
  _SearchConfig config = _SearchConfig(arguments);
  result.totalArmorSets = config.estimatedCombinations;
  final receivePort = ReceivePort();

  List<ArmorSet> allSets = [];
  int count = 0;
  //double lastProg = 0.0;
  int lastSetsSize = 0;
  receivePort.listen((msg) {
    if (msg == 1) {
      count++;
      //double prog = count / result.totalArmorSets;
      //if (prog - lastProg >= 0.01) { // this makes the ui lag a lot more than the line below and i have no idea why
      if (count % 1000 == 0) {
        //lastProg = prog;
        result.processedArmorSets.add(count);
        if (allSets.length - lastSetsSize > 10 && lastSetsSize < 200) {
          lastSetsSize = allSets.length;
          result.armorSetStream.add(allSets);
        }
      }
    } else if (msg is Map<String, dynamic>) {
      allSets.add(ArmorSet.fromJson(msg));
    } else if (msg is SendPort) {
      print('Got control Port');
      _controlPort = msg;
    } else if (msg == 'done') {
      print('Isolate done');
      result.processedArmorSets.add(count);
      result.armorSetStream.add(allSets);
      result.processedArmorSets.close();
      result.armorSetStream.close();
    } else if (msg is String) {
      print('Msg from Isolate: $msg');
    }
  });
  //CancellationToken

  //cancellableCompute(callback, message, cancellationToken)
  await Isolate.spawn((SendPort sendPort) async {
    ReceivePort controlReceivePort = ReceivePort('Control port isolate side');
    sendPort.send(controlReceivePort.sendPort);

    var t = DateTime.now().millisecondsSinceEpoch;
    await _ArmorSetTryer.search(config, sendPort, controlReceivePort);
    print('Time to search: ${DateTime.now().millisecondsSinceEpoch - t} ms');
  }, receivePort.sendPort, debugName: 'set_searcher_isolate');
  return result;
}

// everything here runs in an isolate
class _ArmorSetTryer {
  static search(_SearchConfig config, SendPort sendPort, ReceivePort controlPort) async {
    final controlQueue = StreamQueue(controlPort);
    var tryer = _ArmorSetTryer(config: config, decos: config.decos);
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
      sendPort.send(1);
      if (set != null) {
        sendPort.send(set.toJson());
      }
    }
  }

  static Future<bool> isCanceled(SendPort sendPort, StreamQueue queue) async {
    // if we use while here it will empty the stream completely and therefore close the communication and the isolate
    if (await queue.hasNext) {
      var msg = await queue.next;
      sendPort.send('Got Control msg $msg');
      if (msg == 'cancel') {
        return true;
      }
    }
    return false;
  }

  final _SearchConfig config;
  final List<Armor> armor = List.filled(5, All.dummyArmor);
  Charm charm = All.dummyCharm;
  final List<Deco> decos;
  final List<int> slots = List.filled(4, 0);
  final Map<SkillTemplate, Stack<SkillTemplate>> skills = {};
  final Map<SkillTemplate, List<DecoStack>> skillDecoMap = {};
  final List<Deco> usedDecos = [];
  String? error;

  _ArmorSetTryer({required this.config, required this.decos});

  ArmorSet? tryArmor(Armor helm, Armor chest, Armor arm, Armor waist, Armor leg, Charm charm) {
    armor[0] = helm;
    armor[1] = chest;
    armor[2] = arm;
    armor[3] = waist;
    armor[4] = leg;
    this.charm = charm;
    slots.fillRange(0, 4, 0);
    skills.clear();
    for (Stack<SkillTemplate> skill in config.args.requiredSkills.values) {
      skills[skill.value] = skill.copy();
    }
    if (config.args.weaponSlots[0] > 0) slots[config.args.weaponSlots[0]]++;
    if (config.args.weaponSlots[1] > 0) slots[config.args.weaponSlots[1]]++;
    if (config.args.weaponSlots[2] > 0) slots[config.args.weaponSlots[2]]++;
    for (var armor in armor) {
      if (armor.primarySlotSize > 0) slots[armor.primarySlotSize]++;
      if (armor.secondarySlotSize > 0) slots[armor.secondarySlotSize]++;
      if (armor.ternarySlotSize > 0) slots[armor.ternarySlotSize]++;
      _skill(skills, armor.primary, armor.primaryLv);
      if (armor.secondary != null) _skill(skills, armor.secondary!, armor.secondaryLv);
      if (armor.ternary != null) _skill(skills, armor.ternary!, armor.ternaryLv);
      if (armor.groupBonus != null) _skill(skills, armor.groupBonus!, 1);
      if (armor.setBonus != null) _skill(skills, armor.setBonus!, 1);
    }
    _skill(skills, charm.primary, charm.primaryLv);
    if (charm.secondary != null) _skill(skills, charm.secondary!, charm.secondaryLv);
    if (charm.ternary != null) _skill(skills, charm.ternary!, charm.ternaryLv);
    if (skills.isEmpty) {
      return _makeArmorSet(); // requirements are already met before any decos
    }
    if (decos.isEmpty) {
      error = 'No decos provided and armor has not enough';
      return null;
    }
    return tryDecos();
  }

  ArmorSet? tryDecos() {
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
      _skill(reqSkills, deco.primary, deco.primaryLvl * decoStack.amount);
      skillDecoMap.putIfAbsent(deco.primary, () => []).add(decoStack);
      if (deco.hasSec) {
        // add secondary skill
        _skill(reqSkills, deco.secondary!, decoStack.amount);
        skillDecoMap.putIfAbsent(deco.secondary!, () => []).add(decoStack);
      }
    }
    if (reqSkills.isNotEmpty) {
      // not all skill requirements met
      error = 'Decos cant make required skills';
      return null;
    }
    // roll back
    reqSkills = skills.map((key, value) => MapEntry(key, value.copy()));
    _cleanDecoList(reqSkills);
    if (skillDecoMap.isEmpty) return null;
    return _insertDecos(reqSkills);
  }

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

  bool _insertDefiniteDecos(Map<SkillTemplate, Stack<SkillTemplate>> reqSkills) {
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
      _insertDeco(reqSkills, deco);
      if (reqSkills.isEmpty || skillDecoMap.isEmpty) return true;
    }
  }

  int _getBestDecoValue(SkillTemplate skill) {
    return skillDecoMap[skill]![0].totalPoints;
  }

  Stack<SkillTemplate> _findBestSkill(Map<SkillTemplate, Stack<SkillTemplate>> reqSkills) {
    Stack<SkillTemplate>? highestReqSkill;
    int bestDecoValueForSkill = 0;
    for (Stack<SkillTemplate> skill in reqSkills.values) {
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

  bool _insertBestDeco(Map<SkillTemplate, Stack<SkillTemplate>> reqSkills) {
    Stack<SkillTemplate> highestReqSkill = _findBestSkill(reqSkills);
    _insertDeco(reqSkills, skillDecoMap[highestReqSkill.value]![0]);
    return reqSkills.isEmpty || skillDecoMap.isEmpty;
  }

  void _insertDeco(Map<SkillTemplate, Stack<SkillTemplate>> skills, DecoStack deco) {
    _skill(skills, deco.value.primary, deco.value.primaryLvl);
    if (deco.value.hasSec) _skill(skills, deco.value.secondary!, 1);
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
    _cleanDecoList(skills);
  }

  ArmorSet? _insertDecos(Map<SkillTemplate, Stack<SkillTemplate>> reqSkills) {
    while (true) {
      if (_insertDefiniteDecos(reqSkills) || _insertBestDeco(reqSkills)) {
        return reqSkills.isEmpty ? _makeArmorSet() : null;
      }
    }
  }

  ArmorSet _makeArmorSet() {
    usedDecos.sort((a, b) {
      int i = b.size.compareTo(a.size);
      return i != 0 ? i : a.name.compareTo(b.name);
    });
    List<Deco?> weaponDecos = List.filled(3, null);
    Map<Armor, List<Deco?>> pieces = {
      armor[0]: List.filled(3, null),
      armor[1]: List.filled(3, null),
      armor[2]: List.filled(3, null),
      armor[3]: List.filled(3, null),
      armor[4]: List.filled(3, null)
    };
    for (Deco deco in usedDecos) {
      int size = deco.size;
      outer:
      while (size <= 3) {
        if (size == 3) {
          if (weaponDecos[0] == null) {
            weaponDecos[0] = deco;
            break outer;
          }
          if (weaponDecos[1] == null) {
            weaponDecos[1] = deco;
            break outer;
          }
          if (weaponDecos[2] == null) {
            weaponDecos[2] = deco;
            break outer;
          }
        }
        for (Armor armor in this.armor) {
          if (armor.primarySlotSize == size && pieces[armor]![0] == null) {
            pieces[armor]![0] = deco;
            break outer;
          }
          if (armor.secondarySlotSize == size && pieces[armor]![1] == null) {
            pieces[armor]![1] = deco;
            break outer;
          }
          if (armor.ternarySlotSize == size && pieces[armor]![2] == null) {
            pieces[armor]![2] = deco;
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

  void _cleanDecoList(Map<SkillTemplate, Stack<SkillTemplate>> reqSkills) {
    skillDecoMap.removeWhere((key, value) {
      value.removeWhere((deco) {
        deco.checkTotalPoints(reqSkills);
        return deco.totalPoints == 0 || deco.amount <= 0 || !hasSlotForDecoSize(deco.value.size);
      });
      if (value.isEmpty) return true;
      value.sort();
      return false;
    });
    for (Stack<SkillTemplate> skill in reqSkills.values) {
      if (skillDecoMap[skill.value] == null) {
        // no decos available for a skill
        skillDecoMap.clear();
        return;
      }
    }
  }

  /// removes a certain amount of required skill levels
  void _skill(Map<SkillTemplate, Stack<SkillTemplate>> skills, SkillTemplate skill, int amount) {
    Stack<SkillTemplate>? lv = skills[skill];
    if (lv != null && lv.decr(amount)) {
      skills.remove(skill);
    }
  }

  bool isValid() {
    return armor[0] != All.dummyArmor && skills.isEmpty;
  }
}
