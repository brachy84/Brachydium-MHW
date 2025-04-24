import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import 'package:brachys_armor_set_searcher/data/util.dart';
import 'package:brachys_armor_set_searcher/screen/search_results.dart';
import 'package:flutter/material.dart';

import 'equipment.dart';

class SearchArguments {
  final Weapon weapon;
  final Map<SkillTemplate, Leveled<SkillTemplate>> requiredSkills;
  final Map<Deco, int>? decorations;
  final Set<Charm>? charms;
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
      required List<Leveled<SkillTemplate>> requiredSkills,
      required Map<Deco, int>? decorations,
      required Map<CharmFamily, int>? charms,
      int minRarity = 0,
      int maxRarity = 12,
      required Set<Armor> blacklistedArmor}) {
    return SearchArguments(
        weapon: weapon,
        requiredSkills: Map.fromEntries(requiredSkills.map((s) => MapEntry(s.value, s))),
        decorations: decorations,
        charms: charms?.entries.where((e) => e.value > 0).map((e) => e.key[e.value]).toSet(),
        minRarity: minRarity,
        blacklistedArmor: blacklistedArmor);
  }

  bool canCharmBeUsed(Charm charm) {
    if (charms == null) {
      return All.charmFamilies[charm]!.last == charm;
    }
    return charms!.contains(charm);
  }
}

class _ValueArmor implements Comparable<_ValueArmor> {
  final Armor armor;
  final int value;

  _ValueArmor(this.armor, this.value);

  factory _ValueArmor.create(Armor armor, Map<SkillTemplate, Leveled<SkillTemplate>> skills) {
    int skillValue = _evaluateSkillValue(armor.primary, armor.primaryLv, skills);
    skillValue += _evaluateSkillValue(armor.secondary, armor.secondaryLv, skills);
    skillValue += _evaluateSkillValue(armor.ternary, armor.ternaryLv, skills);
    skillValue += _evaluateSkillValue(armor.setBonus, 1, skills);
    skillValue += _evaluateSkillValue(armor.groupBonus, 1, skills);
    int slotValue = armor.primarySlotSize + armor.secondarySlotSize + armor.ternarySlotSize;
    return _ValueArmor(armor, skillValue * 12 + slotValue * 10);
  }

  static int _evaluateSkillValue(SkillTemplate? skill, int lvl, Map<SkillTemplate, Leveled<SkillTemplate>> skills) {
    return skill != null && skills.containsKey(skill) ? lvl : 0;
  }

  @override
  int compareTo(_ValueArmor other) {
    return other.value.compareTo(value);
  }
}

class _SearchConfig {
  final Weapon weapon;
  final Map<SkillTemplate, Leveled<SkillTemplate>> requiredSkills;
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
    // sets to avoid duplicate armor pieces which have multiple required skills
    final Set<Armor> helmets = {};
    final Set<Armor> chests = {};
    final Set<Armor> arms = {};
    final Set<Armor> waists = {};
    final Set<Armor> legs = {};
    final Set<Charm> charms = {};
    final List<Deco> decos = [];
    for (Leveled<SkillTemplate> skill in args.requiredSkills.values) {
      _addArmor(args, helmets, All.helmets[skill.value]);
      _addArmor(args, chests, All.chests[skill.value]);
      _addArmor(args, arms, All.arms[skill.value]);
      _addArmor(args, waists, All.waists[skill.value]);
      _addArmor(args, legs, All.legs[skill.value]);
      charms.addAll(All.charms[skill.value]?.where((c) => args.canCharmBeUsed(c)) ?? []);
      Set<Deco> decoSet = {};
      for (var deco in All.decosMap[skill.value] ?? []) {
        if (_hasDeco(args.decorations, deco)) {
          decoSet.add(deco);
        }
      }
      decos.addAll(decoSet);
      decos.sort((d1, d2) => d2.size.compareTo(d1.size));
    }
    int estimatedCombinations =
        helmets.length * chests.length * arms.length * waists.length * legs.length * charms.length;
    log.info('Searching $estimatedCombinations combinations');
    return _SearchConfig._(args.weapon, args.requiredSkills, args.decorations, estimatedCombinations, _sortList(args, helmets), _sortList(args, chests),
        _sortList(args, arms), _sortList(args, waists), _sortList(args, legs), charms.toList(growable: false), decos);
  }

  Json toJson() {
    Json json = {};
    json['skills'] = requiredSkills.map((k, v) => MapEntry(v.value.name, v.level));
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
    List<Leveled<SkillTemplate>> requiredSkills =
        (json['skills'] as Json).entries.map((e) => Leveled(value: All.allSkills[e.key]!, level: e.value)).toList();
    Map<SkillTemplate, Leveled<SkillTemplate>> skills = {};
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

  static List<Armor> _sortList(SearchArguments args, Set<Armor> set) {
    var copy = set.map((a) => _ValueArmor.create(a, args.requiredSkills)).toList(growable: false);
    copy.sort();
    return copy.map((as) => as.armor).toList(growable: false);
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

  static void _addArmor(SearchArguments args, Set<Armor> validArmor, List<Armor>? allArmor) {
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

  List<_SearchConfig> splitIntoMultiple(int amount) {
    if (amount == 0) throw Exception();
    if (amount == 1) return [this];
    List<List<Armor>> armors = [helmets, chests, arms, waists, legs];
    int index = NestedListHelper.getLargest(armors, (l) => l.length % amount == 0);
    if (index >= 0) {
      return _splitExact(amount, armors, index);
    }
    return _split(amount, armors, NestedListHelper.getLargest(armors));
  }

  List<_SearchConfig> _splitExact(int amount, List<List<Armor>> armors, int index) {
    List<List<List<Armor>>> splittedArmors =
        List.generate(amount, (i) => List.of(armors, growable: false), growable: false);
    List<Armor> listToSplit = armors[index];
    int each = (listToSplit.length / amount).toInt();
    for (int i = 0; i < amount; i++) {
      splittedArmors[i][index] = [];
      for (int j = 0; j < each; j++) {
        splittedArmors[i][index].add(listToSplit[j * amount + i]);
      }
    }
    return splittedArmors
        .map((armors) => _SearchConfig._(
            weapon,
            requiredSkills,
            decorations,
            armors.map((l) => l.length).reduce((a, b) => a * b) * charms.length,
            armors[0],
            armors[1],
            armors[2],
            armors[3],
            armors[4],
            charms,
            decos))
        .toList();
  }

  List<_SearchConfig> _split(int amount, List<List<Armor>> armors, int index) {
    List<Armor> listToSplit = armors[index];
    if ((listToSplit.length / amount).floor() == 0) {
      return _splitExact(listToSplit.length % amount, armors, index);
    }
    List<List<List<Armor>>> splittedArmors =
        List.generate(amount, (i) => List.of(armors, growable: false), growable: false);
    int each = (listToSplit.length / amount).ceil();
    for (int i = 0; i < amount; i++) {
      splittedArmors[i][index] = [];
      for (int j = 0; j < each; j++) {
        int armorIndex = j * amount + i;
        if (armorIndex >= listToSplit.length) break; // do not break outer
        splittedArmors[i][index].add(listToSplit[j * amount + i]);
      }
    }
    return splittedArmors
        .map((armors) => _SearchConfig._(
            weapon,
            requiredSkills,
            decorations,
            armors.map((l) => l.length).reduce((a, b) => a * b) * charms.length,
            armors[0],
            armors[1],
            armors[2],
            armors[3],
            armors[4],
            charms,
            decos))
        .toList();
  }
}

class SearchResult {
  SearchResult();

  int totalArmorSets = 0;
  bool likelyDone = false;

  DataStream<int> processedArmorSets = DataStream(StreamController());
  DataStream<List<ArmorSet>> armorSetStream = DataStream(StreamController());
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

void testSearch() {
  var skills = ['burst', 'antivirus', 'weakness-exploit', 'critical-boost']
      .map((s) => Skill.fromString(s))
      .map((s) => Leveled(value: s, level: s.maxLevel));
  SearchArguments args = SearchArguments.of(
      weapon: All.dummyWeapon, requiredSkills: skills.toList(), decorations: null, charms: null, blacklistedArmor: {});
  _SearchConfig cfg = _SearchConfig(args);
  var tryer = _ArmorSetTryer.of(config: cfg, decos: cfg.decos);
  ArmorSet? set = tryer.tryArmor(cfg.helmets[0], cfg.chests[0], cfg.arms[0], cfg.waists[0], cfg.legs[0], cfg.charms[0]);
  log.info(set?.toJson());
}

class Vec6 implements Comparable<Vec6> {
  static const Vec6 zero = Vec6._(0, 0, 0, 0, 0, 0, 0);

  final int head, chest, arm, waist, leg, charm, sqDist;

  const Vec6._(this.head, this.chest, this.arm, this.waist, this.leg, this.charm, this.sqDist);

  factory Vec6(int head, int chest, int arm, int waist, int leg, int charm) {
    return Vec6._(head, chest, arm, waist, leg, charm,
        head * head + chest * chest + arm * arm + waist * waist + leg * leg + charm * charm);
  }

  @override
  int compareTo(Vec6 other) {
    return sqDist.compareTo(other.sqDist);
  }
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
          log.info('Received search command $id');
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
  static final List<bool> _likelyDone = [];
  static SearchResult? result;
  static int count = 0;
  static final int milliesBetweenSend = 50;
  static int _lastSend = 0;
  static List<ArmorSet> cachedSets = [];
  static int _lastSendArmor = 0;

  static init() async {
    // Flutter can max use 8 Isolates, so we can only add 7
    // this is a major design flaw in the dart sdk
    // TODO: implement searching with native code
    int maxProcesses = max(1, min(7, (Platform.numberOfProcessors - 2)));
    log.info('Search Threads: $maxProcesses');
    Json allData = All.allToJson();
    for (int id = 0; id < maxProcesses; id++) {
      Thread thread = await Thread.create(id, (msg) async {
        if (msg is int) {
          count += msg;
          var now = DateTime.timestamp().millisecondsSinceEpoch;
          if (now - _lastSend >= milliesBetweenSend) {
            result!.processedArmorSets.add(count);
            _lastSend = now;
          }
        } else if (msg is Map<String, dynamic>) {
          scheduleMicrotask(() {
            cachedSets.add(ArmorSet.fromJson(msg));
            _checkSendArmor();
          });
        } else if (msg is List<Map<String, dynamic>>) {
          scheduleMicrotask(() {
            cachedSets.addAll(msg.map((j) => ArmorSet.fromJson(j)));
            _checkSendArmor();
          });
        } else if (msg is String) {
          if (msg == 'done') {
            log.info('Isolate $id done');
            _processState[id] = false;
            if (_processState.every((s) => !s)) {
              log.info('All isolates done');
              _finalizeProcess();
            }
            return;
          }
          if (msg == 'ldone') {
            log.info('Isolate $id is likely done');
            _likelyDone[id] = true;
            if (_likelyDone.every((b) => b)) {
              log.info('All isolates are likely done');
              result!.likelyDone = true; // TODO do something with it
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
      _likelyDone.add(true);
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

  static void _checkSendArmor() {
    var now = DateTime.timestamp().millisecondsSinceEpoch;
    if (now - _lastSendArmor >= milliesBetweenSend) {
      result!.armorSetStream.add(cachedSets);
      cachedSets = [];
      _lastSendArmor = now;
    }
  }

  static void _finalizeProcess() {
    result?.processedArmorSets.add(count);
    if (cachedSets.isNotEmpty) {
      result?.armorSetStream.add(cachedSets);
    }
    result?.processedArmorSets.close();
    result?.armorSetStream.close();
    result = null;
    count = 0;
    cachedSets = [];
  }

  static bool get isProcessActive => _processState.any((b) => b);

  static SearchResult searchAllArmorCombinations(SearchArguments arguments) {
    if (isProcessActive) throw Exception('Process is already active');
    result = SearchResult();
    count = 0;
    cachedSets = [];
    _SearchConfig cfg = _SearchConfig(arguments);
    result!.totalArmorSets = cfg.estimatedCombinations;
    List<_SearchConfig> splitConfigs = cfg.splitIntoMultiple(_threads.length);
    int max = min(splitConfigs.length, _threads.length);
    for (int i = 0; i < max; i++) {
      _processState[i] = true;
      _likelyDone[i] = false;
      _threads[i].sendPort.send({'StartSearch': splitConfigs[i].toJson()});
    }
    return result!;
  }
}

class CuboidIndexer {
  final int a, b, c, d, e, f;
  final int totalSize;

  int _manhattanDistance = 0;
  int _i = 0;
  int _j = 0;
  int _k = 0;
  int _l = 0;
  int _m = 0;
  int _index = 0;

  CuboidIndexer._(this.a, this.b, this.c, this.d, this.e, this.f, this.totalSize);

  factory CuboidIndexer(int a, int b, int c, int d, int e, int f) {
    return CuboidIndexer._(a, b, c, d, e, f, a * b * c * d * e * f);
  }

  bool nextIndex(void Function(int i, int j, int k, int l, int m, int n) consumer) {
    while (_index < totalSize && _manhattanDistance <= a + b + c + d + e + f) {
      while (_i <= _manhattanDistance && _i < a) {
        while (_j <= _manhattanDistance && _j < b) {
          while (_k <= _manhattanDistance && _k < c) {
            while (_l <= _manhattanDistance && _l < d) {
              while (_m <= _manhattanDistance - _i - _j - _k - _l && _m < e) {
                int z = _manhattanDistance - _i - _j - _k - _l - _m;
                if (z < f) {
                  consumer(_i, _j, _k, _l, _m, z);
                  _m++;
                  _index++;
                  return true;
                }
                _m++;
              }
              _m = 0;
              _l++;
            }
            _l = 0;
            _k++;
          }
          _k = 0;
          _j++;
        }
        _j = 0;
        _i++;
      }
      _i = 0;
      _manhattanDistance++;
    }
    return false;
  }
}

// everything here runs in an isolate
// an instance can try out an armor set to see if it has the required armor skills
class _ArmorSetTryer {
  static search(_SearchConfig config, SendPort sendPort, List msgQueue, int id) async {
    var tryer = _ArmorSetTryer.of(config: config, decos: config.decos);
    log.info('Searching on Isolate $id');
    //var indexes = _buildIndexes(config);
    var indexer = CuboidIndexer(config.helmets.length, config.chests.length, config.arms.length, config.waists.length, config.legs.length, config.charms.length);
    bool canceled = false;
    final int batchSize = 1000;
    final int likelyDoneThreshold = (config.estimatedCombinations * 0.2).floor();
    final int armorThreshold = (config.estimatedCombinations * 0.02).floor();
    int lastArmor = 0;
    bool likelyDone = false;
    for (int i = 0; i < config.estimatedCombinations; i += batchSize) {
      if (canceled) {
        sendPort.send('done');
        return;
      }
      if (await _searchInner2(sendPort, config, tryer, indexer, batchSize)) {
        lastArmor = i;
      } else if (!likelyDone && i > likelyDoneThreshold && i - lastArmor >= armorThreshold) {
        likelyDone = true;
        sendPort.send('ldone');
      }
      isCanceled(sendPort, msgQueue).then((c) => canceled = c); // must use then to not block computation
      await Future.delayed(Duration.zero); // give the async canceled check time to compute
    }
    sendPort.send('done');
  }

  static List<Vec6> _buildIndexes(_SearchConfig config) {
    // causes memory problems
    // list of indexes for the 6 dimensional tensor of equipment + charm
    List<Vec6> indexes = List.filled(config.estimatedCombinations, Vec6.zero);
    int head = 0, chest = 0, arm = 0, waist = 0, leg = 0, charm = 0;
    final int headM = config.helmets.length,
        chestM = config.chests.length,
        armM = config.arms.length,
        waistM = config.waists.length,
        legM = config.legs.length,
        charmM = config.charms.length;
    for (int i = 0; i < indexes.length; i++) {
      indexes[i] = Vec6(head, chest, arm, waist, leg, charm);
      if (++charm == charmM) {
        charm = 0;
        if (++leg == legM) {
          leg = 0;
          if (++waist == waistM) {
            waist = 0;
            if (++arm == armM) {
              arm = 0;
              if (++chest == chestM) {
                chest = 0;
                if (++head == headM && i != indexes.length - 1) {
                  throw Exception();
                }
              }
            }
          }
        }
      }
    }
    // equipment list is sorted so that best ones come first
    // this sorting makes sure armor sets which are more likely to produce a matching set come first
    indexes.sort();
    return indexes;
  }

  static Future<bool> _searchInner2(
      SendPort sendPort, _SearchConfig config, _ArmorSetTryer tryer, CuboidIndexer indexer, int batchSize) async {
    List<ArmorSet>? sets;
    for (int j = 0; j < batchSize; j++) {
      bool result = indexer.nextIndex((i, j, k, l, m, n) {
        var set = tryer.tryArmor(config.helmets[i], config.chests[j], config.arms[k], config.waists[l], config.legs[m], config.charms[n]);
        if (set != null) {
          sets ??= [];
          sets!.add(set);
        }
      });
      if (!result) {
        batchSize = j + 1;
        break;
      }
    }
    sendPort.send(batchSize); // only send after a batch, sending every set would block the main isolate cause of the amount of messages
    if (sets != null) {
      if (sets!.length == 1) {
        sendPort.send(sets![0].toJson());
      } else {
        sendPort.send(sets!.map((set) => set.toJson()).toList());
      }
      return true;
    }
    return false;
  }

  static _searchInner(
      SendPort sendPort, _SearchConfig config, _ArmorSetTryer tryer, List<Vec6> indexes, int start, int end) async {
    List<ArmorSet>? sets;
    for (int i = start; i < end; i++) {
      ArmorSet? set = tryer.tryArmorFrom(config, indexes[i]);
      if (set != null) {
        sets ??= [];
        sets.add(set);
      }
    }
    sendPort.send(end - start); // only send after a batch, sending every set would block the main isolate cause of the amount of messages
    if (sets != null) {
      if (sets.length == 1) {
        sendPort.send(sets[0].toJson());
      } else {
        sendPort.send(sets.map((set) => set.toJson()).toList());
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
  final Map<SkillTemplate, Leveled<SkillTemplate>> skills = {};
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

  ArmorSet? tryArmorFrom(_SearchConfig config, Vec6 vec) {
    return tryArmor(config.helmets[vec.head], config.chests[vec.chest], config.arms[vec.arm], config.waists[vec.waist],
        config.legs[vec.leg], config.charms[vec.charm]);
  }

  ArmorSet? tryArmor(Armor helm, Armor chest, Armor arm, Armor waist, Armor leg, Charm charm) {
    armor[0] = helm;
    armor[1] = chest;
    armor[2] = arm;
    armor[3] = waist;
    armor[4] = leg;
    this.charm = charm;
    skills.clear();
    for (Leveled<SkillTemplate> skill in config.requiredSkills.values) {
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
  static _skill(Map<SkillTemplate, Leveled<SkillTemplate>> skills, SkillTemplate skill, int amount) {
    Leveled<SkillTemplate>? lv = skills[skill];
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
  final Map<SkillTemplate, Leveled<SkillTemplate>> skills = {};
  final Map<SkillTemplate, List<LeveledDeco>> skillDecoMap = {};
  final List<Deco> usedDecos = [];
  String? error;

  _DecoTryer(this.type, this.config);

  init(List<Deco> decos, Iterable<Leveled<SkillTemplate>> skills) {
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
    Map<SkillTemplate, Leveled<SkillTemplate>> reqSkills = skills.map((key, value) => MapEntry(key, value.copy()));
    skillDecoMap.clear();
    usedDecos.clear();
    for (var deco in decos) {
      // check if deco skills are still required
      if (!skills.containsKey(deco.primary) && (!deco.hasSec || !skills.containsKey(deco.secondary!))) {
        continue;
      }
      var decoStack = LeveledDeco(value: deco, level: config.getDecoAmount(deco));
      decoStack.checkTotalPoints(skills);
      // add primary skill
      _ArmorSetTryer._skill(reqSkills, deco.primary, deco.primaryLvl * decoStack.level);
      skillDecoMap.putIfAbsent(deco.primary, () => []).add(decoStack);
      if (deco.hasSec) {
        // add secondary skill
        _ArmorSetTryer._skill(reqSkills, deco.secondary!, decoStack.level);
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

  bool canInsert(LeveledDeco deco) {
    return deco.level > 0 && slots[deco.value.size] > 0;
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
      LeveledDeco? deco;
      for (List<LeveledDeco> decos in skillDecoMap.values) {
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

  Leveled<SkillTemplate> _findBestSkill() {
    Leveled<SkillTemplate>? highestReqSkill;
    int bestDecoValueForSkill = 0;
    for (Leveled<SkillTemplate> skill in skills.values) {
      if (highestReqSkill == null) {
        highestReqSkill = skill;
        bestDecoValueForSkill = _getBestDecoValue(skill.value);
        continue;
      }
      int bestDecoValue = _getBestDecoValue(skill.value);
      if (bestDecoValue < bestDecoValueForSkill) continue;
      if (bestDecoValue > bestDecoValueForSkill || skill.level > highestReqSkill.level) {
        highestReqSkill = skill;
        bestDecoValueForSkill = bestDecoValue;
      }
    }
    return highestReqSkill!;
  }

  bool _insertBestDeco() {
    Leveled<SkillTemplate> highestReqSkill = _findBestSkill();
    _insertDeco(skillDecoMap[highestReqSkill.value]![0]);
    return skills.isEmpty || skillDecoMap.isEmpty;
  }

  void _insertDeco(LeveledDeco deco) {
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
        return deco.totalPoints == 0 || deco.level <= 0 || !hasSlotForDecoSize(deco.value.size);
      });
      if (value.isEmpty) return true;
      value.sort();
      return false;
    });
    for (Leveled<SkillTemplate> skill in skills.values) {
      if (skillDecoMap[skill.value] == null) {
        // no decos available for a skill
        skillDecoMap.clear();
        return;
      }
    }
  }
}
