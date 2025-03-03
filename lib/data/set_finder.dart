import 'dart:math';

import 'package:brachys_armor_set_searcher/main.dart';
import 'package:flutter/material.dart';

import 'equipment.dart';

class SearchConfig {
  final Map<String, Stack<SkillTemplate>> requiredSkills;
  final Map<Deco, int>? decorations;
  final int minRarity, maxRarity;
  final Set<Armor> blacklistedArmor;
  late final int estimatedCombinations;
  final List<Armor> helmets = [];
  final List<Armor> chests = [];
  final List<Armor> arms = [];
  final List<Armor> waists = [];
  final List<Armor> legs = [];
  final List<Deco> decos = [];

  SearchConfig(this.blacklistedArmor, {required this.requiredSkills, this.decorations, required this.minRarity, required this.maxRarity}) {
    // TODO: compute armor values
    for (var skill in requiredSkills.keys) {
      _addArmor(helmets, All.helmets[skill]);
      _addArmor(chests, All.chests[skill]);
      _addArmor(arms, All.arms[skill]);
      _addArmor(waists, All.waists[skill]);
      _addArmor(legs, All.legs[skill]);
      Set<Deco> decoSet = {};
      for (var deco in All.decosMap[skill] ?? []) {
        if (hasDeco(deco)) {
          decoSet.add(deco);
        }
      }
      decos.addAll(decoSet);
      decos.sort((d1, d2) => d2.size.compareTo(d1.size));
    }
    estimatedCombinations = helmets.length * chests.length * arms.length * waists.length * legs.length;
    log('Searching $estimatedCombinations combinations');
  }

  bool hasDeco(Deco deco) {
    return getDecoAmount(deco) > 0;
  }

  int getDecoAmount(Deco deco) {
    if (decorations == null) {
      if (deco.secondary != null) {
        return max(deco.primary.maxLevel, deco.secondary!.maxLevel);
      }
      return deco.primary.maxLevel;
    }
    return decorations![deco] ?? 0;
  }

  void _addArmor(List<Armor> validArmor, List<Armor>? allArmor) {
    if (allArmor != null) {
      for (var armor in allArmor) {
        if (armor.rarity >= minRarity && armor.rarity <= maxRarity && !blacklistedArmor.contains(armor)) {
          validArmor.add(armor);
        }
      }
    }
  }
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

class ArmorSet {
  final List<Deco> weaponDecos;
  final List<EquipmentPiece> pieces;

  ArmorSet({required this.weaponDecos, required this.pieces});
}

class EquipmentPiece {
  final Equipment equipment;
  final List<Deco> decorations;

  EquipmentPiece({required this.equipment, required this.decorations});
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

class DecoStack extends Stack<Deco> {
  bool doubleVal;

  DecoStack({required super.value, super.amount, this.doubleVal = false});

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
}

class DecoList {
  final List<DecoStack> doubleValue = [];
  final List<DecoStack> normal = [];

  void add(DecoStack deco) {
    if (deco.doubleVal) {
      doubleValue.add(deco);
    } else {
      normal.add(deco);
    }
  }

  bool get isEmpty => doubleValue.isEmpty && normal.isEmpty;

  int get length => doubleValue.length + normal.length;

  DecoStack get first {
    if (doubleValue.isEmpty) return normal.first;
    return doubleValue.first;
  }

  void removeWhere(bool Function(DecoStack deco) test) {
    doubleValue.removeWhere(test);
    normal.removeWhere(test);
  }
}

class SkillProp extends DecoList {}

Stream<ArmorSet?> searchAllArmorCombinations(SearchConfig config) async* {
  yield* _ArmorSetTryer.search(config);
}

class _ArmorSetTryer {

  static Stream<ArmorSet?> search(SearchConfig config) async* {
    var tryer = _ArmorSetTryer(config: config, decos: config.decos);
    for (var helm in config.helmets) {
      for (var chest in config.chests) {
        for (var arm in config.arms) {
          for (var waist in config.waists) {
            for (var leg in config.legs) {
              yield tryer.tryArmor(helm, chest, arm, waist, leg);
            }
          }
        }
      }
    }
  }

  final SearchConfig config;
  final List<Armor> armor = List.filled(5, All.dummyArmor);
  final List<Deco> decos;
  final List<int> slots = List.filled(4, 0);
  final Map<String, Stack<SkillTemplate>> skills = {};
  final Map<Skill, DecoList> skillDecoMap = {};
  final List<Deco> usedDecos = [];
  String? error;

  _ArmorSetTryer({required this.config, required this.decos});

  ArmorSet? tryArmor(Armor helm, Armor chest, Armor arm, Armor waist, Armor leg) {
    armor[0] = helm;
    armor[1] = chest;
    armor[2] = arm;
    armor[3] = waist;
    armor[4] = leg;
    slots.fillRange(0, 4, 0);
    skills.clear();
    skills.addAll(config.requiredSkills);
    for (var armor in armor) {
      if (armor.primarySlotSize > 0) slots[armor.primarySlotSize]++;
      if (armor.secondarySlotSize > 0) slots[armor.secondarySlotSize]++;
      if (armor.ternarySlotSize > 0) slots[armor.ternarySlotSize]++;
      _skill(skills, armor.primary, armor.primaryLv);
      if (armor.secondary != null) _skill(skills, armor.secondary!, armor.secondaryLv);
      if (armor.armorBonus != null) _skill(skills, armor.armorBonus!, armor.ternaryLv);
    }
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
    // test map
    // we simulate inserting every deco we have regardless of space at the same time
    // if the skill levels dont add to the required levels it is impossible to make this set
    Map<String, Stack<SkillTemplate>> reqSkills = skills.map((key, value) => MapEntry(key, value.copy()));
    skillDecoMap.clear();
    usedDecos.clear();
    for (var deco in decos) {
      // check if deco skills are still required
      if (!skills.containsKey(deco.primary.name) && (!deco.hasSec || !skills.containsKey(deco.secondary!.name))) continue;
      var decoStack = DecoStack(value: deco, amount: config.getDecoAmount(deco));
      if (deco.size == 4 && (!deco.hasSec || skills[deco.secondary!.name] != null)) {
        // TODO there are decos with triple value
        decoStack.doubleVal = true;
      }
      // add primary skill
      _skill(reqSkills, deco.primary, deco.primaryLvl);
      skillDecoMap.putIfAbsent(deco.primary, () => DecoList()).add(decoStack);
      if (deco.hasSec) {
        // add secondary skill
        _skill(reqSkills, deco.secondary!, 1);
        skillDecoMap.putIfAbsent(deco.secondary!, () => DecoList()).add(decoStack);
      }
    }
    if (reqSkills.isNotEmpty) {
      // not all skill requirements met
      error = 'Decos cant make required skills';
      return null;
    }
    // roll back
    reqSkills = skills.map((key, value) => MapEntry(key, value.copy()));
    return _insertDecos(reqSkills);
  }

  ArmorSet? _insertDecos(Map<String, Stack<SkillTemplate>> reqSkills) {
    List<Skill> sortedSkills = skillDecoMap.keys.toList(growable: true);
    bool hasDoubleVal = slots[3] > 0; // any level 4 slots
    bool changed = true;
    while (changed && slots.isNotEmpty && reqSkills.isNotEmpty) {
      changed = false;
      _sortSkills(sortedSkills, reqSkills);
      var skill = hasDoubleVal
          ? sortedSkills.firstWhere((element) => skillDecoMap[element]!.doubleValue.isNotEmpty, orElse: () {
              hasDoubleVal = false;
              return sortedSkills.first;
            })
          : sortedSkills.first;
      var decos = skillDecoMap[skill]!;
      var deco = decos.first;
      Stack<SkillTemplate>? skill1 = reqSkills[deco.value.primary], skill2 = deco.value.hasSec ? reqSkills[deco.value.secondary] : null;
      if (skill1 != null) {
        _skill(reqSkills, skill1.value, deco.value.primaryLvl);
        if (skill2 != null) _skill(reqSkills, skill2.value, 1);
        slots[deco.value.size - 1] -= 1;
        if (slots[deco.value.size - 1] <= 0) {
          _cleanDecoList(reqSkills);
        }
        usedDecos.add(deco.value);
        changed = true;
        deco.decr(1);
      }
    }

    if (reqSkills.isEmpty) {
      // success
      return _makeArmorSet();
    }
    return null;
  }

  ArmorSet _makeArmorSet() {
    return ArmorSet(weaponDecos: [], pieces: []);
  }

  void _addDeco(Deco deco, int amount) {
    for (int i = 0; i < amount; i++) {
      usedDecos.add(deco);
    }
  }

  void _sortSkills(List<SkillTemplate> sortedSkills, Map<String, Stack<SkillTemplate>> reqSkills) {
    sortedSkills.removeWhere((e) {
      var s = skillDecoMap[e];
      return s == null || s.isEmpty;
    });
    sortedSkills.sort((s1, s2) => (reqSkills[s2.name]?.amount ?? 0).compareTo(reqSkills[s1.name]?.amount ?? 0));
  }

  void _cleanDecoList(Map<String, Stack<SkillTemplate>> reqSkills) {
    skillDecoMap.removeWhere((key, value) {
      value.removeWhere((deco) {
        if (deco.amount <= 0 || slots[deco.value.size - 1] <= 0) return true;
        deco.doubleVal = deco.value.size == 4 && (!deco.value.hasSec || reqSkills[deco.value.secondary!.name] != null);
        return false;
      });
      return value.isEmpty;
    });
  }

  /// removes a certain amount of required skill levels
  void _skill(Map<String, Stack<SkillTemplate>> skills, SkillTemplate skill, int amount) {
    Stack<SkillTemplate>? lv = skills[skill.name];
    if (lv != null && lv.decr(amount)) {
      skills.remove(skill.name);
    }
  }

  bool isValid() {
    return armor[0] != All.dummyArmor && skills.isEmpty;
  }
}
