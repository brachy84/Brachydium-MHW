// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Skill _$SkillFromJson(Map<String, dynamic> json) => _Skill(
      name: json['name'] as String,
      category: $enumDecode(_$SkillCategoryEnumMap, json['category']),
      maxLevel: (json['maxLevel'] as num).toInt(),
      desc: json['desc'] as String,
    );

Map<String, dynamic> _$SkillToJson(_Skill instance) => <String, dynamic>{
      'name': instance.name,
      'category': _$SkillCategoryEnumMap[instance.category]!,
      'maxLevel': instance.maxLevel,
      'desc': instance.desc,
    };

const _$SkillCategoryEnumMap = {
  SkillCategory.weapon: 'weapon',
  SkillCategory.armor: 'armor',
  SkillCategory.groupBonus: 'groupBonus',
  SkillCategory.setBonus: 'setBonus',
};

_BonusSkill _$BonusSkillFromJson(Map<String, dynamic> json) => _BonusSkill(
      name: json['name'] as String,
      category: $enumDecode(_$SkillCategoryEnumMap, json['category']),
      maxLevel: (json['maxLevel'] as num).toInt(),
      primaryCount: (json['primaryCount'] as num).toInt(),
      secondaryCount: (json['secondaryCount'] as num).toInt(),
      primaryDesc: json['primaryDesc'] as String,
      secondaryDesc: json['secondaryDesc'] as String,
    );

Map<String, dynamic> _$BonusSkillToJson(_BonusSkill instance) =>
    <String, dynamic>{
      'name': instance.name,
      'category': _$SkillCategoryEnumMap[instance.category]!,
      'maxLevel': instance.maxLevel,
      'primaryCount': instance.primaryCount,
      'secondaryCount': instance.secondaryCount,
      'primaryDesc': instance.primaryDesc,
      'secondaryDesc': instance.secondaryDesc,
    };

_Armor _$ArmorFromJson(Map<String, dynamic> json) => _Armor(
      name: json['name'] as String,
      part: $enumDecode(_$PartEnumMap, json['part']),
      rarity: (json['rarity'] as num).toInt(),
      primary: Skill.fromString(json['primary'] as String),
      secondary: Skill.fromStringNullable(json['secondary'] as String?),
      ternary: Skill.fromStringNullable(json['ternary'] as String?),
      groupBonus: BonusSkill.fromStringNullable(json['groupBonus'] as String?),
      setBonus: BonusSkill.fromStringNullable(json['setBonus'] as String?),
      primaryLv: (json['primaryLv'] as num).toInt(),
      secondaryLv: (json['secondaryLv'] as num?)?.toInt() ?? 0,
      ternaryLv: (json['ternaryLv'] as num?)?.toInt() ?? 0,
      primarySlotSize: (json['primarySlotSize'] as num).toInt(),
      secondarySlotSize: (json['secondarySlotSize'] as num).toInt(),
      ternarySlotSize: (json['ternarySlotSize'] as num).toInt(),
      minDef: (json['minDef'] as num).toInt(),
      maxDef: (json['maxDef'] as num).toInt(),
      defFire: (json['defFire'] as num).toInt(),
      defWater: (json['defWater'] as num).toInt(),
      defThunder: (json['defThunder'] as num).toInt(),
      defIce: (json['defIce'] as num).toInt(),
      defDragon: (json['defDragon'] as num).toInt(),
    );

Map<String, dynamic> _$ArmorToJson(_Armor instance) => <String, dynamic>{
      'name': instance.name,
      'part': _$PartEnumMap[instance.part]!,
      'rarity': instance.rarity,
      'primary': Skill.asString(instance.primary),
      'secondary': Skill.asString(instance.secondary),
      'ternary': Skill.asString(instance.ternary),
      'groupBonus': BonusSkill.asString(instance.groupBonus),
      'setBonus': BonusSkill.asString(instance.setBonus),
      'primaryLv': instance.primaryLv,
      'secondaryLv': instance.secondaryLv,
      'ternaryLv': instance.ternaryLv,
      'primarySlotSize': instance.primarySlotSize,
      'secondarySlotSize': instance.secondarySlotSize,
      'ternarySlotSize': instance.ternarySlotSize,
      'minDef': instance.minDef,
      'maxDef': instance.maxDef,
      'defFire': instance.defFire,
      'defWater': instance.defWater,
      'defThunder': instance.defThunder,
      'defIce': instance.defIce,
      'defDragon': instance.defDragon,
    };

const _$PartEnumMap = {
  Part.head: 'head',
  Part.chest: 'chest',
  Part.arm: 'arm',
  Part.waist: 'waist',
  Part.leg: 'leg',
  Part.charm: 'charm',
  Part.weapon: 'weapon',
};

_Deco _$DecoFromJson(Map<String, dynamic> json) => _Deco(
      name: json['name'] as String,
      primary: Skill.fromString(json['primary'] as String),
      secondary: Skill.fromStringNullable(json['secondary'] as String?),
      primaryLvl: (json['primaryLvl'] as num).toInt(),
      size: (json['size'] as num).toInt(),
    );

Map<String, dynamic> _$DecoToJson(_Deco instance) => <String, dynamic>{
      'name': instance.name,
      'primary': Skill.asString(instance.primary),
      'secondary': Skill.asString(instance.secondary),
      'primaryLvl': instance.primaryLvl,
      'size': instance.size,
    };

_Charm _$CharmFromJson(Map<String, dynamic> json) => _Charm(
      name: json['name'] as String,
      rarity: (json['rarity'] as num).toInt(),
      primary: Skill.fromString(json['primary'] as String),
      secondary: Skill.fromStringNullable(json['secondary'] as String?),
      ternary: Skill.fromStringNullable(json['ternary'] as String?),
      primaryLv: (json['primaryLv'] as num).toInt(),
      secondaryLv: (json['secondaryLv'] as num?)?.toInt() ?? 0,
      ternaryLv: (json['ternaryLv'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CharmToJson(_Charm instance) => <String, dynamic>{
      'name': instance.name,
      'rarity': instance.rarity,
      'primary': Skill.asString(instance.primary),
      'secondary': Skill.asString(instance.secondary),
      'ternary': Skill.asString(instance.ternary),
      'primaryLv': instance.primaryLv,
      'secondaryLv': instance.secondaryLv,
      'ternaryLv': instance.ternaryLv,
    };

_Weapon _$WeaponFromJson(Map<String, dynamic> json) => _Weapon(
      name: json['name'] as String,
      type: $enumDecode(_$WeaponTypeEnumMap, json['type']),
      rarity: (json['rarity'] as num).toInt(),
      primary: Skill.fromString(json['primary'] as String),
      secondary: Skill.fromStringNullable(json['secondary'] as String?),
      ternary: Skill.fromStringNullable(json['ternary'] as String?),
      primaryLv: (json['primaryLv'] as num).toInt(),
      secondaryLv: (json['secondaryLv'] as num?)?.toInt() ?? 0,
      ternaryLv: (json['ternaryLv'] as num?)?.toInt() ?? 0,
      primarySlotSize: (json['primarySlotSize'] as num).toInt(),
      secondarySlotSize: (json['secondarySlotSize'] as num).toInt(),
      ternarySlotSize: (json['ternarySlotSize'] as num).toInt(),
    );

Map<String, dynamic> _$WeaponToJson(_Weapon instance) => <String, dynamic>{
      'name': instance.name,
      'type': _$WeaponTypeEnumMap[instance.type]!,
      'rarity': instance.rarity,
      'primary': Skill.asString(instance.primary),
      'secondary': Skill.asString(instance.secondary),
      'ternary': Skill.asString(instance.ternary),
      'primaryLv': instance.primaryLv,
      'secondaryLv': instance.secondaryLv,
      'ternaryLv': instance.ternaryLv,
      'primarySlotSize': instance.primarySlotSize,
      'secondarySlotSize': instance.secondarySlotSize,
      'ternarySlotSize': instance.ternarySlotSize,
    };

const _$WeaponTypeEnumMap = {
  WeaponType.gs: 'gs',
  WeaponType.ls: 'ls',
  WeaponType.sns: 'sns',
  WeaponType.db: 'db',
  WeaponType.sa: 'sa',
  WeaponType.hammer: 'hammer',
  WeaponType.hh: 'hh',
  WeaponType.lance: 'lance',
  WeaponType.gl: 'gl',
  WeaponType.ig: 'ig',
  WeaponType.cb: 'cb',
  WeaponType.lbg: 'lbg',
  WeaponType.hbg: 'hbg',
  WeaponType.bow: 'bow',
};

_EquipmentPiece _$EquipmentPieceFromJson(Map<String, dynamic> json) =>
    _EquipmentPiece(
      equipment: Equipment.fromString(json['equipment'] as String),
      decorations: _jsonToDecoList(json['decorations'] as List),
    );

Map<String, dynamic> _$EquipmentPieceToJson(_EquipmentPiece instance) =>
    <String, dynamic>{
      'equipment': Equipment.asString(instance.equipment),
      'decorations': _decoListToJson(instance.decorations),
    };

_ArmorSet _$ArmorSetFromJson(Map<String, dynamic> json) => _ArmorSet(
      weaponDecos: _jsonToDecoList(json['weaponDecos'] as List),
      pieces: _jsonToEquipmentList(json['pieces'] as List),
      charm: Charm.fromString(json['charm'] as String),
    );

Map<String, dynamic> _$ArmorSetToJson(_ArmorSet instance) => <String, dynamic>{
      'weaponDecos': _decoListToJson(instance.weaponDecos),
      'pieces': _equipmentListToJson(instance.pieces),
      'charm': Equipment.asString(instance.charm),
    };
