// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SkillImpl _$$SkillImplFromJson(Map<String, dynamic> json) => _$SkillImpl(
      name: json['name'] as String,
      altName: json['altName'] as String? ?? null,
      category: $enumDecode(_$SkillCategoryEnumMap, json['category']),
      maxLevel: (json['maxLevel'] as num).toInt(),
      desc: json['desc'] as String,
    );

Map<String, dynamic> _$$SkillImplToJson(_$SkillImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'altName': instance.altName,
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

_$BonusSkillImpl _$$BonusSkillImplFromJson(Map<String, dynamic> json) =>
    _$BonusSkillImpl(
      name: json['name'] as String,
      altName: json['altName'] as String? ?? null,
      category: $enumDecode(_$SkillCategoryEnumMap, json['category']),
      maxLevel: (json['maxLevel'] as num).toInt(),
      primaryCount: (json['primaryCount'] as num).toInt(),
      secondaryCount: (json['secondaryCount'] as num).toInt(),
      primaryDesc: json['primaryDesc'] as String,
      secondaryDesc: json['secondaryDesc'] as String,
    );

Map<String, dynamic> _$$BonusSkillImplToJson(_$BonusSkillImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'altName': instance.altName,
      'category': _$SkillCategoryEnumMap[instance.category]!,
      'maxLevel': instance.maxLevel,
      'primaryCount': instance.primaryCount,
      'secondaryCount': instance.secondaryCount,
      'primaryDesc': instance.primaryDesc,
      'secondaryDesc': instance.secondaryDesc,
    };

_$ArmorImpl _$$ArmorImplFromJson(Map<String, dynamic> json) => _$ArmorImpl(
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

Map<String, dynamic> _$$ArmorImplToJson(_$ArmorImpl instance) =>
    <String, dynamic>{
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
  Part.helm: 'helm',
  Part.chest: 'chest',
  Part.arm: 'arm',
  Part.waist: 'waist',
  Part.leg: 'leg',
  Part.charm: 'charm',
  Part.weapon: 'weapon',
};

_$DecoImpl _$$DecoImplFromJson(Map<String, dynamic> json) => _$DecoImpl(
      name: json['name'] as String,
      primary: Skill.fromString(json['primary'] as String),
      secondary: Skill.fromStringNullable(json['secondary'] as String?),
      primaryLvl: (json['primaryLvl'] as num).toInt(),
      size: (json['size'] as num).toInt(),
    );

Map<String, dynamic> _$$DecoImplToJson(_$DecoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'primary': Skill.asString(instance.primary),
      'secondary': Skill.asString(instance.secondary),
      'primaryLvl': instance.primaryLvl,
      'size': instance.size,
    };

_$CharmImpl _$$CharmImplFromJson(Map<String, dynamic> json) => _$CharmImpl(
      name: json['name'] as String,
      rarity: (json['rarity'] as num).toInt(),
      primary: Skill.fromString(json['primary'] as String),
      secondary: Skill.fromStringNullable(json['secondary'] as String?),
      ternary: Skill.fromStringNullable(json['ternary'] as String?),
      primaryLv: (json['primaryLv'] as num).toInt(),
      secondaryLv: (json['secondaryLv'] as num?)?.toInt() ?? 0,
      ternaryLv: (json['ternaryLv'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$CharmImplToJson(_$CharmImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'rarity': instance.rarity,
      'primary': Skill.asString(instance.primary),
      'secondary': Skill.asString(instance.secondary),
      'ternary': Skill.asString(instance.ternary),
      'primaryLv': instance.primaryLv,
      'secondaryLv': instance.secondaryLv,
      'ternaryLv': instance.ternaryLv,
    };
