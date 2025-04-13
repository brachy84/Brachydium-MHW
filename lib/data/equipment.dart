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

enum Part { helm, chest, arm, waist, leg, charm, weapon }

enum SkillCategory { weapon, armor, groupBonus, setBonus }

enum WeaponType { gs, ls, sns, db, sa, hammer, hh, lance, gl, ig, cb, lbg, hbg, bow }

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
  static final List<BonusSkill> armorBonuses = [];
  static final Map<String, BonusSkill> armorBonusesMap = {};
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

  static final Map<String, String> langEn = {};

  static void addSkill(String name, SkillCategory category, int maxLevel, String desc, {String? altName}) {
    String trueName = altName ?? name;
    print('Adding skill $trueName');
    Skill skill = Skill(name: trueName, altName: altName, category: category, maxLevel: maxLevel, desc: desc);
    skills.add(skill);
    skillsMap[name] = skill;
    if (altName != null) {
      skillsMap[altName] = skill;
    }
  }

  static void addBonusSkill(
      String name, SkillCategory category, int maxLevel, int primaryCount, int secondaryCount, String primaryDesc, String secondaryDesc,
      {String? altName}) {
    String trueName = altName ?? name;
    print('Adding bonus skill $trueName');
    BonusSkill skill = BonusSkill(
        name: trueName,
        altName: altName,
        category: category,
        maxLevel: maxLevel,
        primaryCount: primaryCount,
        secondaryCount: secondaryCount,
        primaryDesc: primaryDesc,
        secondaryDesc: secondaryDesc);
    armorBonuses.add(skill);
    armorBonusesMap[name] = skill;
    if (altName != null) {
      armorBonusesMap[altName] = skill;
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

  static BonusSkill getArmorBonus(String name) {
    if (!skillsMap.containsKey(name)) {
      if (name == undefined.name) return undefinedBonus;
      log("No skill with name $name");
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

  static void _addEquipment<T extends Equipment>(T equipment) {
    if (equipment.part == Part.charm) {
      print('Adding charm ${(equipment as Charm).name}');
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
    print('Adding armor ${(equipment as Armor).name}');
    var map = _armorBySkillByPart[equipment.part]!;
    map.putIfAbsent(equipment.primary, () => []).add(equipment as Armor);
    armorList.add(equipment);
    if (equipment.secondary != null) {
      map.putIfAbsent(equipment.secondary!, () => []).add(equipment);
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
    await parseDecosFromWeb();
    //await parseDecosFromJson();
    //await parseCharmsFromWeb();
    //await parseCharmsFromJson();
    await parseArmorFromWeb();
    //await parseArmorsFromJson();
  }
  
  static parseLangFromJson() async {
    var content = await rootBundle.loadString("assets/data/wilds/lang/en_us.json");
    var json = jsonDecode(content) as Map;
    json.forEach((k, v) => langEn[k] = v);
  }

  static _writeLang() {
    _writeJsonData("data/wilds/lang/en_us.json", langEn);
  }

  static parseSkillsFromJson() async {
    var content = await rootBundle.loadString("assets/data/wilds/skills.json");
    var json = jsonDecode(content)['data'] as List;
    for (Map<String, dynamic> element in json) {
      var skill = Skill.fromJson(element);
      skills.add(skill);
      skillsMap[skill.name] = skill;
      if (skill.altName != null) {
        skillsMap[skill.altName!] = skill;
      }
    }

    content = await rootBundle.loadString("assets/data/wilds/bonus_skills.json");
    json = jsonDecode(content)['data'] as List;
    for (Map<String, dynamic> element in json) {
      var skill = BonusSkill.fromJson(element);
      armorBonuses.add(skill);
      armorBonusesMap[skill.name] = skill;
      if (skill.altName != null) {
        armorBonusesMap[skill.altName!] = skill;
      }
    }
  }

  static parseArmorBonusesFromJson() async {
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
      decos.add(deco);
      decosMap.putIfAbsent(deco.primary, () => []).add(deco);
      if (deco.hasSec) {
        decosMap.putIfAbsent(deco.secondary!, () => []).add(deco);
      }
    }
  }

  static parseCharmsFromJson() async {
    final content = await rootBundle.loadString("assets/data/wilds/charms.json");
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

  static Element? _findElement(Document doc, String tag, String className) {
    var list = doc.getElementsByTagName(tag);
    if (list.isEmpty) return null;
    for (Element element in list) {
      if (element.className == className) return element;
    }
    return null;
  }

  static parseSkillsFromWeb() async {
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
      _writeJsonData("data/wilds/charms.json", {'data': allCharms.map((e) => e.toJson()).toList()});
    } else {
      throw Exception();
    }
  }

  static parseArmorFromWeb() async {
    final response = await http.Client().get(Uri.parse('https://mhwilds.kiranico.com/data/armor-series'));
    if (response.statusCode == 200) {
      var doc = parse(response.body);
      var table = _findElement(doc, 'tbody', '[&_tr:last-child]:border-0 text-sm')!;

      var parts = {
        'Head': Part.helm,
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
              Skill? p, s;
              BonusSkill? bonus, group;
              int pLvl = 0, sLvl = 0;
              for (var skillElement in skillsElement.children) {
                var skillName = skillElement.children[0].attributes['href']!.replaceAll('/data/skills/', '');
                var lvl = int.parse(skillElement.children[0].text.split('+')[1]);
                Skill? t = Skill.fromStringNullable(skillName);
                if (t != null) {
                  if (p == null) {
                    p = t;
                    pLvl = lvl;
                  } else if (s == null) {
                    s = t;
                    sLvl = lvl;
                  } else {
                    print('Armor piece $name has more than 2 skills: $p, $s, $t');
                  }
                } else {
                  BonusSkill? t2 = BonusSkill.fromStringNullable(skillName);
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
              _addEquipment(armor);

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
    _writeJsonData("data/wilds/armor.json", {'data': allArmors.map((e) => e.toJson()).toList()});
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
              BonusSkill? bonus = armorBonusesMap[skillName.replaceAll('\'jiiva', '\'jiva')];
              if (bonus == null) {
                print('No skill and armor bonus for "$skillName"');
                continue;
              }
              // TODO
              //armor = armor.copyWith(armorBonus: bonus);
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

  SkillCategory get category;

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
class Skill with _$Skill, SkillTemplate {
  const Skill._();

  const factory Skill(
      {required String name,
      @Default(null) String? altName,
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
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _Skill && name == other.name);
  }

  @override
  int get hashCode => name.hashCode;
}

@freezed
class BonusSkill with _$BonusSkill, SkillTemplate {
  const BonusSkill._();

  const factory BonusSkill(
      {required String name,
      @Default(null) String? altName,
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
      @JsonKey(fromJson: BonusSkill.fromStringNullable, toJson: BonusSkill.asString) BonusSkill? groupBonus,
      @JsonKey(fromJson: BonusSkill.fromStringNullable, toJson: BonusSkill.asString) BonusSkill? setBonus,
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

@freezed
class Weapon with _$Weapon, Equipment {
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
}
