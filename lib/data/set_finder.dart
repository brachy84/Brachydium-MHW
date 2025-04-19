import 'dart:async';
import 'dart:core';
import 'dart:isolate';
import 'dart:math';

import 'package:brachys_armor_set_searcher/data/util.dart';
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

  SearchArguments(
      {required this.weapon,
      required this.requiredSkills,
      required this.decorations,
      required this.charms,
      this.minRarity = 0,
      this.maxRarity = 12,
      required this.blacklistedArmor});

  factory SearchArguments.of(
      {required Weapon weapon,
      required List<Stack<SkillTemplate>> requiredSkills,
      required Map<Deco, int>? decorations,
      required Map<Charm, List<Charm>>? charms,
      int minRarity = 0,
      int maxRarity = 12,
      required Set<Armor> blacklistedArmor}) {
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
        blacklistedArmor: blacklistedArmor);
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
  final Weapon weapon;
  final Map<SkillTemplate, Stack<SkillTemplate>> requiredSkills;
  final Map<Deco, int>? decorations;
  final int estimatedCombinations;
  final List<Armor> helmets;
  final List<Armor> chests;
  final List<Armor> arms;
  final List<Armor> waists;
  final List<Armor> legs;
  final List<Charm> charms;
  final List<Deco> decos;

  _SearchConfig._(this.weapon, this.requiredSkills, this.decorations, this.estimatedCombinations, this.helmets,
      this.chests, this.arms, this.waists, this.legs, this.charms, this.decos);

  factory _SearchConfig(SearchArguments args) {
    final List<Armor> helmets = [];
    final List<Armor> chests = [];
    final List<Armor> arms = [];
    final List<Armor> waists = [];
    final List<Armor> legs = [];
    final List<Charm> charms = [];
    final List<Deco> decos = [];
    for (Stack<SkillTemplate> skill in args.requiredSkills.values) {
      _addArmor(args, helmets, All.helmets[skill.value]);
      _addArmor(args, chests, All.chests[skill.value]);
      _addArmor(args, arms, All.arms[skill.value]);
      _addArmor(args, waists, All.waists[skill.value]);
      _addArmor(args, legs, All.legs[skill.value]);
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
        if (_hasDeco(args.decorations, deco)) {
          decoSet.add(deco);
        }
      }
      decos.addAll(decoSet);
      decos.sort((d1, d2) => d2.size.compareTo(d1.size));
    }
    _sortList(args, helmets);
    _sortList(args, chests);
    _sortList(args, arms);
    _sortList(args, waists);
    _sortList(args, legs);
    int estimatedCombinations =
        helmets.length * chests.length * arms.length * waists.length * legs.length * charms.length;
    log.info('Searching $estimatedCombinations combinations');
    return _SearchConfig._(args.weapon, args.requiredSkills, args.decorations, estimatedCombinations, helmets, chests,
        arms, waists, legs, charms, decos);
  }

  Json toJson() {
    Json json = {};
    json['skills'] = requiredSkills.map((k, v) => MapEntry(v.value.name, v.amount));
    json['decorations'] = decorations?.map((k, v) => MapEntry(k.name, v));
    json['weapon'] = weapon.toJson();
    json['count'] = estimatedCombinations;
    json['helmets'] = helmets.map((t) => t.name).toList();
    json['chests'] = chests.map((t) => t.name).toList();
    json['arms'] = arms.map((t) => t.name).toList();
    json['waists'] = waists.map((t) => t.name).toList();
    json['legs'] = legs.map((t) => t.name).toList();
    json['charms'] = charms.map((t) => t.name).toList();
    json['decos'] = decos.map((t) => t.name).toList();
    return json;
  }

  factory _SearchConfig.fromJson(Json json) {
    List<Stack<SkillTemplate>> requiredSkills =
        (json['skills'] as Json).entries.map((e) => Stack(value: All.allSkills[e.key]!, amount: e.value)).toList();
    Map<SkillTemplate, Stack<SkillTemplate>> skills = {};
    for (var s in requiredSkills) {
      skills[s.value] = s;
    }
    Map<Deco, int>? decos = (json['decorations'] as Json?)?.map((k, v) => MapEntry(All.decosByString[k]!, v));
    return _SearchConfig._(
      Weapon.fromJson(json['weapon']),
      skills,
      decos,
      json['count'],
      (json['helmets'] as List<String>).map((j) => All.equipment[j] as Armor).toList(),
      (json['chests'] as List<String>).map((j) => All.equipment[j] as Armor).toList(),
      (json['arms'] as List<String>).map((j) => All.equipment[j] as Armor).toList(),
      (json['waists'] as List<String>).map((j) => All.equipment[j] as Armor).toList(),
      (json['legs'] as List<String>).map((j) => All.equipment[j] as Armor).toList(),
      (json['charms'] as List<String>).map((j) => All.equipment[j] as Charm).toList(),
      (json['decos'] as List<String>).map((j) => All.decosByString[j]!).toList(),
    );
  }

  static void _sortList(SearchArguments args, List<Armor> list) {
    var copy = list.map((a) => _ValueArmor.create(a, args.requiredSkills)).toList(growable: false);
    copy.sort();
    list.clear();
    list.addAll(copy.map((as) => as.armor));
  }

  static bool _hasDeco(Map<Deco, int>? decorations, Deco deco) {
    return _getDecoAmount(decorations, deco) > 0;
  }

  static int _getDecoAmount(Map<Deco, int>? decorations, Deco deco) {
    if (decorations == null) {
      if (deco.secondary != null) {
        return max(deco.primary.maxLevel, deco.secondary!.maxLevel);
      }
      return deco.primary.maxLevel;
    }
    return decorations[deco] ?? 0;
  }

  bool hasDeco(Deco deco) {
    return _hasDeco(decorations, deco);
  }

  int getDecoAmount(Deco deco) {
    return _getDecoAmount(decorations, deco);
  }

  static void _addArmor(SearchArguments args, List<Armor> validArmor, List<Armor>? allArmor) {
    if (allArmor != null) {
      for (var armor in allArmor) {
        if (armor.rarity >= args.minRarity &&
            armor.rarity <= args.maxRarity &&
            !args.blacklistedArmor.contains(armor)) {
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
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Stack && value == other.value && amount == other.amount);
  }

  @override
  int get hashCode => Object.hash(value, amount);

  Json toJson(ToJson<T> toJson) {
    Json json = toJson(value);
    json['\$stack'] = amount;
    return json;
  }

  static Stack<T> fromJson<T>(Json json, FromJson<T> fromJson) {
    return Stack(value: fromJson(json), amount: json['\$stack'] ?? 1);
  }
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
    return identical(this, other) ||
        (runtimeType == other.runtimeType && other is DecoStack && value.name == other.value.name);
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
      weapon: All.dummyWeapon, requiredSkills: skills.toList(), decorations: null, charms: null, blacklistedArmor: {});
  _SearchConfig cfg = _SearchConfig(args);
  var tryer = _ArmorSetTryer.of(config: cfg, decos: cfg.decos);
  ArmorSet? set = tryer.tryArmor(cfg.helmets[0], cfg.chests[0], cfg.arms[0], cfg.waists[0], cfg.legs[0], cfg.charms[0]);
  log.info(set?.toJson());
}

typedef DataReceiver = void Function(Object?);

//Thread? _currentThread;

class Thread {
  final int id;
  final Isolate isolate;
  final ReceivePort receivePort;
  final SendPort sendPort;

  Thread._(this.id, this.isolate, this.receivePort, this.sendPort);

  static Future<Thread> create(int id, DataReceiver receiver) async {
    final ReceivePort receivePort = ReceivePort();
    var sub = receivePort.listen((_) {});
    var futSendPort = _receiveSendPort(sub);
    Isolate isolate = await Isolate.spawn(_entry, receivePort.sendPort);
    SendPort sendPort = await futSendPort;
    sub.onData(receiver);
    return Thread._(id, isolate, receivePort, sendPort);
  }

  static Future<SendPort> _receiveSendPort(StreamSubscription<dynamic> sub) async {
    final completer = Completer<SendPort>();
    sub.onData((d) {
      if (d is SendPort) {
        completer.complete(d);
      }
    });
    return completer.future;
  }

  @pragma('vm:entry-point')
  static _entry(SendPort port) async {
    var eventQueue = [];
    var processMsgQueue = [];
    ReceivePort receivePort = ReceivePort();
    var sub = receivePort.listen((_) {});
    port.send(receivePort.sendPort);
    int id = await _initPort(sub);
    //_currentThread = Thread._(id, Isolate.current, receivePort, port);
    log.info('Started isolate $id');
    sub.onData((msg) {
      if (msg is Map) {
        if (msg.containsKey('StartSearch')) {
          eventQueue.add(msg);
          return;
        }
      }
      processMsgQueue.add(msg);
    });
    // event loop
    while (true) {
      // wait 50 ms
      await Future.delayed(Duration(milliseconds: 50));
      // check any events (currently only start search)
      while (eventQueue.isNotEmpty) {
        var msg = eventQueue.removeAt(0);
        var data = msg['StartSearch'];
        if (data is Json) {
          log.info('Received search command');
          _SearchConfig config = _SearchConfig.fromJson(data);
          _ArmorSetTryer.search(config, port, processMsgQueue, id);
        }
      }
    }
  }

  static Future<int> _initPort(StreamSubscription sub) async {
    // called in isolate
    var completer = Completer<int>();
    int id = -1;
    bool gotData = false;
    sub.onData((msg) {
      if (msg is Map) {
        var data = msg['allData'];
        if (data is Json) {
          All.allFromJson(data);
          gotData = true;
          if (id >= 0) {
            completer.complete(id);
          }
          return;
        }
        data = msg['id'];
        if (data is int) {
          id = data;
          if (gotData) {
            completer.complete(id);
          }
          return;
        }
        log.error('Received MSG before init');
      }
    });
    return completer.future;
  }
}

// class to handle multiple isolates for searching armor sets
class SearchManager {
  static final List<Thread> _threads = [];
  static final List<bool> _processState = [];
  static SearchResult? result;
  static int count = 0;

  static init() async {
    int maxProcesses = 1;
    Json allData = All.allToJson();
    for (int id = 0; id < maxProcesses; id++) {
      Thread thread = await Thread.create(id, (msg) {
        if (msg is int) {
          if (msg == -1) {
            count++;
            //double prog = count / result.totalArmorSets;
            //if (prog - lastProg >= 0.01) { // this makes the ui lag a lot more than the line below and i have no idea why
            if (count % 1000 == 0) {
              //lastProg = prog;
              result!.processedArmorSets.add(count);
            }
          }
        } else if (msg is Map<String, dynamic>) {
          result!.armorSetStream.add(ArmorSet.fromJson(msg));
        } else if (msg is String) {
          if (msg.startsWith('done')) {
            log.info('Isolate $id done');
            _processState[id] = false;
            if (_processState.every((s) => !s)) {
              log.info('All isolates done');
              _finalizeProcess();
            }
            return;
          }
          log.info('Msg from Isolate: $msg');
        }
      });
      thread.sendPort.send({'id': id});
      thread.sendPort.send({'allData': allData});
      _threads.add(thread);
      _processState.add(false);
    }
  }

  static void dispose() {
    for (Thread thread in _threads) {
      thread.isolate.kill();
    }
    _threads.clear();
    _processState.clear();
  }

  static void cancelArmorSearch() {
    if (result == null) return;
    log.info('Try canceling search.');
    for (Thread thread in _threads) {
      thread.sendPort.send('cancel');
    }
  }

  static void _finalizeProcess() {
    result?.processedArmorSets.add(count);
    result?.processedArmorSets.close();
    result?.armorSetStream.close();
    result = null;
    count = 0;
  }

  static bool get isProcessActive => _processState.any((b) => b);

  static SearchResult searchAllArmorCombinations(SearchArguments arguments) {
    if (isProcessActive) throw Exception('Process is already active');
    result = SearchResult();
    count = 0;
    _SearchConfig cfg = _SearchConfig(arguments);
    Object msg = {'StartSearch': cfg.toJson()};
    result!.totalArmorSets = cfg.estimatedCombinations;
    for (int i = 0; i < _threads.length; i++) {
      _processState[i] = true;
      _threads[i].sendPort.send(msg);
    }
    return result!;
  }
}

// everything here runs in an isolate
// an instance can try out an armor set to see if it has the required armor skills
class _ArmorSetTryer {
  static search(_SearchConfig config, SendPort sendPort, List msgQueue, int id) async {
    var tryer = _ArmorSetTryer.of(config: config, decos: config.decos);
    sendPort.send('Searching on Isolate $id');
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
              isCanceled(sendPort, msgQueue).then((c) => canceled = c); // must use then to not block computation
              await Future.delayed(Duration.zero); // give the async canceled check time to compute
            }
          }
        }
      }
    }
    sendPort.send('done');
  }

  static Future _searchInner(SendPort sendPort, _SearchConfig config, _ArmorSetTryer tryer, Armor helm, Armor chest,
      Armor arm, Armor waist, Armor leg) async {
    for (var charm in config.charms) {
      ArmorSet? set = tryer.tryArmor(helm, chest, arm, waist, leg, charm);
      sendPort.send(-1);
      if (set != null) {
        sendPort.send(set.toJson());
      }
    }
  }

  static Future<bool> isCanceled(SendPort sendPort, List queue) async {
    // if we use while here it will empty the stream completely and therefore close the communication and the isolate
    while (queue.isNotEmpty) {
      var msg = queue.removeAt(0);
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
    for (Stack<SkillTemplate> skill in config.requiredSkills.values) {
      skills[skill.value] = skill.copy();
    }
    addEquipmentSkills(config.weapon);
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
    if (!setBonusTryer.tryDecos() || !groupBonusTryer.tryDecos()) {
      return null; // fast early check
    }
    weaponTryer.init(decos, skills.values);
    armorTryer.init(decos, skills.values);
    weaponTryer.addEquipmentSlots(config.weapon);
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
        if (_insertDeco(config.weapon, weaponDecos, deco, size)) {
          break;
        }
        size++; // no empty slot found, try bigger size
      }
      if (size == 4) {
        log.error('Decos was inserted before, but no fitting slot in weapon was found');
      }
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
      if (size == 4) {
        log.error('Decos was inserted before, but no fitting slot in armor was found');
      }
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
      if (!skills.containsKey(deco.primary) && (!deco.hasSec || !skills.containsKey(deco.secondary!))) {
        continue;
      }
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
    if (deco.value.hasSec) {
      _ArmorSetTryer._skill(skills, deco.value.secondary!, 1);
    }
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
    if (size > 3) {
      log.error('Before inserting there was space for deco, but now there isn\'t anymore!');
    }
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
