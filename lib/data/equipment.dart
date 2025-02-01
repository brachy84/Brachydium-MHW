import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:brachys_armor_set_searcher/main.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

part 'equipment.freezed.dart';
part 'equipment.g.dart';

enum Part { helm, chest, arm, waist, leg, charm }

class All {
  static const Skill undefined = Skill(name: "UNDEFINED", maxLevel: 0);
  static const Armor dummyArmor = Armor(
      name: 'dummy',
      part: Part.helm,
      rarity: 1,
      primary: undefined,
      primaryLv: 0,
      primarySlotSize: 0,
      secondarySlotSize: 0,
      ternarySlotSize: 0,
      minDef: 0,
      maxDef: 1,
      defFire: 0,
      defWater: 0,
      defThunder: 0,
      defIce: 0,
      defDragon: 0);
  static final List<Skill> skills = [];
  static final Map<String, Skill> skillsMap = {};
  static final List<ArmorBonus> armorBonuses = [];
  static final Map<String, ArmorBonus> armorBonusesMap = {};
  static final List<Deco> decos = [];
  static final List<Armor> armorList = [];
  static final Map<Skill, List<Deco>> decosMap = {};
  static final Map<SkillTemplate, List<Armor>> helmets = {};
  static final Map<SkillTemplate, List<Armor>> chests = {};
  static final Map<SkillTemplate, List<Armor>> arms = {};
  static final Map<SkillTemplate, List<Armor>> waists = {};
  static final Map<SkillTemplate, List<Armor>> legs = {};
  static final Map<SkillTemplate, List<Charm>> charms = {};
  static final Map<Part, Map<SkillTemplate, List<Armor>>> _armorBySkillByPart = {
    Part.helm: helmets,
    Part.chest: chests,
    Part.arm: arms,
    Part.waist: waists,
    Part.leg: legs
  };

  static void addSkill(String name, int maxLevel, {String? altName}) {
    String trueName = altName ?? name;
    Skill skill = Skill(name: trueName, altName: altName, maxLevel: maxLevel);
    skills.add(skill);
    skillsMap[name] = skill;
    if (altName != null) {
      skillsMap[altName] = skill;
    }
  }

  static Skill getSkill(String name) {
    if (!skillsMap.containsKey(name)) {
      if (name == undefined.name) return undefined;
      log("No skill with name $name");
      return skills[0];
    }
    return skillsMap[name]!;
  }

  static int? getArmorIndexByName(String name) {
    for (int i = 0; i < armorList.length; i++) {
      if (name == armorList[i].name) {
        return i;
      }
    }
    return null;
  }

  static Armor? getArmorByName(String name) {
    int? index = getArmorIndexByName(name);
    return index == null ? null : armorList[index];
  }

  static void replaceArmor(Armor old, Armor now) {
    int index = armorList.indexOf(old);
    armorList[index] = now;
  }

  static void replaceSkill(Skill old, Skill now) {
    int index = skills.indexOf(old);
    skills[index] = now;
  }

  static void _addEquipment<T extends Equipment>(T equipment) {
    if (equipment.part == Part.charm) {
      var map = charms;
      map.putIfAbsent(equipment.primary, () => []).add(equipment as Charm);
      if (equipment.secondary != null) {
        map.putIfAbsent(equipment.secondary!, () => []).add(equipment);
      }
      if (equipment.ternary != null) {
        map.putIfAbsent(equipment.ternary!, () => []).add(equipment);
      }
      return;
    }
    var map = _armorBySkillByPart[equipment.part]!;
    map.putIfAbsent(equipment.primary, () => []).add(equipment as Armor);
    armorList.add(equipment);
    if (equipment.secondary != null) {
      map.putIfAbsent(equipment.secondary!, () => []).add(equipment);
    }
    if (equipment.armorBonus != null) {
      map.putIfAbsent(equipment.armorBonus!, () => []).add(equipment);
    }
  }

  static void saveData() {
    _writeJsonData("data/armor.json", {'data': armorList.map((e) => e.toJson()).toList()});
    _writeJsonData("data/skills.json", {'data': skills.map((e) => e.toJson()).toList()});
  }

  static Future<void> init() async {
    const bool parseFromWeb = false;
    if (parseFromWeb) {
      await parseSkillsFromWeb();
      await parseDecosFromWeb();
      await parseCharmsFromWeb();
      await parseArmorFromHtml();
    } else {
      await parseSkillsFromJson();
      await parseArmorBonusesFromJson();
      await parseDecosFromJson();
      await parseCharmsFromJson();
      await parseArmorsFromJson();
      //await parseArmorSkillsFromWeb();
    }
  }

  static parseSkillsFromJson() async {
    final content = await rootBundle.loadString("assets/data/skills.json");
    final json = jsonDecode(content)['data'] as List;
    for (Map<String, dynamic> element in json) {
      var skill = Skill.fromJson(element);
      skills.add(skill);
      skillsMap[skill.name] = skill;
      if (skill.altName != null) {
        skillsMap[skill.altName!] = skill;
      }
    }
  }

  static parseArmorBonusesFromJson() async {
    final content = await rootBundle.loadString("assets/data/armor_bonus.json");
    final json = jsonDecode(content)['data'] as List;
    bool modifySkills = false;
    for (Map<String, dynamic> element in json) {
      var skill = ArmorBonus.fromJson(element);
      armorBonuses.add(skill);
      armorBonusesMap[skill.name] = skill;
      if (modifySkills) {
        if (skill.primarySkillSecret != null) {
          var s = skill.primarySkillSecret!;
          replaceSkill(s, s.copyWith(maxSecretLevel: max(1, s.maxLevel - 2)));
        }
        if (skill.secondarySkillSecret != null) {
          var s = skill.secondarySkillSecret!;
          replaceSkill(s, s.copyWith(maxSecretLevel: max(1, s.maxLevel - 2)));
        }
      }
    }
  }

  static parseDecosFromJson() async {
    final content = await rootBundle.loadString("assets/data/decos.json");
    final json = jsonDecode(content)['data'] as List;
    for (Map<String, dynamic> element in json) {
      var deco = Deco.fromJson(element);
      decos.add(deco);
      decosMap.putIfAbsent(deco.primary, () => []).add(deco);
      if (deco.hasSec) {
        decosMap.putIfAbsent(deco.secondary!, () => []).add(deco);
      }
    }
  }

  static parseCharmsFromJson() async {
    final content = await rootBundle.loadString("assets/data/charms.json");
    final json = jsonDecode(content)['data'] as List;
    for (Map<String, dynamic> element in json) {
      var charm = Charm.fromJson(element);
      _addEquipment(charm);
    }
  }

  static final List<String> partNamesU = [
    'Feet',
    'Barbs',
    'Claws',
    'Hide',
    'Head',
    'Greaves',
    'Coil',
    'Vambraces',
    'Mail',
    'Helm',
    'Boots',
    'Belt',
    'Chest',
    'Crown',
    'Arms',
    'Garb',
    'Braces',
    'Geta',
    'Obi',
    'Sleeve',
    'Haori',
    'Hair',
    'Gloves',
    'Cloak',
    'Armguards',
    'Faulds',
    'Spurs',
    'Spine',
    'Jacket'
  ];
  static final List<String> partNamesL = partNamesU.map((e) => e.toLowerCase()).toList();
  static final List<String> partNames = [...partNamesU, ...partNamesL];

  static parseArmorsFromJson() async {
    final content = await rootBundle.loadString("assets/data/armor.json");
    final json = jsonDecode(content)['data'] as List;
    bool applyArmorBonus = true;
    String? bonusPiece;
    ArmorBonus? bonus;
    for (Map<String, dynamic> element in json) {
      var armor = Armor.fromJson(element);
      if (applyArmorBonus) {
        if (armor.armorBonus != null) {
          bonus = armor.armorBonus;
          bonusPiece = armor.name;
        } else if (bonusPiece != null && isSameArmorSet(bonusPiece, armor.name)) {
          armor = armor.copyWith(armorBonus: bonus);
        }
      }
      _addEquipment(armor);
    }
  }

  static bool isSameArmorSet(String a1, String a2) {
    if (a1 == a2) return true;
    for (var s in partNames) {
      int i = a2.indexOf(s);
      if (i >= 0) {
        a2 = a2.substring(0, i).trimRight();
        return a1.startsWith(a2);
      }
    }
    return false;
  }

  static parseSkillsFromWeb() async {
    final response = await http.Client().get(Uri.parse('https://mhworld.kiranico.com/en/skilltrees'));
    if (response.statusCode == 200) {
      final remappedNames = {
        'Wide-Range': 'Wide Range',
        'Aquatic/Polar Mobility': 'Aquatic Expert',
        'Non-elemental Boost': 'Non-Elemental Boost'
      };
      var doc = parse(response.body);
      var table = doc.getElementsByClassName('table table-lightborder table-sm')[0].children[1];
      String? name = null;
      int lvl = 0;
      for (var el in table.children) {
        if (el.children.length == 1) {
          if (name != null && lvl > 0) {
            addSkill(name, lvl, altName: remappedNames[name]);
          }
          name = el.children[0].children[0].innerHtml;
          lvl = 0;
        } else if (name != null) {
          lvl++;
        }
      }
      _writeJsonData("data/skills.json", {'data': skills.map((e) => e.toJson()).toList()});
    } else {
      throw Exception();
    }
  }

  static parseDecosFromWeb() async {
    final response = await http.Client().get(Uri.parse('https://mhworld.kiranico.com/en/decorations'));
    if (response.statusCode == 200) {
      var doc = parse(response.body);
      var table = doc.getElementsByClassName('table table-sm')[0].children[1];
      List<Deco> decos = [];
      for (var el in table.children) {
        String name = el.children[0].children[0].children[1].innerHtml;
        var skills = el.children[1].children[0].children;
        String prim = skills[0].children[0].innerHtml;
        String? sec = skills.length > 1 ? skills[1].children[0].innerHtml : null;
        int size = int.parse(name.substring(name.length - 2));
        int primLvl = int.parse(skills[0].nodes[1].text!);
        Skill? primary = All.skillsMap[prim];
        if (primary == null) {
          log("Error getting skill $prim");
        }
        decos.add(Deco(name: name, primary: primary!, secondary: All.skillsMap[sec], primaryLvl: primLvl, size: size));
      }
      _writeJsonData("data/decos.json", {'data': decos.map((e) => e.toJson()).toList()});
    } else {
      throw Exception();
    }
  }

  static parseCharmsFromWeb() async {
    final response = await http.Client().get(Uri.parse('https://monsterhunterworld.wiki.fextralife.com/Charms'));
    if (response.statusCode == 200) {
      var doc = parse(response.body);
      var table = doc.getElementsByClassName('sortable wiki_table')[0].children[1];
      var romeToNum = {'I': 1, 'II': 2, 'III': 3, 'IV': 4, 'V': 5};
      List<Charm> allCharms = [];
      for (var el in table.children) {
        String name = el.children[2].children[0].innerHtml;
        String trueName = name;
        if (romeToNum.containsKey(name.substring(name.lastIndexOf(' ') + 1))) {
          trueName = name.substring(0, name.lastIndexOf(' '));
        }
        List<Skill?> skills = [];
        List<int> skillLevels = [];
        for (var node in el.children[3].nodes) {
          if (node.text != null) {
            String t = node.text!.trim();
            if (t.isEmpty) continue;
            if (t.startsWith('+') || t.startsWith('x')) {
              skillLevels.add(int.parse(t.substring(1)));
            } else if (t.contains('+')) {
              List<String> parts = t.split('+');
              skills.add(All.skillsMap[parts[0].trim()]);
              if (skills.length == 1 && skills[0] == null) {
                log("Error getting skill ${parts[0]}");
              }
              int? lv = int.tryParse(parts[1].trim());
              if (lv == null) {
                log("Failed to parse level ${parts[1]} of skill ${parts[0]} of charm $name");
                lv = 1;
              }
              skillLevels.add(lv);
            } else {
              skills.add(All.skillsMap[t]);
              if (skills.length == 1 && skills[0] == null) {
                log("Error getting skill $t");
              }
            }
          }
        }
        while (skills.length != skillLevels.length) {
          skillLevels.add(1);
          /*throw Exception(
              "Charm $name could not be parsed. ${skills.length} skills and ${skillLevels.length} skill levels found!");*/
        }
        while (skills.length < 3) {
          skills.add(null);
          skillLevels.add(0);
        }
        allCharms.add(Charm(
            name: name,
            rarity: 0,
            primary: skills[0]!,
            secondary: skills[1],
            ternary: skills[2],
            primaryLv: skillLevels[0],
            secondaryLv: skillLevels[1],
            ternaryLv: skillLevels[2]));
      }
      _writeJsonData("data/charms.json", {'data': allCharms.map((e) => e.toJson()).toList()});
    } else {
      throw Exception();
    }
  }

  static parseArmorFromHtml() async {
    List<Armor> allArmors = [];
    for (int i = 1; i <= 12; i++) {
      log("Rarity $i");
      final content = await rootBundle.loadString("assets/webdata/armor_$i.html");
      final elements = parse(content).children.first.children.last.children.first.children.first;
      //log(elements.children.first.outerHtml);
      //log(elements.children.first.innerHtml);
      String? name;
      bool layered = false;
      List<Armor> armors = [];
      for (var element in elements.children) {
        if (name == null) {
          name = element.children.first.children.first.children.first.children.first.innerHtml;
          continue;
        }
        if (element.children.first.innerHtml == "Total") {
          log(name);
          if (!layered) {
            if (armors.length < 5) {
              log("Armor $name has less than 5 pieces. Specify which pieces it has!");
            }
            int k = 0;
            for (var piece in armors) {
              var part = Part.values[k++];
              allArmors.add(piece.copyWith(part: part));
            }
          }
          armors.clear();
          name = null;
          layered = false;
          continue;
        }
        if (layered) continue;

        var pieceName = element.children.first.children.first.children.first.innerHtml;
        var def = element.children[2].innerHtml.split("~");
        var minDef = int.parse(def[0].trim());
        var maxDef = int.parse(def[1].trim());
        if (pieceName.contains("Layered") || maxDef <= 0) {
          layered = true;
          continue;
        }
        var defFire = int.tryParse(element.children[3].innerHtml) ?? 0;
        var defWater = int.tryParse(element.children[4].innerHtml) ?? 0;
        var defThunder = int.tryParse(element.children[5].innerHtml) ?? 0;
        var defIce = int.tryParse(element.children[6].innerHtml) ?? 0;
        var defDragon = int.tryParse(element.children[7].innerHtml) ?? 0;
        List<int> slots = List.filled(3, 0);
        int j = 0;
        for (var img in element.children[8].children) {
          var imgLink = img.attributes["src"];
          if (imgLink == null) continue;
          if (imgLink.endsWith("slot_size_1.png")) {
            slots[j++] = 1;
          } else if (imgLink.endsWith("slot_size_2.png")) {
            slots[j++] = 2;
          } else if (imgLink.endsWith("slot_size_3.png")) {
            slots[j++] = 3;
          } else if (imgLink.endsWith("slot_size_4.png")) {
            slots[j++] = 4;
          }
        }
        armors.add(Armor(
            name: pieceName,
            part: Part.charm,
            rarity: i,
            primary: All.undefined,
            primaryLv: 0,
            primarySlotSize: slots[0],
            secondarySlotSize: slots[1],
            ternarySlotSize: slots[2],
            minDef: minDef,
            maxDef: maxDef,
            defFire: defFire,
            defWater: defWater,
            defThunder: defThunder,
            defIce: defIce,
            defDragon: defDragon));
      }
    }
    _writeJsonData("data/armor.json", {'data': allArmors.map((e) => e.toJson()).toList()});
  }

  static Future<Document> parseHtml(String link) async {
    final response = await http.Client().get(Uri.parse(link));
    if (response.statusCode == 200) {
      return parse(response.body);
    }
    throw Exception('Network error');
  }

  static parseArmorSkillsFromWeb() async {
    Set<Armor> processedArmor = {};
    var doc = await parseHtml('https://mhworld.kiranico.com/en/skilltrees');
    var table = doc.getElementsByClassName('table table-lightborder table-sm')[0].children[1];
    for (var el in table.children) {
      if (el.children.length == 1) {
        var link = el.children.first.children.first.attributes['href']!;
        var skillDoc = await parseHtml(link);
        var skillTable = skillDoc.getElementsByClassName('table table-padded')[0];
        int i = 0;
        for (var el2 in skillTable.children.first.children) {
          i++;
          //if (i == 1) continue;
          var a = el2.children.first.children.first;
          var armorName = a.nodes[2].text!.replaceAll('\n', '').trim();
          armorName = armorName.replaceAll('Artemi\'s', 'Artemis').replaceAll('Leon\'s', 'Leons').replaceAll('Claire\'s', 'Claires');
          int? armorIndex = getArmorIndexByName(armorName);
          if (armorIndex == null) {
            if (!armorName.contains("Charm")) {
              print('No armor for "$armorName"');
            }
            continue;
          }
          Armor armor = armorList[armorIndex];
          if (processedArmor.contains(armor)) continue;
          int index = 0;
          for (var el3 in el2.children[1].children.first.children) {
            var skillName = el3.children.first.text;
            Skill? skill = skillsMap[skillName];
            if (skill != null) {
              var skillLevel = int.tryParse(el3.nodes[1].text!) ?? 1;
              if (index == 0) {
                armor = armor.copyWith(primary: skill, primaryLv: skillLevel);
              } else if (index == 1) {
                armor = armor.copyWith(secondary: skill, secondaryLv: skillLevel);
              } else {
                print('Tried adding 3rd skill to armor');
              }
            } else {
              ArmorBonus? bonus = armorBonusesMap[skillName.replaceAll('\'jiiva', '\'jiva')];
              if (bonus == null) {
                print('No skill and armor bonus for "$skillName"');
                continue;
              }
              armor = armor.copyWith(armorBonus: bonus);
            }
            index++;
            //print('Modified ${armor.name} skill $index');
            armorList[armorIndex] = armor;
            processedArmor.add(armor);
          }
          //return;
        }
      }

      //return;
    }
    //saveData();
  }
}

void _writeJsonData(String path, Map<String, dynamic> json) async {
  var file = File('${Directory.current.path}\\assets\\${path.replaceAll('/', '\\')}');
  await file.create(recursive: true);
  var encoder = const JsonEncoder.withIndent("  ");
  await file.writeAsString(encoder.convert(json));
}

mixin SkillTemplate {
  String get name;

  String? get altName;

  bool matchesSearch(String searchValue) {
    return name.toLowerCase().contains(searchValue) || (altName?.toLowerCase().contains(searchValue) ?? false);
  }

  int compareForSearch(SkillTemplate b, String searchValue) {
    var sa = name.toLowerCase().startsWith(searchValue) || (altName?.toLowerCase().startsWith(searchValue) ?? false);
    var sb = b.name.toLowerCase().startsWith(searchValue) || (altName?.toLowerCase().startsWith(searchValue) ?? false);
    if (sa && !sb) return -1;
    if (!sa && sb) return 1;
    return 0;
  }
}

@freezed
class ArmorBonus with SkillTemplate, _$ArmorBonus {
  const ArmorBonus._();

  const factory ArmorBonus(
      {required String name,
      @Default(null) String? altName,
      required String primaryBonusSkill,
      @Default(null) String? secondaryBonusSkill,
      required int primaryReq,
      @Default(0) int secondaryReq,
      @Default(null) String? primaryBonusDesc,
      @Default(null) String? secondaryBonusDesc,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString) Skill? primarySkillSecret,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString) Skill? secondarySkillSecret}) = _ArmorBonus;

  static ArmorBonus? fromStringNullable(String? name) {
    return name == null || name.isEmpty ? null : All.armorBonusesMap[name];
  }

  factory ArmorBonus.fromJson(Map<String, Object?> json) => _$ArmorBonusFromJson(json);

  static String asString(ArmorBonus? skill) {
    return skill?.name ?? '';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _Skill && name == other.name);
  }

  @override
  int get hashCode => name.hashCode;
}

@freezed
class Skill with _$Skill, SkillTemplate {
  const Skill._();

  const factory Skill(
      {required String name, @Default(null) String? altName, required int maxLevel, @Default(0) int maxSecretLevel}) = _Skill;

  static Skill fromString(String name) {
    return All.getSkill(name);
  }

  static Skill? fromStringNullable(String? name) {
    return name == null || name.isEmpty ? null : All.getSkill(name);
  }

  factory Skill.fromJson(Map<String, Object?> json) => _$SkillFromJson(json);

  static String asString(Skill? skill) {
    return skill?.name ?? '';
  }

  bool get hasSecret => maxSecretLevel > 0;

  int get trueMaxLevel => maxLevel;

  int get cappedMaxLevel => hasSecret ? maxSecretLevel : maxLevel;

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _Skill && name == other.name);
  }

  @override
  int get hashCode => name.hashCode;
}

mixin Equipment {
  Skill get primary => throw UnsupportedError("Unimplemented getter");

  Skill? get secondary => throw UnsupportedError("Unimplemented getter");

  int get primaryLv => throw UnsupportedError("Unimplemented getter");

  int get secondaryLv => throw UnsupportedError("Unimplemented getter");

  int get ternaryLv => throw UnsupportedError("Unimplemented getter");

  Part get part => throw UnsupportedError("Unimplemented getter");
}

@freezed
class Armor with _$Armor, Equipment {
  const Armor._();

  const factory Armor(
      {required String name,
      required Part part,
      required int rarity,
      @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString) required Skill primary,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString) Skill? secondary,
      @JsonKey(fromJson: ArmorBonus.fromStringNullable, toJson: ArmorBonus.asString) ArmorBonus? armorBonus,
      required int primaryLv,
      @Default(0) int secondaryLv,
      required int primarySlotSize,
      required int secondarySlotSize,
      required int ternarySlotSize,
      required int minDef,
      required int maxDef,
      required int defFire,
      required int defWater,
      required int defThunder,
      required int defIce,
      required int defDragon}) = _Armor;

  factory Armor.fromJson(Map<String, Object?> json) => _$ArmorFromJson(json);
}

@freezed
class Deco with _$Deco {
  const Deco._();

  const factory Deco({
    required String name,
    @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString) required Skill primary,
    @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString) Skill? secondary,
    required int primaryLvl,
    required int size,
  }) = _Deco;

  bool get hasSec => secondary != null;

  factory Deco.fromJson(Map<String, Object?> json) => _$DecoFromJson(json);
}

@freezed
class Charm with _$Charm, Equipment {
  const Charm._();

  const factory Charm(
      {required String name,
      required int rarity,
      @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString) required Skill primary,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString) Skill? secondary,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString) Skill? ternary,
      required int primaryLv,
      @Default(0) int secondaryLv,
      @Default(0) int ternaryLv}) = _Charm;

  factory Charm.fromJson(Map<String, Object?> json) => _$CharmFromJson(json);

  @override
  Part get part => Part.charm;
}
