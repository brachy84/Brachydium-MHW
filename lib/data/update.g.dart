// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Update _$UpdateFromJson(Map<String, dynamic> json) => _Update(
      id: json['id'] as String,
      minVersion: json['minVersion'] as String,
      availableSince: DateTime.parse(json['availableSince'] as String),
      updateVersion: (json['updateVersion'] as num?)?.toInt() ?? 0,
      ignore: json['ignore'] as bool? ?? false,
    );

Map<String, dynamic> _$UpdateToJson(_Update instance) => <String, dynamic>{
      'id': instance.id,
      'minVersion': instance.minVersion,
      'availableSince': instance.availableSince.toIso8601String(),
      'updateVersion': instance.updateVersion,
      'ignore': instance.ignore,
    };
