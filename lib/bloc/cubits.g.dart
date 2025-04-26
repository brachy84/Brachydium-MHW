// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cubits.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SearcherState _$SearcherStateFromJson(Map<String, dynamic> json) =>
    _SearcherState(
      skills: _jsonToSkills(json['skills'] as Map<String, dynamic>),
      blacklistedArmors: _jsonToArmor(json['blacklistedArmors'] as List),
      decos: _jsonToDecos(json['decos'] as Map<String, dynamic>),
      useAllDecos: json['useAllDecos'] as bool,
      charms: _jsonToCharms(json['charms'] as Map<String, dynamic>),
      useAllCharms: json['useAllCharms'] as bool,
      minRarity: (json['minRarity'] as num).toInt(),
      maxRarity: (json['maxRarity'] as num).toInt(),
    );

Map<String, dynamic> _$SearcherStateToJson(_SearcherState instance) =>
    <String, dynamic>{
      'skills': _skillsToJson(instance.skills),
      'blacklistedArmors': _armorToJson(instance.blacklistedArmors),
      'decos': _decosToJson(instance.decos),
      'useAllDecos': instance.useAllDecos,
      'charms': _charmsToJson(instance.charms),
      'useAllCharms': instance.useAllCharms,
      'minRarity': instance.minRarity,
      'maxRarity': instance.maxRarity,
    };
