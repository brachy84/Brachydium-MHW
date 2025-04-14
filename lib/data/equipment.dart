import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:brachys_armor_set_searcher/data/localization.dart';
import 'package:brachys_armor_set_searcher/data/set_finder.dart';
import 'package:brachys_armor_set_searcher/main.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

part 'equipment.freezed.dart';
part 'equipment.g.dart';

enum Part {
  head, chest, arm, waist, leg, charm, weapon;

  String get localizedName => All.langEn['part:$name']!;
}

enum SkillCategory { weapon, armor, groupBonus, setBonus }

enum WeaponType { gs, ls, sns, db, sa, hammer, hh, lance, gl, ig, cb, lbg, hbg, bow }

enum DecorationType { weapon, armor }

class All {
  static const Skill undefined = Skill(name: "UNDEFINED", maxLevel: 0, category: SkillCategory.weapon, desc: '');
  static const BonusSkill undefinedBonus = BonusSkill(
      name: "UNDEFINED",
      maxLevel: 0,
      category: SkillCategory.groupBonus,
      primaryCount: 0,
      secondaryCount: 0,
      primaryDesc: '',
      secondaryDesc: '');
  static const Armor dummyArmor = Armor(
      name: 'dummy',
      part: Part.head,
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
  static const Charm dummyCharm = Charm(name: 'dummy', rarity: 1, primary: undefined, primaryLv: 0);
  static final List<Skill> skills = [];
  static final Map<String, Skill> skillsMap = {};
  static final List<BonusSkill> armorBonuses = [];
  static final Map<String, BonusSkill> armorBonusesMap = {};
  static final List<Deco> decos = [];
  static final Map<String, Deco> decosByString = {};
  static final List<Armor> armorList = [];
  static final Map<String, Equipment> equipment = {};
  static final Map<Skill, List<Deco>> decosMap = {};
  static final Map<SkillTemplate, List<Armor>> helmets = {};
  static final Map<SkillTemplate, List<Armor>> chests = {};
  static final Map<SkillTemplate, List<Armor>> arms = {};
  static final Map<SkillTemplate, List<Armor>> waists = {};
  static final Map<SkillTemplate, List<Armor>> legs = {};
  static final Map<SkillTemplate, List<Charm>> charms = {};
  static final Map<Part, Map<SkillTemplate, List<Armor>>> _armorBySkillByPart = {
    Part.head: helmets,
    Part.chest: chests,
    Part.arm: arms,
    Part.waist: waists,
    Part.leg: legs
  };

  static final Map<String, String> langEn = {};

  static void addSkill(String name, SkillCategory category, int maxLevel, String desc) {
    String trueName = name;
    print('Adding skill $trueName');
    Skill skill = Skill(name: trueName, category: category, maxLevel: maxLevel, desc: desc);
    skills.add(skill);
    skillsMap[name] = skill;
  }

  static void addBonusSkill(
      String name, SkillCategory category, int maxLevel, int primaryCount, int secondaryCount, String primaryDesc, String secondaryDesc) {
    String trueName = name;
    print('Adding bonus skill $trueName');
    BonusSkill skill = BonusSkill(
        name: trueName,
        category: category,
        maxLevel: maxLevel,
        primaryCount: primaryCount,
        secondaryCount: secondaryCount,
        primaryDesc: primaryDesc,
        secondaryDesc: secondaryDesc);
    armorBonuses.add(skill);
    armorBonusesMap[name] = skill;
  }

  static Skill getSkill(String name) {
    if (!skillsMap.containsKey(name)) {
      if (name == undefined.name) return undefined;
      log("No skill with name $name");
      return skills[0];
    }
    return skillsMap[name]!;
  }

  static BonusSkill getArmorBonus(String name) {
    if (!armorBonusesMap.containsKey(name)) {
      if (name == undefined.name) return undefinedBonus;
      log("No bonus skill with name $name");
      return armorBonuses[0];
    }
    return armorBonusesMap[name]!;
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

  static void _addEquipment<T extends Equipment>(T equipment, bool fromWeb) {
    All.equipment[equipment.name] = equipment;
    if (equipment.part == Part.charm) {
      if (fromWeb) print('Adding charm ${(equipment as Charm).name}');
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
    if (fromWeb) print('Adding armor ${(equipment as Armor).name}');
    var map = _armorBySkillByPart[equipment.part]!;
    map.putIfAbsent(equipment.primary, () => []).add(equipment as Armor);
    armorList.add(equipment);
    if (equipment.secondary != null) {
      map.putIfAbsent(equipment.secondary!, () => []).add(equipment);
    }
    if (equipment.ternary != null) {
      map.putIfAbsent(equipment.ternary!, () => []).add(equipment);
    }
    if (equipment.groupBonus != null) {
      map.putIfAbsent(equipment.groupBonus!, () => []).add(equipment);
    }
    if (equipment.setBonus != null) {
      map.putIfAbsent(equipment.setBonus!, () => []).add(equipment);
    }
  }

  static void saveData() {
    _writeJsonData("data/wilds/armor.json", {'data': armorList.map((e) => e.toJson()).toList()});
    _writeJsonData("data/wilds/skills.json", {'data': skills.map((e) => e.toJson()).toList()});
  }

  static Future<void> init() async {
    await parseLangFromJson();
    //await parseSkillsFromWeb();
    await parseSkillsFromJson();
    //await parseDecosFromWeb();
    await parseDecosFromJson();
    //await parseCharmsFromWeb();
    await parseCharmsFromJson();
    //await parseArmorFromWeb();
    await parseArmorsFromJson();
  }

  static parseLangFromJson() async {
    print('Parsing lang from json');
    var content = await rootBundle.loadString("assets/data/wilds/lang/en_us.json");
    var json = jsonDecode(content) as Map;
    json.forEach((k, v) => langEn[k] = v);
  }

  static _writeLang() {
    _writeJsonData("data/wilds/lang/en_us.json", langEn);
  }

  static parseSkillsFromJson() async {
    print('Parsing skills from json');
    var content = await rootBundle.loadString("assets/data/wilds/skills.json");
    var json = jsonDecode(content)['data'] as List;
    for (Map<String, dynamic> element in json) {
      var skill = Skill.fromJson(element);
      skills.add(skill);
      skillsMap[skill.name] = skill;
    }

    content = await rootBundle.loadString("assets/data/wilds/bonus_skills.json");
    json = jsonDecode(content)['data'] as List;
    for (Map<String, dynamic> element in json) {
      var skill = BonusSkill.fromJson(element);
      armorBonuses.add(skill);
      armorBonusesMap[skill.name] = skill;
    }
  }

  static parseArmorBonusesFromJson() async {
    print('Parsing armor bonuses from json');
    final content = await rootBundle.loadString("assets/data/wilds/armor_bonus.json");
    final json = jsonDecode(content)['data'] as List;
    bool modifySkills = false;
    for (Map<String, dynamic> element in json) {
      var skill = BonusSkill.fromJson(element);
      armorBonuses.add(skill);
      armorBonusesMap[skill.name] = skill;
      /* TODO do secrets still exist?
      if (modifySkills) {
        if (skill.primarySkillSecret != null) {
          var s = skill.primarySkillSecret!;
          replaceSkill(s, s.copyWith(maxSecretLevel: max(1, s.maxLevel - 2)));
        }
        if (skill.secondarySkillSecret != null) {
          var s = skill.secondarySkillSecret!;
          replaceSkill(s, s.copyWith(maxSecretLevel: max(1, s.maxLevel - 2)));
        }
      }*/
    }
  }

  static parseDecosFromJson() async {
    final content = await rootBundle.loadString("assets/data/wilds/decos.json");
    final json = jsonDecode(content)['data'] as List;
    for (Map<String, dynamic> element in json) {
      var deco = Deco.fromJson(element);
      deco.category;
      decos.add(deco);
      decosMap.putIfAbsent(deco.primary, () => []).add(deco);
      if (deco.hasSec) {
        decosMap.putIfAbsent(deco.secondary!, () => []).add(deco);
      }
    }
  }

  static parseCharmsFromJson() async {
    print('Parsing charms from json');
    final content = await rootBundle.loadString("assets/data/wilds/charms.json");
    final json = jsonDecode(content)['data'] as List;
    for (Map<String, dynamic> element in json) {
      var charm = Charm.fromJson(element);
      _addEquipment(charm, false);
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
    print('Parsing armor from json');
    final content = await rootBundle.loadString("assets/data/wilds/armor.json");
    final json = jsonDecode(content)['data'] as List;
    bool applyArmorBonus = true;
    String? bonusPiece;
    Skill? bonus;
    for (Map<String, dynamic> element in json) {
      var armor = Armor.fromJson(element);
      if (applyArmorBonus) {
        // TODO
        /*if (armor.armorBonus != null) {
          bonus = armor.armorBonus;
          bonusPiece = armor.name;
        } else if (bonusPiece != null && isSameArmorSet(bonusPiece, armor.name)) {
          armor = armor.copyWith(armorBonus: bonus);
        }*/
      }
      _addEquipment(armor, false);
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

  static Element? _findElement(Document doc, String tag, String className) {
    var list = doc.getElementsByTagName(tag);
    if (list.isEmpty) return null;
    for (Element element in list) {
      if (element.className == className) return element;
    }
    return null;
  }

  static parseSkillsFromWeb() async {
    print('Parsing skills from web');
    final response = await http.Client().get(Uri.parse('https://mhwilds.kiranico.com/data/skills'));
    if (response.statusCode == 200) {
      var doc = parse(response.body);
      var table = doc.getElementsByClassName('mx-auto h-full w-full max-w-3xl')[0];
      var list = table.children[1];
      await Future.wait([
        _parseSkillList(list.children[0], SkillCategory.weapon),
        _parseSkillList(list.children[1], SkillCategory.armor),
        _parseSkillList(list.children[2], SkillCategory.groupBonus),
        _parseSkillList(list.children[3], SkillCategory.setBonus),
      ]);
      _writeJsonData("data/wilds/skills.json", {'data': skills.map((e) => e.toJson()).toList()});
      _writeJsonData("data/wilds/bonus_skills.json", {'data': armorBonuses.map((e) => e.toJson()).toList()});
      _writeLang();
    }
  }

  static Future<void> _parseSkillList(Element html, SkillCategory category) async {
    var list = html.children[1].children[0].children[0].children;
    for (var el in list) {
      var el1 = el.children[0].children[0];
      var link = el1.attributes['href']!;
      var name = el1.text; // TODO translation
      var regName = _parseRegName(link);
      int maxLevel = 0;

      final response = await http.Client().get(Uri.parse('https://mhwilds.kiranico.com$link'));

      if (response.statusCode == 200) {
        var doc = parse(response.body);
        var table = _findElement(doc, 'tbody', '[&_tr:last-child]:border-0 text-sm');
        if (table == null) {
          print('html element not found');
          continue;
        }
        if (category == SkillCategory.weapon || category == SkillCategory.armor) {
          maxLevel = table.children.length;
          String desc = '';
          addSkill(regName, category, maxLevel, desc);
          langEn['skill:$regName'] = name;
        } else {
          maxLevel = table.children.length;
          int pL = _parseLv(table.children[0].children[0].text);
          String pD = table.children[0].children[2].text;
          int sL = 0;
          String sD = '';
          if (table.children.length > 1) {
            sL = _parseLv(table.children[1].children[0].text);
            sD = table.children[0].children[2].text;
          }
          langEn['bskill:$regName'] = name;
          addBonusSkill(regName, category, max(pL, sL), pL, sL, pD, sD);
        }
      } else {
        print('Could not receive web page for skill $regName');
      }
    }
  }

  static String _parseRegName(String link) {
    return link.substring(link.lastIndexOf('/') + 1);
  }

  static int _parseLv(String lv) {
    return int.parse(lv.substring(2));
  }

  static parseDecosFromWeb() async {
    print('Parsing decos from web');
    final response = await http.Client().get(Uri.parse('https://mhwilds.kiranico.com/data/decorations'));
    if (response.statusCode == 200) {
      var doc = parse(response.body);
      var table = _findElement(doc, 'tbody', '[&_tr:last-child]:border-0 text-sm');
      if (table == null) {
        print('html element not found');
        return;
      }
      for (var el in table.children) {
        var el1 = el.children[0].children[0];
        var link = el1.attributes['href']!;
        var regName = _parseRegName(link);
        var name = el1.text;
        int size = int.parse(regName.substring(regName.length - 1));

        final response = await http.Client().get(Uri.parse('https://mhwilds.kiranico.com$link'));
        if (response.statusCode == 200) {
          var doc1 = parse(response.body);
          var table1 = _findElement(doc1, 'tbody', '[&_tr:last-child]:border-0 text-sm');
          if (table1 == null) {
            print('html element not found');
            continue;
          }
          var el2 = table1.children[0];
          String pN = _parseRegName(el2.children[0].children[0].attributes['href']!);
          int pL = _parseLv(el2.children[1].text);
          Skill pS = Skill.fromString(pN);
          String? sN;
          int? sL;
          Skill? sS;
          if (table1.children.length > 1) {
            el2 = table1.children[1];
            sN = _parseRegName(el2.children[0].children[0].attributes['href']!);
            sL = _parseLv(el2.children[1].text);
            sS = Skill.fromString(sN);
            if (sL != 1) throw Exception('Invalid secondary level');
          }
          decos.add(Deco(name: regName, primary: pS, primaryLvl: pL, size: size, secondary: sS));
          langEn['deco:$regName'] = name;
        } else {
          print('Could not receive web page for deco $regName');
        }
      }
      _writeJsonData("data/wilds/decos.json", {'data': decos.map((e) => e.toJson()).toList()});
      _writeLang();
    } else {
      throw Exception();
    }
  }

  static parseCharmsFromWeb() async {
    print('Parsing charms from web');
    final response = await http.Client().get(Uri.parse('https://mhwilds.kiranico.com/data/charms'));
    if (response.statusCode == 200) {
      var doc = parse(response.body);
      var table = _findElement(doc, 'tbody', '[&_tr:last-child]:border-0 text-sm')!;
      var romeToNum = {'I': 1, 'II': 2, 'III': 3, 'IV': 4, 'V': 5};
      List<Charm> allCharms = [];

      for (var child in table.children) {
        var link = child.children[0].children[0].attributes['href']!;
        var regName = _parseRegName(link);
        langEn['charm:$regName'] = child.children[0].text;
        final response = await http.Client().get(Uri.parse('https://mhwilds.kiranico.com$link'));
        if (response.statusCode == 200) {
          var doc1 = parse(response.body);
          var table1 =
              _findElement(doc1, 'div', 'mx-auto h-full w-full max-w-3xl')!.children[1].children[2].children[0].children[0].children[0];
          Skill? p, s;
          int pLvl = 0, sLvl = 0;
          for (var skillElement in table1.children) {
            var skillName = _parseRegName(skillElement.children[0].children[0].attributes['href']!);
            var lvl = int.parse(skillElement.children[1].text.replaceAll('Lv', ''));
            Skill? t = All.skillsMap[skillName];
            if (t != null) {
              if (p == null) {
                p = t;
                pLvl = lvl;
              } else if (s == null) {
                s = t;
                sLvl = lvl;
              } else {
                print('Charm $regName has more than 2 skills: $p, $s, $t');
              }
            } else {
              print(' - no charm skill $skillName found');
            }
          }
          print('Adding charm $regName');
          allCharms.add(Charm(name: regName, rarity: 1, primary: p!, primaryLv: pLvl, secondary: s, secondaryLv: sLvl));
        }
      }
      _writeJsonData("data/wilds/charms.json", {'data': allCharms.map((e) => e.toJson()).toList()});
      _writeLang();
    } else {
      throw Exception();
    }
  }

  static parseArmorFromWeb() async {
    print('Parsing armor from web');
    final response = await http.Client().get(Uri.parse('https://mhwilds.kiranico.com/data/armor-series'));
    if (response.statusCode == 200) {
      var doc = parse(response.body);
      var table = _findElement(doc, 'tbody', '[&_tr:last-child]:border-0 text-sm')!;

      var parts = {
        'Head': Part.head,
        'Chest': Part.chest,
        'Arms': Part.arm,
        'Waist': Part.waist,
        'Legs': Part.leg,
      };

      for (var child in table.children) {
        var first = child.children[0];
        if (first.children.isNotEmpty) {
          String link = first.children[0].attributes['href']!;
          final response = await http.Client().get(Uri.parse('https://mhwilds.kiranico.com$link'));
          if (response.statusCode == 200) {
            var doc1 = parse(response.body);
            var table1 = _findElement(doc1, 'div', 'mx-auto h-full w-full max-w-3xl')!.children[1];
            var defTable = table1.children[3].children[0].children[0].children[0];
            var skillTable = table1.children[4].children[0].children[0].children[0];
            var armorRegName = _parseRegName(link);

            for (int i = 1; i < defTable.children.length; i++) {
              var partElement = defTable.children[i];
              var part = parts[partElement.children[0].text]!;
              var name = partElement.children[1].text;
              var regName = '$armorRegName-${part.name}';
              var def = int.parse(partElement.children[2].text);
              var fireDef = int.parse(partElement.children[3].text);
              var waterDef = int.parse(partElement.children[4].text);
              var thunderDef = int.parse(partElement.children[5].text);
              var iceDef = int.parse(partElement.children[6].text);
              var dragonDef = int.parse(partElement.children[7].text);
              var skillElement = skillTable.children[i];
              var slots = skillElement.children[2].text
                  .replaceAll(']\n[', '\$')
                  .replaceAll('][', '\$')
                  .replaceAll('[', '')
                  .replaceAll(']', '')
                  .split('\$')
                  .map((s) => int.parse(s))
                  .toList();
              var skillsElement = skillElement.children[3];
              Skill? p, s, t;
              BonusSkill? bonus, group;
              int pLvl = 0, sLvl = 0, tLvl = 0;
              for (var skillElement in skillsElement.children) {
                var skillName = skillElement.children[0].attributes['href']!.replaceAll('/data/skills/', '');
                var lvl = int.parse(skillElement.children[0].text.split('+')[1]);
                Skill? temp = All.skillsMap[skillName];
                if (temp != null) {
                  if (p == null) {
                    p = temp;
                    pLvl = lvl;
                  } else if (s == null) {
                    s = temp;
                    sLvl = lvl;
                  } else if (t == null) {
                    t = temp;
                    tLvl = lvl;
                  } else {
                    print('Armor piece $name has more than 3 skills: ${p.name}, ${s.name}, ${t.name}, ${temp.name}');
                  }
                } else {
                  BonusSkill? t2 = All.armorBonusesMap[skillName];
                  if (t2 != null) {
                    if (t2.category == SkillCategory.setBonus) {
                      if (bonus == null) {
                        bonus = t2;
                      } else {
                        print('Armor piece $name has more than 1 bonus skills: $bonus, $t2');
                      }
                    } else if (t2.category == SkillCategory.groupBonus) {
                      if (group == null) {
                        group = t2;
                      } else {
                        print('Armor piece $name has more than 1 group skills: $group, $t2');
                      }
                    }
                  }
                }
              }
              langEn['armor:$regName'] = name;
              Armor armor = Armor(
                  name: regName,
                  part: part,
                  rarity: 1,
                  primary: p!,
                  primaryLv: pLvl,
                  secondary: s,
                  secondaryLv: sLvl,
                  ternary: t,
                  ternaryLv: tLvl,
                  setBonus: bonus,
                  groupBonus: group,
                  primarySlotSize: slots[0],
                  secondarySlotSize: slots[1],
                  ternarySlotSize: slots[2],
                  minDef: def,
                  maxDef: def,
                  defFire: fireDef,
                  defWater: waterDef,
                  defThunder: thunderDef,
                  defIce: iceDef,
                  defDragon: dragonDef);
              _addEquipment(armor, true);
            }
          }
        }
      }
      _writeJsonData("data/wilds/armor.json", {'data': armorList.map((e) => e.toJson()).toList()});
      _writeLang();
    } else {
      throw Exception(response.statusCode);
    }
  }
}

void _writeJsonData(String path, Map<String, dynamic> json) async {
  var file = File('${Directory.current.path}\\assets\\${path.replaceAll('/', '\\')}');
  await file.create(recursive: true);
  var encoder = const JsonEncoder.withIndent("  ");
  await file.writeAsString(encoder.convert(json));
}

mixin SkillTemplate implements Localized {
  String get name;

  SkillCategory get category;

  bool matchesSearch(String searchValue) {
    return localizedName.toLowerCase().contains(searchValue);
  }

  int compareForSearch(SkillTemplate b, String searchValue) {
    var sa = name.toLowerCase().startsWith(searchValue);
    var sb = b.name.toLowerCase().startsWith(searchValue);
    if (sa && !sb) return -1;
    if (!sa && sb) return 1;
    return 0;
  }

  String localize(int count, {bool capAtMax = true});

  Color getColor(int count, {bool capAtMax = true});
}

/*@freezed
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
}*/

@freezed
class Skill with _$Skill, SkillTemplate, Localized {
  const Skill._();

  const factory Skill(
      {required String name,
      required SkillCategory category,
      required int maxLevel,
      required String desc}) = _Skill;

  static Skill fromString(String name) {
    return All.getSkill(name);
  }

  static Skill? fromStringNullable(String? name) {
    return name == null || name.isEmpty ? null : All.getSkill(name);
  }

  factory Skill.fromJson(Map<String, Object?> json) => _$SkillFromJson(json);

  static String asString(SkillTemplate? skill) {
    return skill?.name ?? '';
  }

  @override
  String get localizedName => All.langEn['skill:$name']!;

  @override
  String localize(int count, {bool capAtMax = true}) {
    int capped = min(count, maxLevel);
    int overCap = count - capped;
    String t = '$localizedName  Lv $capped';
    if (!capAtMax && overCap > 0) t += ' (+$overCap)';
    print('$t, $count');
    return t;
  }

  @override
  Color getColor(int count, {bool capAtMax = true}) {
    if (count >= maxLevel) {
      return material.Colors.blue.shade300;
    }
    return material.Colors.white70;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _Skill && name == other.name);
  }

  @override
  int get hashCode => name.hashCode;
}

@freezed
class BonusSkill with _$BonusSkill, SkillTemplate, Localized {
  const BonusSkill._();

  const factory BonusSkill(
      {required String name,
      required SkillCategory category,
      required int maxLevel,
      required int primaryCount,
      required int secondaryCount,
      required String primaryDesc,
      required String secondaryDesc}) = _BonusSkill;

  static BonusSkill fromString(String name) {
    return All.getArmorBonus(name);
  }

  static BonusSkill? fromStringNullable(String? name) {
    return name == null || name.isEmpty ? null : All.getArmorBonus(name);
  }

  factory BonusSkill.fromJson(Map<String, Object?> json) => _$BonusSkillFromJson(json);

  static String asString(SkillTemplate? skill) {
    return skill?.name ?? '';
  }

  bool activates(int count) {
    return count >= primaryCount;
  }

  @override
  String get localizedName => All.langEn['bskill:$name']!;

  @override
  String localize(int count, {bool capAtMax = true}) {
    String lvl = (secondaryCount > 0 && count >= secondaryCount) ? 'II' : (count >= primaryCount ? 'I' : '0');
    String t = '$localizedName $lvl';
    if (!capAtMax && count != maxLevel) t += '  $count/$maxLevel';
    return t;
  }

  @override
  Color getColor(int count, {bool capAtMax = true}) {
    if (count >= maxLevel) {
      return material.Colors.blue.shade300;
    }
    if (activates(count)) {
      return material.Colors.white70;
    }
    return material.Colors.red.shade300;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _Skill && name == other.name);
  }

  @override
  int get hashCode => name.hashCode;
}

mixin Equipment implements Localized {
  String get name => throw UnsupportedError("Unimplemented getter");

  Skill get primary => throw UnsupportedError("Unimplemented getter");

  Skill? get secondary => throw UnsupportedError("Unimplemented getter");

  Skill? get ternary => throw UnsupportedError("Unimplemented getter");

  int get primaryLv => throw UnsupportedError("Unimplemented getter");

  int get secondaryLv => throw UnsupportedError("Unimplemented getter");

  int get ternaryLv => throw UnsupportedError("Unimplemented getter");

  Part get part => throw UnsupportedError("Unimplemented getter");

  static String asString(Equipment? equipment) {
    return equipment?.name ?? '';
  }

  static Equipment fromString(String name) {
    if (!All.equipment.containsKey(name)) {
      throw Exception('No equipment for name $name');
    }
    return All.equipment[name]!;
  }
}

@freezed
class Armor with _$Armor, Equipment, Localized {
  const Armor._();

  const factory Armor(
      {required String name,
      required Part part,
      required int rarity,
      @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString) required Skill primary,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString) Skill? secondary,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString) Skill? ternary,
      @JsonKey(fromJson: BonusSkill.fromStringNullable, toJson: BonusSkill.asString) BonusSkill? groupBonus,
      @JsonKey(fromJson: BonusSkill.fromStringNullable, toJson: BonusSkill.asString) BonusSkill? setBonus,
      required int primaryLv,
      @Default(0) int secondaryLv,
      @Default(0) int ternaryLv,
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

  @override
  String get localizedName => All.langEn['armor:$name']!;
}

@freezed
class Deco with _$Deco, Localized {
  const Deco._();

  const factory Deco({
    required String name,
    @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString) required Skill primary,
    @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString) Skill? secondary,
    required int primaryLvl,
    required int size,
  }) = _Deco;

  bool get hasSec => secondary != null;

  int get totalSkillPoints => hasSec ? primaryLvl + 1 : primaryLvl;

  SkillCategory get category {
    if (hasSec && primary.category != secondary!.category) {
      throw Exception(
          'Deco $name skills (${primary.name}, ${secondary!.name}) have different categories (${primary.category.name}, ${secondary!.category.name}');
    }
    return primary.category;
  }

  factory Deco.fromJson(Map<String, Object?> json) => _$DecoFromJson(json);

  @override
  String get localizedName => All.langEn['deco:$name']!;

  static String asString(Deco? deco) {
    return deco?.name ?? '';
  }

  static Deco? fromStringNullable(String? name) {
    return name == null || name.isEmpty ? null : All.decosByString[name];
  }
}

@freezed
class Charm with _$Charm, Equipment, Localized {
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

  @override
  String get localizedName => All.langEn['charm:$name']!;

  static Charm fromString(String name) {
    Equipment? eq = All.equipment[name]!;
    if (eq is Charm) return eq;
    throw Exception('No charm for name $name');
  }
}

@freezed
class Weapon with _$Weapon, Equipment, Localized {
  const Weapon._();

  const factory Weapon({
    required String name,
    required WeaponType type,
    required int rarity,
    @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString) required Skill primary,
    @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString) Skill? secondary,
    @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString) Skill? ternary,
    required int primaryLv,
    @Default(0) int secondaryLv,
    @Default(0) int ternaryLv,
    /*List<int> sharpness*/
  }) = _Weapon;

  @override
  Part get part => Part.weapon;

  @override
  String get localizedName => name;//All.langEn['weapon:$name']!;
}

List<String> _decoListToJson(List<Deco?> decos) {
  return decos.map((d) => Deco.asString(d)).toList();
}

List<Deco?> _jsonToDecoList(List<String> json) {
  return json.map((j) => Deco.fromStringNullable(j)).toList();
}

List<Map<String, dynamic>> _equipmentListToJson(List<EquipmentPiece> equipment) {
  return equipment.map((eq) => eq.toJson()).toList();
}

List<EquipmentPiece> _jsonToEquipmentList(List<Map<String, dynamic>> json) {
  return json.map((j) => EquipmentPiece.fromJson(j)).toList();
}

@freezed
class EquipmentPiece with _$EquipmentPiece implements Comparable<EquipmentPiece> {
  const EquipmentPiece._();

  const factory EquipmentPiece(
      {@JsonKey(fromJson: Equipment.fromString, toJson: Equipment.asString) required Equipment equipment,
      @JsonKey(fromJson: _jsonToDecoList, toJson: _decoListToJson) required List<Deco?> decorations}) = _EquipmentPiece;

  factory EquipmentPiece.fromJson(Map<String, Object?> json) => _$EquipmentPieceFromJson(json);

  @override
  int compareTo(EquipmentPiece other) {
    return equipment.part.index.compareTo(other.equipment.part.index);
  }
}

@freezed
class ArmorSet with _$ArmorSet {
  const ArmorSet._();

  const factory ArmorSet(
      {@JsonKey(fromJson: _jsonToDecoList, toJson: _decoListToJson) required List<Deco?> weaponDecos,
      @JsonKey(fromJson: _jsonToEquipmentList, toJson: _equipmentListToJson) required List<EquipmentPiece> pieces,
      @JsonKey(fromJson: Charm.fromString, toJson: Equipment.asString) required Charm charm}) = _ArmorSet;

  factory ArmorSet.fromJson(Map<String, Object?> json) => _$ArmorSetFromJson(json);

  List<Stack<SkillTemplate>> calculateSkills({bool removeOverlevel = true, bool removeNonFullBonus = true}) {
    Map<SkillTemplate, Stack<SkillTemplate>> skills = {};
    for (EquipmentPiece piece in pieces) {
      _putEquipmentSkills(piece.equipment, skills);
      if (piece.decorations[0] != null) _putDecoSkills(piece.decorations[0]!, skills);
      if (piece.decorations[1] != null) _putDecoSkills(piece.decorations[1]!, skills);
      if (piece.decorations[2] != null) _putDecoSkills(piece.decorations[2]!, skills);
    }
    _putEquipmentSkills(charm, skills);
    var list = skills.values.toList();
    if (removeNonFullBonus) {
      list.removeWhere((skill) => skill.value is BonusSkill && skill.amount < (skill.value as BonusSkill).primaryCount);
    }
    if (removeOverlevel) {
      for (var skill in list) {
        if (skill.value is Skill) {
          skill.amount = min(skill.amount, (skill.value as Skill).maxLevel);
        }
      }
    }
    list.sort((a, b) {
      int i = a.value.category.index.compareTo(b.value.category.index);
      if (i != 0) return i;
      if (a.value is BonusSkill && b.value is BonusSkill) {
        bool a1 = (a.value as BonusSkill).activates(a.amount);
        bool b1 = (b.value as BonusSkill).activates(b.amount);
        if (a1 && !b1) return -1;
        if (!a1 && b1) return 1;
      }
      i = b.amount.compareTo(a.amount);
      if (i != 0) return i;
      return a.value.localizedName.compareTo(b.value.localizedName);
    });
    return list;
  }

  void _putEquipmentSkills(Equipment eq, Map<SkillTemplate, Stack<SkillTemplate>> skills) {
    skills.putIfAbsent(eq.primary, () => Stack(value: eq.primary, amount: 0)).incr(eq.primaryLv);
    if (eq.secondary != null) skills.putIfAbsent(eq.secondary!, () => Stack(value: eq.secondary!, amount: 0)).incr(eq.secondaryLv);
    if (eq.ternary != null) skills.putIfAbsent(eq.ternary!, () => Stack(value: eq.ternary!, amount: 0)).incr(eq.ternaryLv);
    if (eq is Armor) {
      if (eq.setBonus != null) skills.putIfAbsent(eq.setBonus!, () => Stack(value: eq.setBonus!, amount: 0)).incr(1);
      if (eq.groupBonus != null) skills.putIfAbsent(eq.groupBonus!, () => Stack(value: eq.groupBonus!, amount: 0)).incr(1);
    }
  }

  void _putDecoSkills(Deco deco, Map<SkillTemplate, Stack<SkillTemplate>> skills) {
    skills.putIfAbsent(deco.primary, () => Stack(value: deco.primary, amount: 0)).incr(deco.primaryLvl);
    if (deco.secondary != null) skills.putIfAbsent(deco.secondary!, () => Stack(value: deco.secondary!, amount: 0)).incr(1);
  }
}
