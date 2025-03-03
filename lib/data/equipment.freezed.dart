// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'equipment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ArmorBonus _$ArmorBonusFromJson(Map<String, dynamic> json) {
  return _ArmorBonus.fromJson(json);
}

/// @nodoc
mixin _$ArmorBonus {
  String get name => throw _privateConstructorUsedError;
  String? get altName => throw _privateConstructorUsedError;
  String get primaryBonusSkill => throw _privateConstructorUsedError;
  String? get secondaryBonusSkill => throw _privateConstructorUsedError;
  int get primaryReq => throw _privateConstructorUsedError;
  int get secondaryReq => throw _privateConstructorUsedError;
  String? get primaryBonusDesc => throw _privateConstructorUsedError;
  String? get secondaryBonusDesc => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  Skill? get primarySkillSecret => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  Skill? get secondarySkillSecret => throw _privateConstructorUsedError;

  /// Serializes this ArmorBonus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ArmorBonus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArmorBonusCopyWith<ArmorBonus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArmorBonusCopyWith<$Res> {
  factory $ArmorBonusCopyWith(
          ArmorBonus value, $Res Function(ArmorBonus) then) =
      _$ArmorBonusCopyWithImpl<$Res, ArmorBonus>;
  @useResult
  $Res call(
      {String name,
      String? altName,
      String primaryBonusSkill,
      String? secondaryBonusSkill,
      int primaryReq,
      int secondaryReq,
      String? primaryBonusDesc,
      String? secondaryBonusDesc,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      Skill? primarySkillSecret,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      Skill? secondarySkillSecret});

  $SkillCopyWith<$Res>? get primarySkillSecret;
  $SkillCopyWith<$Res>? get secondarySkillSecret;
}

/// @nodoc
class _$ArmorBonusCopyWithImpl<$Res, $Val extends ArmorBonus>
    implements $ArmorBonusCopyWith<$Res> {
  _$ArmorBonusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ArmorBonus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? altName = freezed,
    Object? primaryBonusSkill = null,
    Object? secondaryBonusSkill = freezed,
    Object? primaryReq = null,
    Object? secondaryReq = null,
    Object? primaryBonusDesc = freezed,
    Object? secondaryBonusDesc = freezed,
    Object? primarySkillSecret = freezed,
    Object? secondarySkillSecret = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      altName: freezed == altName
          ? _value.altName
          : altName // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryBonusSkill: null == primaryBonusSkill
          ? _value.primaryBonusSkill
          : primaryBonusSkill // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryBonusSkill: freezed == secondaryBonusSkill
          ? _value.secondaryBonusSkill
          : secondaryBonusSkill // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryReq: null == primaryReq
          ? _value.primaryReq
          : primaryReq // ignore: cast_nullable_to_non_nullable
              as int,
      secondaryReq: null == secondaryReq
          ? _value.secondaryReq
          : secondaryReq // ignore: cast_nullable_to_non_nullable
              as int,
      primaryBonusDesc: freezed == primaryBonusDesc
          ? _value.primaryBonusDesc
          : primaryBonusDesc // ignore: cast_nullable_to_non_nullable
              as String?,
      secondaryBonusDesc: freezed == secondaryBonusDesc
          ? _value.secondaryBonusDesc
          : secondaryBonusDesc // ignore: cast_nullable_to_non_nullable
              as String?,
      primarySkillSecret: freezed == primarySkillSecret
          ? _value.primarySkillSecret
          : primarySkillSecret // ignore: cast_nullable_to_non_nullable
              as Skill?,
      secondarySkillSecret: freezed == secondarySkillSecret
          ? _value.secondarySkillSecret
          : secondarySkillSecret // ignore: cast_nullable_to_non_nullable
              as Skill?,
    ) as $Val);
  }

  /// Create a copy of ArmorBonus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res>? get primarySkillSecret {
    if (_value.primarySkillSecret == null) {
      return null;
    }

    return $SkillCopyWith<$Res>(_value.primarySkillSecret!, (value) {
      return _then(_value.copyWith(primarySkillSecret: value) as $Val);
    });
  }

  /// Create a copy of ArmorBonus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res>? get secondarySkillSecret {
    if (_value.secondarySkillSecret == null) {
      return null;
    }

    return $SkillCopyWith<$Res>(_value.secondarySkillSecret!, (value) {
      return _then(_value.copyWith(secondarySkillSecret: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ArmorBonusImplCopyWith<$Res>
    implements $ArmorBonusCopyWith<$Res> {
  factory _$$ArmorBonusImplCopyWith(
          _$ArmorBonusImpl value, $Res Function(_$ArmorBonusImpl) then) =
      __$$ArmorBonusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String? altName,
      String primaryBonusSkill,
      String? secondaryBonusSkill,
      int primaryReq,
      int secondaryReq,
      String? primaryBonusDesc,
      String? secondaryBonusDesc,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      Skill? primarySkillSecret,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      Skill? secondarySkillSecret});

  @override
  $SkillCopyWith<$Res>? get primarySkillSecret;
  @override
  $SkillCopyWith<$Res>? get secondarySkillSecret;
}

/// @nodoc
class __$$ArmorBonusImplCopyWithImpl<$Res>
    extends _$ArmorBonusCopyWithImpl<$Res, _$ArmorBonusImpl>
    implements _$$ArmorBonusImplCopyWith<$Res> {
  __$$ArmorBonusImplCopyWithImpl(
      _$ArmorBonusImpl _value, $Res Function(_$ArmorBonusImpl) _then)
      : super(_value, _then);

  /// Create a copy of ArmorBonus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? altName = freezed,
    Object? primaryBonusSkill = null,
    Object? secondaryBonusSkill = freezed,
    Object? primaryReq = null,
    Object? secondaryReq = null,
    Object? primaryBonusDesc = freezed,
    Object? secondaryBonusDesc = freezed,
    Object? primarySkillSecret = freezed,
    Object? secondarySkillSecret = freezed,
  }) {
    return _then(_$ArmorBonusImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      altName: freezed == altName
          ? _value.altName
          : altName // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryBonusSkill: null == primaryBonusSkill
          ? _value.primaryBonusSkill
          : primaryBonusSkill // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryBonusSkill: freezed == secondaryBonusSkill
          ? _value.secondaryBonusSkill
          : secondaryBonusSkill // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryReq: null == primaryReq
          ? _value.primaryReq
          : primaryReq // ignore: cast_nullable_to_non_nullable
              as int,
      secondaryReq: null == secondaryReq
          ? _value.secondaryReq
          : secondaryReq // ignore: cast_nullable_to_non_nullable
              as int,
      primaryBonusDesc: freezed == primaryBonusDesc
          ? _value.primaryBonusDesc
          : primaryBonusDesc // ignore: cast_nullable_to_non_nullable
              as String?,
      secondaryBonusDesc: freezed == secondaryBonusDesc
          ? _value.secondaryBonusDesc
          : secondaryBonusDesc // ignore: cast_nullable_to_non_nullable
              as String?,
      primarySkillSecret: freezed == primarySkillSecret
          ? _value.primarySkillSecret
          : primarySkillSecret // ignore: cast_nullable_to_non_nullable
              as Skill?,
      secondarySkillSecret: freezed == secondarySkillSecret
          ? _value.secondarySkillSecret
          : secondarySkillSecret // ignore: cast_nullable_to_non_nullable
              as Skill?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ArmorBonusImpl extends _ArmorBonus {
  const _$ArmorBonusImpl(
      {required this.name,
      this.altName = null,
      required this.primaryBonusSkill,
      this.secondaryBonusSkill = null,
      required this.primaryReq,
      this.secondaryReq = 0,
      this.primaryBonusDesc = null,
      this.secondaryBonusDesc = null,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      this.primarySkillSecret,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      this.secondarySkillSecret})
      : super._();

  factory _$ArmorBonusImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArmorBonusImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey()
  final String? altName;
  @override
  final String primaryBonusSkill;
  @override
  @JsonKey()
  final String? secondaryBonusSkill;
  @override
  final int primaryReq;
  @override
  @JsonKey()
  final int secondaryReq;
  @override
  @JsonKey()
  final String? primaryBonusDesc;
  @override
  @JsonKey()
  final String? secondaryBonusDesc;
  @override
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  final Skill? primarySkillSecret;
  @override
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  final Skill? secondarySkillSecret;

  @override
  String toString() {
    return 'ArmorBonus(name: $name, altName: $altName, primaryBonusSkill: $primaryBonusSkill, secondaryBonusSkill: $secondaryBonusSkill, primaryReq: $primaryReq, secondaryReq: $secondaryReq, primaryBonusDesc: $primaryBonusDesc, secondaryBonusDesc: $secondaryBonusDesc, primarySkillSecret: $primarySkillSecret, secondarySkillSecret: $secondarySkillSecret)';
  }

  /// Create a copy of ArmorBonus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArmorBonusImplCopyWith<_$ArmorBonusImpl> get copyWith =>
      __$$ArmorBonusImplCopyWithImpl<_$ArmorBonusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArmorBonusImplToJson(
      this,
    );
  }
}

abstract class _ArmorBonus extends ArmorBonus {
  const factory _ArmorBonus(
      {required final String name,
      final String? altName,
      required final String primaryBonusSkill,
      final String? secondaryBonusSkill,
      required final int primaryReq,
      final int secondaryReq,
      final String? primaryBonusDesc,
      final String? secondaryBonusDesc,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      final Skill? primarySkillSecret,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      final Skill? secondarySkillSecret}) = _$ArmorBonusImpl;
  const _ArmorBonus._() : super._();

  factory _ArmorBonus.fromJson(Map<String, dynamic> json) =
      _$ArmorBonusImpl.fromJson;

  @override
  String get name;
  @override
  String? get altName;
  @override
  String get primaryBonusSkill;
  @override
  String? get secondaryBonusSkill;
  @override
  int get primaryReq;
  @override
  int get secondaryReq;
  @override
  String? get primaryBonusDesc;
  @override
  String? get secondaryBonusDesc;
  @override
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  Skill? get primarySkillSecret;
  @override
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  Skill? get secondarySkillSecret;

  /// Create a copy of ArmorBonus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArmorBonusImplCopyWith<_$ArmorBonusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Skill _$SkillFromJson(Map<String, dynamic> json) {
  return _Skill.fromJson(json);
}

/// @nodoc
mixin _$Skill {
  String get name => throw _privateConstructorUsedError;
  String? get altName => throw _privateConstructorUsedError;
  int get maxLevel => throw _privateConstructorUsedError;
  int get maxSecretLevel => throw _privateConstructorUsedError;

  /// Serializes this Skill to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SkillCopyWith<Skill> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SkillCopyWith<$Res> {
  factory $SkillCopyWith(Skill value, $Res Function(Skill) then) =
      _$SkillCopyWithImpl<$Res, Skill>;
  @useResult
  $Res call({String name, String? altName, int maxLevel, int maxSecretLevel});
}

/// @nodoc
class _$SkillCopyWithImpl<$Res, $Val extends Skill>
    implements $SkillCopyWith<$Res> {
  _$SkillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? altName = freezed,
    Object? maxLevel = null,
    Object? maxSecretLevel = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      altName: freezed == altName
          ? _value.altName
          : altName // ignore: cast_nullable_to_non_nullable
              as String?,
      maxLevel: null == maxLevel
          ? _value.maxLevel
          : maxLevel // ignore: cast_nullable_to_non_nullable
              as int,
      maxSecretLevel: null == maxSecretLevel
          ? _value.maxSecretLevel
          : maxSecretLevel // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SkillImplCopyWith<$Res> implements $SkillCopyWith<$Res> {
  factory _$$SkillImplCopyWith(
          _$SkillImpl value, $Res Function(_$SkillImpl) then) =
      __$$SkillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? altName, int maxLevel, int maxSecretLevel});
}

/// @nodoc
class __$$SkillImplCopyWithImpl<$Res>
    extends _$SkillCopyWithImpl<$Res, _$SkillImpl>
    implements _$$SkillImplCopyWith<$Res> {
  __$$SkillImplCopyWithImpl(
      _$SkillImpl _value, $Res Function(_$SkillImpl) _then)
      : super(_value, _then);

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? altName = freezed,
    Object? maxLevel = null,
    Object? maxSecretLevel = null,
  }) {
    return _then(_$SkillImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      altName: freezed == altName
          ? _value.altName
          : altName // ignore: cast_nullable_to_non_nullable
              as String?,
      maxLevel: null == maxLevel
          ? _value.maxLevel
          : maxLevel // ignore: cast_nullable_to_non_nullable
              as int,
      maxSecretLevel: null == maxSecretLevel
          ? _value.maxSecretLevel
          : maxSecretLevel // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SkillImpl extends _Skill {
  const _$SkillImpl(
      {required this.name,
      this.altName = null,
      required this.maxLevel,
      this.maxSecretLevel = 0})
      : super._();

  factory _$SkillImpl.fromJson(Map<String, dynamic> json) =>
      _$$SkillImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey()
  final String? altName;
  @override
  final int maxLevel;
  @override
  @JsonKey()
  final int maxSecretLevel;

  @override
  String toString() {
    return 'Skill(name: $name, altName: $altName, maxLevel: $maxLevel, maxSecretLevel: $maxSecretLevel)';
  }

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SkillImplCopyWith<_$SkillImpl> get copyWith =>
      __$$SkillImplCopyWithImpl<_$SkillImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SkillImplToJson(
      this,
    );
  }
}

abstract class _Skill extends Skill {
  const factory _Skill(
      {required final String name,
      final String? altName,
      required final int maxLevel,
      final int maxSecretLevel}) = _$SkillImpl;
  const _Skill._() : super._();

  factory _Skill.fromJson(Map<String, dynamic> json) = _$SkillImpl.fromJson;

  @override
  String get name;
  @override
  String? get altName;
  @override
  int get maxLevel;
  @override
  int get maxSecretLevel;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SkillImplCopyWith<_$SkillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Armor _$ArmorFromJson(Map<String, dynamic> json) {
  return _Armor.fromJson(json);
}

/// @nodoc
mixin _$Armor {
  String get name => throw _privateConstructorUsedError;
  Part get part => throw _privateConstructorUsedError;
  int get rarity => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
  Skill get primary => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  Skill? get secondary => throw _privateConstructorUsedError;
  @JsonKey(fromJson: ArmorBonus.fromStringNullable, toJson: ArmorBonus.asString)
  ArmorBonus? get armorBonus => throw _privateConstructorUsedError;
  int get primaryLv => throw _privateConstructorUsedError;
  int get secondaryLv => throw _privateConstructorUsedError;
  int get primarySlotSize => throw _privateConstructorUsedError;
  int get secondarySlotSize => throw _privateConstructorUsedError;
  int get ternarySlotSize => throw _privateConstructorUsedError;
  int get minDef => throw _privateConstructorUsedError;
  int get maxDef => throw _privateConstructorUsedError;
  int get defFire => throw _privateConstructorUsedError;
  int get defWater => throw _privateConstructorUsedError;
  int get defThunder => throw _privateConstructorUsedError;
  int get defIce => throw _privateConstructorUsedError;
  int get defDragon => throw _privateConstructorUsedError;

  /// Serializes this Armor to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Armor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArmorCopyWith<Armor> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArmorCopyWith<$Res> {
  factory $ArmorCopyWith(Armor value, $Res Function(Armor) then) =
      _$ArmorCopyWithImpl<$Res, Armor>;
  @useResult
  $Res call(
      {String name,
      Part part,
      int rarity,
      @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
      Skill primary,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      Skill? secondary,
      @JsonKey(
          fromJson: ArmorBonus.fromStringNullable, toJson: ArmorBonus.asString)
      ArmorBonus? armorBonus,
      int primaryLv,
      int secondaryLv,
      int primarySlotSize,
      int secondarySlotSize,
      int ternarySlotSize,
      int minDef,
      int maxDef,
      int defFire,
      int defWater,
      int defThunder,
      int defIce,
      int defDragon});

  $SkillCopyWith<$Res> get primary;
  $SkillCopyWith<$Res>? get secondary;
  $ArmorBonusCopyWith<$Res>? get armorBonus;
}

/// @nodoc
class _$ArmorCopyWithImpl<$Res, $Val extends Armor>
    implements $ArmorCopyWith<$Res> {
  _$ArmorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Armor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? part = null,
    Object? rarity = null,
    Object? primary = null,
    Object? secondary = freezed,
    Object? armorBonus = freezed,
    Object? primaryLv = null,
    Object? secondaryLv = null,
    Object? primarySlotSize = null,
    Object? secondarySlotSize = null,
    Object? ternarySlotSize = null,
    Object? minDef = null,
    Object? maxDef = null,
    Object? defFire = null,
    Object? defWater = null,
    Object? defThunder = null,
    Object? defIce = null,
    Object? defDragon = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      part: null == part
          ? _value.part
          : part // ignore: cast_nullable_to_non_nullable
              as Part,
      rarity: null == rarity
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      primary: null == primary
          ? _value.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as Skill,
      secondary: freezed == secondary
          ? _value.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as Skill?,
      armorBonus: freezed == armorBonus
          ? _value.armorBonus
          : armorBonus // ignore: cast_nullable_to_non_nullable
              as ArmorBonus?,
      primaryLv: null == primaryLv
          ? _value.primaryLv
          : primaryLv // ignore: cast_nullable_to_non_nullable
              as int,
      secondaryLv: null == secondaryLv
          ? _value.secondaryLv
          : secondaryLv // ignore: cast_nullable_to_non_nullable
              as int,
      primarySlotSize: null == primarySlotSize
          ? _value.primarySlotSize
          : primarySlotSize // ignore: cast_nullable_to_non_nullable
              as int,
      secondarySlotSize: null == secondarySlotSize
          ? _value.secondarySlotSize
          : secondarySlotSize // ignore: cast_nullable_to_non_nullable
              as int,
      ternarySlotSize: null == ternarySlotSize
          ? _value.ternarySlotSize
          : ternarySlotSize // ignore: cast_nullable_to_non_nullable
              as int,
      minDef: null == minDef
          ? _value.minDef
          : minDef // ignore: cast_nullable_to_non_nullable
              as int,
      maxDef: null == maxDef
          ? _value.maxDef
          : maxDef // ignore: cast_nullable_to_non_nullable
              as int,
      defFire: null == defFire
          ? _value.defFire
          : defFire // ignore: cast_nullable_to_non_nullable
              as int,
      defWater: null == defWater
          ? _value.defWater
          : defWater // ignore: cast_nullable_to_non_nullable
              as int,
      defThunder: null == defThunder
          ? _value.defThunder
          : defThunder // ignore: cast_nullable_to_non_nullable
              as int,
      defIce: null == defIce
          ? _value.defIce
          : defIce // ignore: cast_nullable_to_non_nullable
              as int,
      defDragon: null == defDragon
          ? _value.defDragon
          : defDragon // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of Armor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res> get primary {
    return $SkillCopyWith<$Res>(_value.primary, (value) {
      return _then(_value.copyWith(primary: value) as $Val);
    });
  }

  /// Create a copy of Armor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res>? get secondary {
    if (_value.secondary == null) {
      return null;
    }

    return $SkillCopyWith<$Res>(_value.secondary!, (value) {
      return _then(_value.copyWith(secondary: value) as $Val);
    });
  }

  /// Create a copy of Armor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ArmorBonusCopyWith<$Res>? get armorBonus {
    if (_value.armorBonus == null) {
      return null;
    }

    return $ArmorBonusCopyWith<$Res>(_value.armorBonus!, (value) {
      return _then(_value.copyWith(armorBonus: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ArmorImplCopyWith<$Res> implements $ArmorCopyWith<$Res> {
  factory _$$ArmorImplCopyWith(
          _$ArmorImpl value, $Res Function(_$ArmorImpl) then) =
      __$$ArmorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      Part part,
      int rarity,
      @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
      Skill primary,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      Skill? secondary,
      @JsonKey(
          fromJson: ArmorBonus.fromStringNullable, toJson: ArmorBonus.asString)
      ArmorBonus? armorBonus,
      int primaryLv,
      int secondaryLv,
      int primarySlotSize,
      int secondarySlotSize,
      int ternarySlotSize,
      int minDef,
      int maxDef,
      int defFire,
      int defWater,
      int defThunder,
      int defIce,
      int defDragon});

  @override
  $SkillCopyWith<$Res> get primary;
  @override
  $SkillCopyWith<$Res>? get secondary;
  @override
  $ArmorBonusCopyWith<$Res>? get armorBonus;
}

/// @nodoc
class __$$ArmorImplCopyWithImpl<$Res>
    extends _$ArmorCopyWithImpl<$Res, _$ArmorImpl>
    implements _$$ArmorImplCopyWith<$Res> {
  __$$ArmorImplCopyWithImpl(
      _$ArmorImpl _value, $Res Function(_$ArmorImpl) _then)
      : super(_value, _then);

  /// Create a copy of Armor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? part = null,
    Object? rarity = null,
    Object? primary = null,
    Object? secondary = freezed,
    Object? armorBonus = freezed,
    Object? primaryLv = null,
    Object? secondaryLv = null,
    Object? primarySlotSize = null,
    Object? secondarySlotSize = null,
    Object? ternarySlotSize = null,
    Object? minDef = null,
    Object? maxDef = null,
    Object? defFire = null,
    Object? defWater = null,
    Object? defThunder = null,
    Object? defIce = null,
    Object? defDragon = null,
  }) {
    return _then(_$ArmorImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      part: null == part
          ? _value.part
          : part // ignore: cast_nullable_to_non_nullable
              as Part,
      rarity: null == rarity
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      primary: null == primary
          ? _value.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as Skill,
      secondary: freezed == secondary
          ? _value.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as Skill?,
      armorBonus: freezed == armorBonus
          ? _value.armorBonus
          : armorBonus // ignore: cast_nullable_to_non_nullable
              as ArmorBonus?,
      primaryLv: null == primaryLv
          ? _value.primaryLv
          : primaryLv // ignore: cast_nullable_to_non_nullable
              as int,
      secondaryLv: null == secondaryLv
          ? _value.secondaryLv
          : secondaryLv // ignore: cast_nullable_to_non_nullable
              as int,
      primarySlotSize: null == primarySlotSize
          ? _value.primarySlotSize
          : primarySlotSize // ignore: cast_nullable_to_non_nullable
              as int,
      secondarySlotSize: null == secondarySlotSize
          ? _value.secondarySlotSize
          : secondarySlotSize // ignore: cast_nullable_to_non_nullable
              as int,
      ternarySlotSize: null == ternarySlotSize
          ? _value.ternarySlotSize
          : ternarySlotSize // ignore: cast_nullable_to_non_nullable
              as int,
      minDef: null == minDef
          ? _value.minDef
          : minDef // ignore: cast_nullable_to_non_nullable
              as int,
      maxDef: null == maxDef
          ? _value.maxDef
          : maxDef // ignore: cast_nullable_to_non_nullable
              as int,
      defFire: null == defFire
          ? _value.defFire
          : defFire // ignore: cast_nullable_to_non_nullable
              as int,
      defWater: null == defWater
          ? _value.defWater
          : defWater // ignore: cast_nullable_to_non_nullable
              as int,
      defThunder: null == defThunder
          ? _value.defThunder
          : defThunder // ignore: cast_nullable_to_non_nullable
              as int,
      defIce: null == defIce
          ? _value.defIce
          : defIce // ignore: cast_nullable_to_non_nullable
              as int,
      defDragon: null == defDragon
          ? _value.defDragon
          : defDragon // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ArmorImpl extends _Armor {
  const _$ArmorImpl(
      {required this.name,
      required this.part,
      required this.rarity,
      @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
      required this.primary,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      this.secondary,
      @JsonKey(
          fromJson: ArmorBonus.fromStringNullable, toJson: ArmorBonus.asString)
      this.armorBonus,
      required this.primaryLv,
      this.secondaryLv = 0,
      required this.primarySlotSize,
      required this.secondarySlotSize,
      required this.ternarySlotSize,
      required this.minDef,
      required this.maxDef,
      required this.defFire,
      required this.defWater,
      required this.defThunder,
      required this.defIce,
      required this.defDragon})
      : super._();

  factory _$ArmorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArmorImplFromJson(json);

  @override
  final String name;
  @override
  final Part part;
  @override
  final int rarity;
  @override
  @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
  final Skill primary;
  @override
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  final Skill? secondary;
  @override
  @JsonKey(fromJson: ArmorBonus.fromStringNullable, toJson: ArmorBonus.asString)
  final ArmorBonus? armorBonus;
  @override
  final int primaryLv;
  @override
  @JsonKey()
  final int secondaryLv;
  @override
  final int primarySlotSize;
  @override
  final int secondarySlotSize;
  @override
  final int ternarySlotSize;
  @override
  final int minDef;
  @override
  final int maxDef;
  @override
  final int defFire;
  @override
  final int defWater;
  @override
  final int defThunder;
  @override
  final int defIce;
  @override
  final int defDragon;

  @override
  String toString() {
    return 'Armor(name: $name, part: $part, rarity: $rarity, primary: $primary, secondary: $secondary, armorBonus: $armorBonus, primaryLv: $primaryLv, secondaryLv: $secondaryLv, primarySlotSize: $primarySlotSize, secondarySlotSize: $secondarySlotSize, ternarySlotSize: $ternarySlotSize, minDef: $minDef, maxDef: $maxDef, defFire: $defFire, defWater: $defWater, defThunder: $defThunder, defIce: $defIce, defDragon: $defDragon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArmorImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.part, part) || other.part == part) &&
            (identical(other.rarity, rarity) || other.rarity == rarity) &&
            (identical(other.primary, primary) || other.primary == primary) &&
            (identical(other.secondary, secondary) ||
                other.secondary == secondary) &&
            (identical(other.armorBonus, armorBonus) ||
                other.armorBonus == armorBonus) &&
            (identical(other.primaryLv, primaryLv) ||
                other.primaryLv == primaryLv) &&
            (identical(other.secondaryLv, secondaryLv) ||
                other.secondaryLv == secondaryLv) &&
            (identical(other.primarySlotSize, primarySlotSize) ||
                other.primarySlotSize == primarySlotSize) &&
            (identical(other.secondarySlotSize, secondarySlotSize) ||
                other.secondarySlotSize == secondarySlotSize) &&
            (identical(other.ternarySlotSize, ternarySlotSize) ||
                other.ternarySlotSize == ternarySlotSize) &&
            (identical(other.minDef, minDef) || other.minDef == minDef) &&
            (identical(other.maxDef, maxDef) || other.maxDef == maxDef) &&
            (identical(other.defFire, defFire) || other.defFire == defFire) &&
            (identical(other.defWater, defWater) ||
                other.defWater == defWater) &&
            (identical(other.defThunder, defThunder) ||
                other.defThunder == defThunder) &&
            (identical(other.defIce, defIce) || other.defIce == defIce) &&
            (identical(other.defDragon, defDragon) ||
                other.defDragon == defDragon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      part,
      rarity,
      primary,
      secondary,
      armorBonus,
      primaryLv,
      secondaryLv,
      primarySlotSize,
      secondarySlotSize,
      ternarySlotSize,
      minDef,
      maxDef,
      defFire,
      defWater,
      defThunder,
      defIce,
      defDragon);

  /// Create a copy of Armor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArmorImplCopyWith<_$ArmorImpl> get copyWith =>
      __$$ArmorImplCopyWithImpl<_$ArmorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArmorImplToJson(
      this,
    );
  }
}

abstract class _Armor extends Armor {
  const factory _Armor(
      {required final String name,
      required final Part part,
      required final int rarity,
      @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
      required final Skill primary,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      final Skill? secondary,
      @JsonKey(
          fromJson: ArmorBonus.fromStringNullable, toJson: ArmorBonus.asString)
      final ArmorBonus? armorBonus,
      required final int primaryLv,
      final int secondaryLv,
      required final int primarySlotSize,
      required final int secondarySlotSize,
      required final int ternarySlotSize,
      required final int minDef,
      required final int maxDef,
      required final int defFire,
      required final int defWater,
      required final int defThunder,
      required final int defIce,
      required final int defDragon}) = _$ArmorImpl;
  const _Armor._() : super._();

  factory _Armor.fromJson(Map<String, dynamic> json) = _$ArmorImpl.fromJson;

  @override
  String get name;
  @override
  Part get part;
  @override
  int get rarity;
  @override
  @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
  Skill get primary;
  @override
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  Skill? get secondary;
  @override
  @JsonKey(fromJson: ArmorBonus.fromStringNullable, toJson: ArmorBonus.asString)
  ArmorBonus? get armorBonus;
  @override
  int get primaryLv;
  @override
  int get secondaryLv;
  @override
  int get primarySlotSize;
  @override
  int get secondarySlotSize;
  @override
  int get ternarySlotSize;
  @override
  int get minDef;
  @override
  int get maxDef;
  @override
  int get defFire;
  @override
  int get defWater;
  @override
  int get defThunder;
  @override
  int get defIce;
  @override
  int get defDragon;

  /// Create a copy of Armor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArmorImplCopyWith<_$ArmorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Deco _$DecoFromJson(Map<String, dynamic> json) {
  return _Deco.fromJson(json);
}

/// @nodoc
mixin _$Deco {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
  Skill get primary => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  Skill? get secondary => throw _privateConstructorUsedError;
  int get primaryLvl => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;

  /// Serializes this Deco to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Deco
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DecoCopyWith<Deco> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DecoCopyWith<$Res> {
  factory $DecoCopyWith(Deco value, $Res Function(Deco) then) =
      _$DecoCopyWithImpl<$Res, Deco>;
  @useResult
  $Res call(
      {String name,
      @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
      Skill primary,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      Skill? secondary,
      int primaryLvl,
      int size});

  $SkillCopyWith<$Res> get primary;
  $SkillCopyWith<$Res>? get secondary;
}

/// @nodoc
class _$DecoCopyWithImpl<$Res, $Val extends Deco>
    implements $DecoCopyWith<$Res> {
  _$DecoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Deco
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? primary = null,
    Object? secondary = freezed,
    Object? primaryLvl = null,
    Object? size = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      primary: null == primary
          ? _value.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as Skill,
      secondary: freezed == secondary
          ? _value.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as Skill?,
      primaryLvl: null == primaryLvl
          ? _value.primaryLvl
          : primaryLvl // ignore: cast_nullable_to_non_nullable
              as int,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of Deco
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res> get primary {
    return $SkillCopyWith<$Res>(_value.primary, (value) {
      return _then(_value.copyWith(primary: value) as $Val);
    });
  }

  /// Create a copy of Deco
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res>? get secondary {
    if (_value.secondary == null) {
      return null;
    }

    return $SkillCopyWith<$Res>(_value.secondary!, (value) {
      return _then(_value.copyWith(secondary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DecoImplCopyWith<$Res> implements $DecoCopyWith<$Res> {
  factory _$$DecoImplCopyWith(
          _$DecoImpl value, $Res Function(_$DecoImpl) then) =
      __$$DecoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
      Skill primary,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      Skill? secondary,
      int primaryLvl,
      int size});

  @override
  $SkillCopyWith<$Res> get primary;
  @override
  $SkillCopyWith<$Res>? get secondary;
}

/// @nodoc
class __$$DecoImplCopyWithImpl<$Res>
    extends _$DecoCopyWithImpl<$Res, _$DecoImpl>
    implements _$$DecoImplCopyWith<$Res> {
  __$$DecoImplCopyWithImpl(_$DecoImpl _value, $Res Function(_$DecoImpl) _then)
      : super(_value, _then);

  /// Create a copy of Deco
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? primary = null,
    Object? secondary = freezed,
    Object? primaryLvl = null,
    Object? size = null,
  }) {
    return _then(_$DecoImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      primary: null == primary
          ? _value.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as Skill,
      secondary: freezed == secondary
          ? _value.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as Skill?,
      primaryLvl: null == primaryLvl
          ? _value.primaryLvl
          : primaryLvl // ignore: cast_nullable_to_non_nullable
              as int,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DecoImpl extends _Deco {
  const _$DecoImpl(
      {required this.name,
      @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
      required this.primary,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      this.secondary,
      required this.primaryLvl,
      required this.size})
      : super._();

  factory _$DecoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DecoImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
  final Skill primary;
  @override
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  final Skill? secondary;
  @override
  final int primaryLvl;
  @override
  final int size;

  @override
  String toString() {
    return 'Deco(name: $name, primary: $primary, secondary: $secondary, primaryLvl: $primaryLvl, size: $size)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DecoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.primary, primary) || other.primary == primary) &&
            (identical(other.secondary, secondary) ||
                other.secondary == secondary) &&
            (identical(other.primaryLvl, primaryLvl) ||
                other.primaryLvl == primaryLvl) &&
            (identical(other.size, size) || other.size == size));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, primary, secondary, primaryLvl, size);

  /// Create a copy of Deco
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DecoImplCopyWith<_$DecoImpl> get copyWith =>
      __$$DecoImplCopyWithImpl<_$DecoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DecoImplToJson(
      this,
    );
  }
}

abstract class _Deco extends Deco {
  const factory _Deco(
      {required final String name,
      @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
      required final Skill primary,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      final Skill? secondary,
      required final int primaryLvl,
      required final int size}) = _$DecoImpl;
  const _Deco._() : super._();

  factory _Deco.fromJson(Map<String, dynamic> json) = _$DecoImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
  Skill get primary;
  @override
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  Skill? get secondary;
  @override
  int get primaryLvl;
  @override
  int get size;

  /// Create a copy of Deco
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DecoImplCopyWith<_$DecoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Charm _$CharmFromJson(Map<String, dynamic> json) {
  return _Charm.fromJson(json);
}

/// @nodoc
mixin _$Charm {
  String get name => throw _privateConstructorUsedError;
  int get rarity => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
  Skill get primary => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  Skill? get secondary => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  Skill? get ternary => throw _privateConstructorUsedError;
  int get primaryLv => throw _privateConstructorUsedError;
  int get secondaryLv => throw _privateConstructorUsedError;
  int get ternaryLv => throw _privateConstructorUsedError;

  /// Serializes this Charm to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Charm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CharmCopyWith<Charm> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharmCopyWith<$Res> {
  factory $CharmCopyWith(Charm value, $Res Function(Charm) then) =
      _$CharmCopyWithImpl<$Res, Charm>;
  @useResult
  $Res call(
      {String name,
      int rarity,
      @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
      Skill primary,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      Skill? secondary,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      Skill? ternary,
      int primaryLv,
      int secondaryLv,
      int ternaryLv});

  $SkillCopyWith<$Res> get primary;
  $SkillCopyWith<$Res>? get secondary;
  $SkillCopyWith<$Res>? get ternary;
}

/// @nodoc
class _$CharmCopyWithImpl<$Res, $Val extends Charm>
    implements $CharmCopyWith<$Res> {
  _$CharmCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Charm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? rarity = null,
    Object? primary = null,
    Object? secondary = freezed,
    Object? ternary = freezed,
    Object? primaryLv = null,
    Object? secondaryLv = null,
    Object? ternaryLv = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rarity: null == rarity
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      primary: null == primary
          ? _value.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as Skill,
      secondary: freezed == secondary
          ? _value.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as Skill?,
      ternary: freezed == ternary
          ? _value.ternary
          : ternary // ignore: cast_nullable_to_non_nullable
              as Skill?,
      primaryLv: null == primaryLv
          ? _value.primaryLv
          : primaryLv // ignore: cast_nullable_to_non_nullable
              as int,
      secondaryLv: null == secondaryLv
          ? _value.secondaryLv
          : secondaryLv // ignore: cast_nullable_to_non_nullable
              as int,
      ternaryLv: null == ternaryLv
          ? _value.ternaryLv
          : ternaryLv // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of Charm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res> get primary {
    return $SkillCopyWith<$Res>(_value.primary, (value) {
      return _then(_value.copyWith(primary: value) as $Val);
    });
  }

  /// Create a copy of Charm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res>? get secondary {
    if (_value.secondary == null) {
      return null;
    }

    return $SkillCopyWith<$Res>(_value.secondary!, (value) {
      return _then(_value.copyWith(secondary: value) as $Val);
    });
  }

  /// Create a copy of Charm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res>? get ternary {
    if (_value.ternary == null) {
      return null;
    }

    return $SkillCopyWith<$Res>(_value.ternary!, (value) {
      return _then(_value.copyWith(ternary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CharmImplCopyWith<$Res> implements $CharmCopyWith<$Res> {
  factory _$$CharmImplCopyWith(
          _$CharmImpl value, $Res Function(_$CharmImpl) then) =
      __$$CharmImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      int rarity,
      @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
      Skill primary,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      Skill? secondary,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      Skill? ternary,
      int primaryLv,
      int secondaryLv,
      int ternaryLv});

  @override
  $SkillCopyWith<$Res> get primary;
  @override
  $SkillCopyWith<$Res>? get secondary;
  @override
  $SkillCopyWith<$Res>? get ternary;
}

/// @nodoc
class __$$CharmImplCopyWithImpl<$Res>
    extends _$CharmCopyWithImpl<$Res, _$CharmImpl>
    implements _$$CharmImplCopyWith<$Res> {
  __$$CharmImplCopyWithImpl(
      _$CharmImpl _value, $Res Function(_$CharmImpl) _then)
      : super(_value, _then);

  /// Create a copy of Charm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? rarity = null,
    Object? primary = null,
    Object? secondary = freezed,
    Object? ternary = freezed,
    Object? primaryLv = null,
    Object? secondaryLv = null,
    Object? ternaryLv = null,
  }) {
    return _then(_$CharmImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rarity: null == rarity
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      primary: null == primary
          ? _value.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as Skill,
      secondary: freezed == secondary
          ? _value.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as Skill?,
      ternary: freezed == ternary
          ? _value.ternary
          : ternary // ignore: cast_nullable_to_non_nullable
              as Skill?,
      primaryLv: null == primaryLv
          ? _value.primaryLv
          : primaryLv // ignore: cast_nullable_to_non_nullable
              as int,
      secondaryLv: null == secondaryLv
          ? _value.secondaryLv
          : secondaryLv // ignore: cast_nullable_to_non_nullable
              as int,
      ternaryLv: null == ternaryLv
          ? _value.ternaryLv
          : ternaryLv // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CharmImpl extends _Charm {
  const _$CharmImpl(
      {required this.name,
      required this.rarity,
      @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
      required this.primary,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      this.secondary,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      this.ternary,
      required this.primaryLv,
      this.secondaryLv = 0,
      this.ternaryLv = 0})
      : super._();

  factory _$CharmImpl.fromJson(Map<String, dynamic> json) =>
      _$$CharmImplFromJson(json);

  @override
  final String name;
  @override
  final int rarity;
  @override
  @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
  final Skill primary;
  @override
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  final Skill? secondary;
  @override
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  final Skill? ternary;
  @override
  final int primaryLv;
  @override
  @JsonKey()
  final int secondaryLv;
  @override
  @JsonKey()
  final int ternaryLv;

  @override
  String toString() {
    return 'Charm(name: $name, rarity: $rarity, primary: $primary, secondary: $secondary, ternary: $ternary, primaryLv: $primaryLv, secondaryLv: $secondaryLv, ternaryLv: $ternaryLv)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharmImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.rarity, rarity) || other.rarity == rarity) &&
            (identical(other.primary, primary) || other.primary == primary) &&
            (identical(other.secondary, secondary) ||
                other.secondary == secondary) &&
            (identical(other.ternary, ternary) || other.ternary == ternary) &&
            (identical(other.primaryLv, primaryLv) ||
                other.primaryLv == primaryLv) &&
            (identical(other.secondaryLv, secondaryLv) ||
                other.secondaryLv == secondaryLv) &&
            (identical(other.ternaryLv, ternaryLv) ||
                other.ternaryLv == ternaryLv));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, rarity, primary, secondary,
      ternary, primaryLv, secondaryLv, ternaryLv);

  /// Create a copy of Charm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CharmImplCopyWith<_$CharmImpl> get copyWith =>
      __$$CharmImplCopyWithImpl<_$CharmImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CharmImplToJson(
      this,
    );
  }
}

abstract class _Charm extends Charm {
  const factory _Charm(
      {required final String name,
      required final int rarity,
      @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
      required final Skill primary,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      final Skill? secondary,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      final Skill? ternary,
      required final int primaryLv,
      final int secondaryLv,
      final int ternaryLv}) = _$CharmImpl;
  const _Charm._() : super._();

  factory _Charm.fromJson(Map<String, dynamic> json) = _$CharmImpl.fromJson;

  @override
  String get name;
  @override
  int get rarity;
  @override
  @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
  Skill get primary;
  @override
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  Skill? get secondary;
  @override
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  Skill? get ternary;
  @override
  int get primaryLv;
  @override
  int get secondaryLv;
  @override
  int get ternaryLv;

  /// Create a copy of Charm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CharmImplCopyWith<_$CharmImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
