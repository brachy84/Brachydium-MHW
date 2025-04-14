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

Skill _$SkillFromJson(Map<String, dynamic> json) {
  return _Skill.fromJson(json);
}

/// @nodoc
mixin _$Skill {
  String get name => throw _privateConstructorUsedError;
  SkillCategory get category => throw _privateConstructorUsedError;
  int get maxLevel => throw _privateConstructorUsedError;
  String get desc => throw _privateConstructorUsedError;

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
  $Res call({String name, SkillCategory category, int maxLevel, String desc});
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
    Object? category = null,
    Object? maxLevel = null,
    Object? desc = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as SkillCategory,
      maxLevel: null == maxLevel
          ? _value.maxLevel
          : maxLevel // ignore: cast_nullable_to_non_nullable
              as int,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
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
  $Res call({String name, SkillCategory category, int maxLevel, String desc});
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
    Object? category = null,
    Object? maxLevel = null,
    Object? desc = null,
  }) {
    return _then(_$SkillImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as SkillCategory,
      maxLevel: null == maxLevel
          ? _value.maxLevel
          : maxLevel // ignore: cast_nullable_to_non_nullable
              as int,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SkillImpl extends _Skill {
  const _$SkillImpl(
      {required this.name,
      required this.category,
      required this.maxLevel,
      required this.desc})
      : super._();

  factory _$SkillImpl.fromJson(Map<String, dynamic> json) =>
      _$$SkillImplFromJson(json);

  @override
  final String name;
  @override
  final SkillCategory category;
  @override
  final int maxLevel;
  @override
  final String desc;

  @override
  String toString() {
    return 'Skill(name: $name, category: $category, maxLevel: $maxLevel, desc: $desc)';
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
      required final SkillCategory category,
      required final int maxLevel,
      required final String desc}) = _$SkillImpl;
  const _Skill._() : super._();

  factory _Skill.fromJson(Map<String, dynamic> json) = _$SkillImpl.fromJson;

  @override
  String get name;
  @override
  SkillCategory get category;
  @override
  int get maxLevel;
  @override
  String get desc;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SkillImplCopyWith<_$SkillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BonusSkill _$BonusSkillFromJson(Map<String, dynamic> json) {
  return _BonusSkill.fromJson(json);
}

/// @nodoc
mixin _$BonusSkill {
  String get name => throw _privateConstructorUsedError;
  SkillCategory get category => throw _privateConstructorUsedError;
  int get maxLevel => throw _privateConstructorUsedError;
  int get primaryCount => throw _privateConstructorUsedError;
  int get secondaryCount => throw _privateConstructorUsedError;
  String get primaryDesc => throw _privateConstructorUsedError;
  String get secondaryDesc => throw _privateConstructorUsedError;

  /// Serializes this BonusSkill to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BonusSkill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BonusSkillCopyWith<BonusSkill> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BonusSkillCopyWith<$Res> {
  factory $BonusSkillCopyWith(
          BonusSkill value, $Res Function(BonusSkill) then) =
      _$BonusSkillCopyWithImpl<$Res, BonusSkill>;
  @useResult
  $Res call(
      {String name,
      SkillCategory category,
      int maxLevel,
      int primaryCount,
      int secondaryCount,
      String primaryDesc,
      String secondaryDesc});
}

/// @nodoc
class _$BonusSkillCopyWithImpl<$Res, $Val extends BonusSkill>
    implements $BonusSkillCopyWith<$Res> {
  _$BonusSkillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BonusSkill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? category = null,
    Object? maxLevel = null,
    Object? primaryCount = null,
    Object? secondaryCount = null,
    Object? primaryDesc = null,
    Object? secondaryDesc = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as SkillCategory,
      maxLevel: null == maxLevel
          ? _value.maxLevel
          : maxLevel // ignore: cast_nullable_to_non_nullable
              as int,
      primaryCount: null == primaryCount
          ? _value.primaryCount
          : primaryCount // ignore: cast_nullable_to_non_nullable
              as int,
      secondaryCount: null == secondaryCount
          ? _value.secondaryCount
          : secondaryCount // ignore: cast_nullable_to_non_nullable
              as int,
      primaryDesc: null == primaryDesc
          ? _value.primaryDesc
          : primaryDesc // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryDesc: null == secondaryDesc
          ? _value.secondaryDesc
          : secondaryDesc // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BonusSkillImplCopyWith<$Res>
    implements $BonusSkillCopyWith<$Res> {
  factory _$$BonusSkillImplCopyWith(
          _$BonusSkillImpl value, $Res Function(_$BonusSkillImpl) then) =
      __$$BonusSkillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      SkillCategory category,
      int maxLevel,
      int primaryCount,
      int secondaryCount,
      String primaryDesc,
      String secondaryDesc});
}

/// @nodoc
class __$$BonusSkillImplCopyWithImpl<$Res>
    extends _$BonusSkillCopyWithImpl<$Res, _$BonusSkillImpl>
    implements _$$BonusSkillImplCopyWith<$Res> {
  __$$BonusSkillImplCopyWithImpl(
      _$BonusSkillImpl _value, $Res Function(_$BonusSkillImpl) _then)
      : super(_value, _then);

  /// Create a copy of BonusSkill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? category = null,
    Object? maxLevel = null,
    Object? primaryCount = null,
    Object? secondaryCount = null,
    Object? primaryDesc = null,
    Object? secondaryDesc = null,
  }) {
    return _then(_$BonusSkillImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as SkillCategory,
      maxLevel: null == maxLevel
          ? _value.maxLevel
          : maxLevel // ignore: cast_nullable_to_non_nullable
              as int,
      primaryCount: null == primaryCount
          ? _value.primaryCount
          : primaryCount // ignore: cast_nullable_to_non_nullable
              as int,
      secondaryCount: null == secondaryCount
          ? _value.secondaryCount
          : secondaryCount // ignore: cast_nullable_to_non_nullable
              as int,
      primaryDesc: null == primaryDesc
          ? _value.primaryDesc
          : primaryDesc // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryDesc: null == secondaryDesc
          ? _value.secondaryDesc
          : secondaryDesc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BonusSkillImpl extends _BonusSkill {
  const _$BonusSkillImpl(
      {required this.name,
      required this.category,
      required this.maxLevel,
      required this.primaryCount,
      required this.secondaryCount,
      required this.primaryDesc,
      required this.secondaryDesc})
      : super._();

  factory _$BonusSkillImpl.fromJson(Map<String, dynamic> json) =>
      _$$BonusSkillImplFromJson(json);

  @override
  final String name;
  @override
  final SkillCategory category;
  @override
  final int maxLevel;
  @override
  final int primaryCount;
  @override
  final int secondaryCount;
  @override
  final String primaryDesc;
  @override
  final String secondaryDesc;

  @override
  String toString() {
    return 'BonusSkill(name: $name, category: $category, maxLevel: $maxLevel, primaryCount: $primaryCount, secondaryCount: $secondaryCount, primaryDesc: $primaryDesc, secondaryDesc: $secondaryDesc)';
  }

  /// Create a copy of BonusSkill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BonusSkillImplCopyWith<_$BonusSkillImpl> get copyWith =>
      __$$BonusSkillImplCopyWithImpl<_$BonusSkillImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BonusSkillImplToJson(
      this,
    );
  }
}

abstract class _BonusSkill extends BonusSkill {
  const factory _BonusSkill(
      {required final String name,
      required final SkillCategory category,
      required final int maxLevel,
      required final int primaryCount,
      required final int secondaryCount,
      required final String primaryDesc,
      required final String secondaryDesc}) = _$BonusSkillImpl;
  const _BonusSkill._() : super._();

  factory _BonusSkill.fromJson(Map<String, dynamic> json) =
      _$BonusSkillImpl.fromJson;

  @override
  String get name;
  @override
  SkillCategory get category;
  @override
  int get maxLevel;
  @override
  int get primaryCount;
  @override
  int get secondaryCount;
  @override
  String get primaryDesc;
  @override
  String get secondaryDesc;

  /// Create a copy of BonusSkill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BonusSkillImplCopyWith<_$BonusSkillImpl> get copyWith =>
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
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  Skill? get ternary => throw _privateConstructorUsedError;
  @JsonKey(fromJson: BonusSkill.fromStringNullable, toJson: BonusSkill.asString)
  BonusSkill? get groupBonus => throw _privateConstructorUsedError;
  @JsonKey(fromJson: BonusSkill.fromStringNullable, toJson: BonusSkill.asString)
  BonusSkill? get setBonus => throw _privateConstructorUsedError;
  int get primaryLv => throw _privateConstructorUsedError;
  int get secondaryLv => throw _privateConstructorUsedError;
  int get ternaryLv => throw _privateConstructorUsedError;
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
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      Skill? ternary,
      @JsonKey(
          fromJson: BonusSkill.fromStringNullable, toJson: BonusSkill.asString)
      BonusSkill? groupBonus,
      @JsonKey(
          fromJson: BonusSkill.fromStringNullable, toJson: BonusSkill.asString)
      BonusSkill? setBonus,
      int primaryLv,
      int secondaryLv,
      int ternaryLv,
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
  $SkillCopyWith<$Res>? get ternary;
  $BonusSkillCopyWith<$Res>? get groupBonus;
  $BonusSkillCopyWith<$Res>? get setBonus;
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
    Object? ternary = freezed,
    Object? groupBonus = freezed,
    Object? setBonus = freezed,
    Object? primaryLv = null,
    Object? secondaryLv = null,
    Object? ternaryLv = null,
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
      ternary: freezed == ternary
          ? _value.ternary
          : ternary // ignore: cast_nullable_to_non_nullable
              as Skill?,
      groupBonus: freezed == groupBonus
          ? _value.groupBonus
          : groupBonus // ignore: cast_nullable_to_non_nullable
              as BonusSkill?,
      setBonus: freezed == setBonus
          ? _value.setBonus
          : setBonus // ignore: cast_nullable_to_non_nullable
              as BonusSkill?,
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
  $SkillCopyWith<$Res>? get ternary {
    if (_value.ternary == null) {
      return null;
    }

    return $SkillCopyWith<$Res>(_value.ternary!, (value) {
      return _then(_value.copyWith(ternary: value) as $Val);
    });
  }

  /// Create a copy of Armor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BonusSkillCopyWith<$Res>? get groupBonus {
    if (_value.groupBonus == null) {
      return null;
    }

    return $BonusSkillCopyWith<$Res>(_value.groupBonus!, (value) {
      return _then(_value.copyWith(groupBonus: value) as $Val);
    });
  }

  /// Create a copy of Armor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BonusSkillCopyWith<$Res>? get setBonus {
    if (_value.setBonus == null) {
      return null;
    }

    return $BonusSkillCopyWith<$Res>(_value.setBonus!, (value) {
      return _then(_value.copyWith(setBonus: value) as $Val);
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
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      Skill? ternary,
      @JsonKey(
          fromJson: BonusSkill.fromStringNullable, toJson: BonusSkill.asString)
      BonusSkill? groupBonus,
      @JsonKey(
          fromJson: BonusSkill.fromStringNullable, toJson: BonusSkill.asString)
      BonusSkill? setBonus,
      int primaryLv,
      int secondaryLv,
      int ternaryLv,
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
  $SkillCopyWith<$Res>? get ternary;
  @override
  $BonusSkillCopyWith<$Res>? get groupBonus;
  @override
  $BonusSkillCopyWith<$Res>? get setBonus;
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
    Object? ternary = freezed,
    Object? groupBonus = freezed,
    Object? setBonus = freezed,
    Object? primaryLv = null,
    Object? secondaryLv = null,
    Object? ternaryLv = null,
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
      ternary: freezed == ternary
          ? _value.ternary
          : ternary // ignore: cast_nullable_to_non_nullable
              as Skill?,
      groupBonus: freezed == groupBonus
          ? _value.groupBonus
          : groupBonus // ignore: cast_nullable_to_non_nullable
              as BonusSkill?,
      setBonus: freezed == setBonus
          ? _value.setBonus
          : setBonus // ignore: cast_nullable_to_non_nullable
              as BonusSkill?,
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
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      this.ternary,
      @JsonKey(
          fromJson: BonusSkill.fromStringNullable, toJson: BonusSkill.asString)
      this.groupBonus,
      @JsonKey(
          fromJson: BonusSkill.fromStringNullable, toJson: BonusSkill.asString)
      this.setBonus,
      required this.primaryLv,
      this.secondaryLv = 0,
      this.ternaryLv = 0,
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
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  final Skill? ternary;
  @override
  @JsonKey(fromJson: BonusSkill.fromStringNullable, toJson: BonusSkill.asString)
  final BonusSkill? groupBonus;
  @override
  @JsonKey(fromJson: BonusSkill.fromStringNullable, toJson: BonusSkill.asString)
  final BonusSkill? setBonus;
  @override
  final int primaryLv;
  @override
  @JsonKey()
  final int secondaryLv;
  @override
  @JsonKey()
  final int ternaryLv;
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
    return 'Armor(name: $name, part: $part, rarity: $rarity, primary: $primary, secondary: $secondary, ternary: $ternary, groupBonus: $groupBonus, setBonus: $setBonus, primaryLv: $primaryLv, secondaryLv: $secondaryLv, ternaryLv: $ternaryLv, primarySlotSize: $primarySlotSize, secondarySlotSize: $secondarySlotSize, ternarySlotSize: $ternarySlotSize, minDef: $minDef, maxDef: $maxDef, defFire: $defFire, defWater: $defWater, defThunder: $defThunder, defIce: $defIce, defDragon: $defDragon)';
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
            (identical(other.ternary, ternary) || other.ternary == ternary) &&
            (identical(other.groupBonus, groupBonus) ||
                other.groupBonus == groupBonus) &&
            (identical(other.setBonus, setBonus) ||
                other.setBonus == setBonus) &&
            (identical(other.primaryLv, primaryLv) ||
                other.primaryLv == primaryLv) &&
            (identical(other.secondaryLv, secondaryLv) ||
                other.secondaryLv == secondaryLv) &&
            (identical(other.ternaryLv, ternaryLv) ||
                other.ternaryLv == ternaryLv) &&
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
  int get hashCode => Object.hashAll([
        runtimeType,
        name,
        part,
        rarity,
        primary,
        secondary,
        ternary,
        groupBonus,
        setBonus,
        primaryLv,
        secondaryLv,
        ternaryLv,
        primarySlotSize,
        secondarySlotSize,
        ternarySlotSize,
        minDef,
        maxDef,
        defFire,
        defWater,
        defThunder,
        defIce,
        defDragon
      ]);

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
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      final Skill? ternary,
      @JsonKey(
          fromJson: BonusSkill.fromStringNullable, toJson: BonusSkill.asString)
      final BonusSkill? groupBonus,
      @JsonKey(
          fromJson: BonusSkill.fromStringNullable, toJson: BonusSkill.asString)
      final BonusSkill? setBonus,
      required final int primaryLv,
      final int secondaryLv,
      final int ternaryLv,
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
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  Skill? get ternary;
  @override
  @JsonKey(fromJson: BonusSkill.fromStringNullable, toJson: BonusSkill.asString)
  BonusSkill? get groupBonus;
  @override
  @JsonKey(fromJson: BonusSkill.fromStringNullable, toJson: BonusSkill.asString)
  BonusSkill? get setBonus;
  @override
  int get primaryLv;
  @override
  int get secondaryLv;
  @override
  int get ternaryLv;
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

/// @nodoc
mixin _$Weapon {
  String get name => throw _privateConstructorUsedError;
  WeaponType get type => throw _privateConstructorUsedError;
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

  /// Create a copy of Weapon
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeaponCopyWith<Weapon> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeaponCopyWith<$Res> {
  factory $WeaponCopyWith(Weapon value, $Res Function(Weapon) then) =
      _$WeaponCopyWithImpl<$Res, Weapon>;
  @useResult
  $Res call(
      {String name,
      WeaponType type,
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
class _$WeaponCopyWithImpl<$Res, $Val extends Weapon>
    implements $WeaponCopyWith<$Res> {
  _$WeaponCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Weapon
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WeaponType,
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

  /// Create a copy of Weapon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res> get primary {
    return $SkillCopyWith<$Res>(_value.primary, (value) {
      return _then(_value.copyWith(primary: value) as $Val);
    });
  }

  /// Create a copy of Weapon
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

  /// Create a copy of Weapon
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
abstract class _$$WeaponImplCopyWith<$Res> implements $WeaponCopyWith<$Res> {
  factory _$$WeaponImplCopyWith(
          _$WeaponImpl value, $Res Function(_$WeaponImpl) then) =
      __$$WeaponImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      WeaponType type,
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
class __$$WeaponImplCopyWithImpl<$Res>
    extends _$WeaponCopyWithImpl<$Res, _$WeaponImpl>
    implements _$$WeaponImplCopyWith<$Res> {
  __$$WeaponImplCopyWithImpl(
      _$WeaponImpl _value, $Res Function(_$WeaponImpl) _then)
      : super(_value, _then);

  /// Create a copy of Weapon
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? rarity = null,
    Object? primary = null,
    Object? secondary = freezed,
    Object? ternary = freezed,
    Object? primaryLv = null,
    Object? secondaryLv = null,
    Object? ternaryLv = null,
  }) {
    return _then(_$WeaponImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WeaponType,
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

class _$WeaponImpl extends _Weapon {
  const _$WeaponImpl(
      {required this.name,
      required this.type,
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

  @override
  final String name;
  @override
  final WeaponType type;
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
    return 'Weapon(name: $name, type: $type, rarity: $rarity, primary: $primary, secondary: $secondary, ternary: $ternary, primaryLv: $primaryLv, secondaryLv: $secondaryLv, ternaryLv: $ternaryLv)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeaponImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
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

  @override
  int get hashCode => Object.hash(runtimeType, name, type, rarity, primary,
      secondary, ternary, primaryLv, secondaryLv, ternaryLv);

  /// Create a copy of Weapon
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeaponImplCopyWith<_$WeaponImpl> get copyWith =>
      __$$WeaponImplCopyWithImpl<_$WeaponImpl>(this, _$identity);
}

abstract class _Weapon extends Weapon {
  const factory _Weapon(
      {required final String name,
      required final WeaponType type,
      required final int rarity,
      @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
      required final Skill primary,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      final Skill? secondary,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      final Skill? ternary,
      required final int primaryLv,
      final int secondaryLv,
      final int ternaryLv}) = _$WeaponImpl;
  const _Weapon._() : super._();

  @override
  String get name;
  @override
  WeaponType get type;
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

  /// Create a copy of Weapon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeaponImplCopyWith<_$WeaponImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EquipmentPiece _$EquipmentPieceFromJson(Map<String, dynamic> json) {
  return _EquipmentPiece.fromJson(json);
}

/// @nodoc
mixin _$EquipmentPiece {
  @JsonKey(fromJson: Equipment.fromString, toJson: Equipment.asString)
  Equipment get equipment => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _jsonToDecoList, toJson: _decoListToJson)
  List<Deco?> get decorations => throw _privateConstructorUsedError;

  /// Serializes this EquipmentPiece to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EquipmentPiece
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EquipmentPieceCopyWith<EquipmentPiece> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EquipmentPieceCopyWith<$Res> {
  factory $EquipmentPieceCopyWith(
          EquipmentPiece value, $Res Function(EquipmentPiece) then) =
      _$EquipmentPieceCopyWithImpl<$Res, EquipmentPiece>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: Equipment.fromString, toJson: Equipment.asString)
      Equipment equipment,
      @JsonKey(fromJson: _jsonToDecoList, toJson: _decoListToJson)
      List<Deco?> decorations});
}

/// @nodoc
class _$EquipmentPieceCopyWithImpl<$Res, $Val extends EquipmentPiece>
    implements $EquipmentPieceCopyWith<$Res> {
  _$EquipmentPieceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EquipmentPiece
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? equipment = null,
    Object? decorations = null,
  }) {
    return _then(_value.copyWith(
      equipment: null == equipment
          ? _value.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as Equipment,
      decorations: null == decorations
          ? _value.decorations
          : decorations // ignore: cast_nullable_to_non_nullable
              as List<Deco?>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EquipmentPieceImplCopyWith<$Res>
    implements $EquipmentPieceCopyWith<$Res> {
  factory _$$EquipmentPieceImplCopyWith(_$EquipmentPieceImpl value,
          $Res Function(_$EquipmentPieceImpl) then) =
      __$$EquipmentPieceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: Equipment.fromString, toJson: Equipment.asString)
      Equipment equipment,
      @JsonKey(fromJson: _jsonToDecoList, toJson: _decoListToJson)
      List<Deco?> decorations});
}

/// @nodoc
class __$$EquipmentPieceImplCopyWithImpl<$Res>
    extends _$EquipmentPieceCopyWithImpl<$Res, _$EquipmentPieceImpl>
    implements _$$EquipmentPieceImplCopyWith<$Res> {
  __$$EquipmentPieceImplCopyWithImpl(
      _$EquipmentPieceImpl _value, $Res Function(_$EquipmentPieceImpl) _then)
      : super(_value, _then);

  /// Create a copy of EquipmentPiece
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? equipment = null,
    Object? decorations = null,
  }) {
    return _then(_$EquipmentPieceImpl(
      equipment: null == equipment
          ? _value.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as Equipment,
      decorations: null == decorations
          ? _value._decorations
          : decorations // ignore: cast_nullable_to_non_nullable
              as List<Deco?>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EquipmentPieceImpl extends _EquipmentPiece {
  const _$EquipmentPieceImpl(
      {@JsonKey(fromJson: Equipment.fromString, toJson: Equipment.asString)
      required this.equipment,
      @JsonKey(fromJson: _jsonToDecoList, toJson: _decoListToJson)
      required final List<Deco?> decorations})
      : _decorations = decorations,
        super._();

  factory _$EquipmentPieceImpl.fromJson(Map<String, dynamic> json) =>
      _$$EquipmentPieceImplFromJson(json);

  @override
  @JsonKey(fromJson: Equipment.fromString, toJson: Equipment.asString)
  final Equipment equipment;
  final List<Deco?> _decorations;
  @override
  @JsonKey(fromJson: _jsonToDecoList, toJson: _decoListToJson)
  List<Deco?> get decorations {
    if (_decorations is EqualUnmodifiableListView) return _decorations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_decorations);
  }

  @override
  String toString() {
    return 'EquipmentPiece(equipment: $equipment, decorations: $decorations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EquipmentPieceImpl &&
            (identical(other.equipment, equipment) ||
                other.equipment == equipment) &&
            const DeepCollectionEquality()
                .equals(other._decorations, _decorations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, equipment,
      const DeepCollectionEquality().hash(_decorations));

  /// Create a copy of EquipmentPiece
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EquipmentPieceImplCopyWith<_$EquipmentPieceImpl> get copyWith =>
      __$$EquipmentPieceImplCopyWithImpl<_$EquipmentPieceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EquipmentPieceImplToJson(
      this,
    );
  }
}

abstract class _EquipmentPiece extends EquipmentPiece {
  const factory _EquipmentPiece(
      {@JsonKey(fromJson: Equipment.fromString, toJson: Equipment.asString)
      required final Equipment equipment,
      @JsonKey(fromJson: _jsonToDecoList, toJson: _decoListToJson)
      required final List<Deco?> decorations}) = _$EquipmentPieceImpl;
  const _EquipmentPiece._() : super._();

  factory _EquipmentPiece.fromJson(Map<String, dynamic> json) =
      _$EquipmentPieceImpl.fromJson;

  @override
  @JsonKey(fromJson: Equipment.fromString, toJson: Equipment.asString)
  Equipment get equipment;
  @override
  @JsonKey(fromJson: _jsonToDecoList, toJson: _decoListToJson)
  List<Deco?> get decorations;

  /// Create a copy of EquipmentPiece
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EquipmentPieceImplCopyWith<_$EquipmentPieceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ArmorSet _$ArmorSetFromJson(Map<String, dynamic> json) {
  return _ArmorSet.fromJson(json);
}

/// @nodoc
mixin _$ArmorSet {
  @JsonKey(fromJson: _jsonToDecoList, toJson: _decoListToJson)
  List<Deco?> get weaponDecos => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _jsonToEquipmentList, toJson: _equipmentListToJson)
  List<EquipmentPiece> get pieces => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Charm.fromString, toJson: Equipment.asString)
  Charm get charm => throw _privateConstructorUsedError;

  /// Serializes this ArmorSet to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ArmorSet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArmorSetCopyWith<ArmorSet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArmorSetCopyWith<$Res> {
  factory $ArmorSetCopyWith(ArmorSet value, $Res Function(ArmorSet) then) =
      _$ArmorSetCopyWithImpl<$Res, ArmorSet>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: _jsonToDecoList, toJson: _decoListToJson)
      List<Deco?> weaponDecos,
      @JsonKey(fromJson: _jsonToEquipmentList, toJson: _equipmentListToJson)
      List<EquipmentPiece> pieces,
      @JsonKey(fromJson: Charm.fromString, toJson: Equipment.asString)
      Charm charm});

  $CharmCopyWith<$Res> get charm;
}

/// @nodoc
class _$ArmorSetCopyWithImpl<$Res, $Val extends ArmorSet>
    implements $ArmorSetCopyWith<$Res> {
  _$ArmorSetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ArmorSet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weaponDecos = null,
    Object? pieces = null,
    Object? charm = null,
  }) {
    return _then(_value.copyWith(
      weaponDecos: null == weaponDecos
          ? _value.weaponDecos
          : weaponDecos // ignore: cast_nullable_to_non_nullable
              as List<Deco?>,
      pieces: null == pieces
          ? _value.pieces
          : pieces // ignore: cast_nullable_to_non_nullable
              as List<EquipmentPiece>,
      charm: null == charm
          ? _value.charm
          : charm // ignore: cast_nullable_to_non_nullable
              as Charm,
    ) as $Val);
  }

  /// Create a copy of ArmorSet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CharmCopyWith<$Res> get charm {
    return $CharmCopyWith<$Res>(_value.charm, (value) {
      return _then(_value.copyWith(charm: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ArmorSetImplCopyWith<$Res>
    implements $ArmorSetCopyWith<$Res> {
  factory _$$ArmorSetImplCopyWith(
          _$ArmorSetImpl value, $Res Function(_$ArmorSetImpl) then) =
      __$$ArmorSetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: _jsonToDecoList, toJson: _decoListToJson)
      List<Deco?> weaponDecos,
      @JsonKey(fromJson: _jsonToEquipmentList, toJson: _equipmentListToJson)
      List<EquipmentPiece> pieces,
      @JsonKey(fromJson: Charm.fromString, toJson: Equipment.asString)
      Charm charm});

  @override
  $CharmCopyWith<$Res> get charm;
}

/// @nodoc
class __$$ArmorSetImplCopyWithImpl<$Res>
    extends _$ArmorSetCopyWithImpl<$Res, _$ArmorSetImpl>
    implements _$$ArmorSetImplCopyWith<$Res> {
  __$$ArmorSetImplCopyWithImpl(
      _$ArmorSetImpl _value, $Res Function(_$ArmorSetImpl) _then)
      : super(_value, _then);

  /// Create a copy of ArmorSet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weaponDecos = null,
    Object? pieces = null,
    Object? charm = null,
  }) {
    return _then(_$ArmorSetImpl(
      weaponDecos: null == weaponDecos
          ? _value._weaponDecos
          : weaponDecos // ignore: cast_nullable_to_non_nullable
              as List<Deco?>,
      pieces: null == pieces
          ? _value._pieces
          : pieces // ignore: cast_nullable_to_non_nullable
              as List<EquipmentPiece>,
      charm: null == charm
          ? _value.charm
          : charm // ignore: cast_nullable_to_non_nullable
              as Charm,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ArmorSetImpl extends _ArmorSet {
  const _$ArmorSetImpl(
      {@JsonKey(fromJson: _jsonToDecoList, toJson: _decoListToJson)
      required final List<Deco?> weaponDecos,
      @JsonKey(fromJson: _jsonToEquipmentList, toJson: _equipmentListToJson)
      required final List<EquipmentPiece> pieces,
      @JsonKey(fromJson: Charm.fromString, toJson: Equipment.asString)
      required this.charm})
      : _weaponDecos = weaponDecos,
        _pieces = pieces,
        super._();

  factory _$ArmorSetImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArmorSetImplFromJson(json);

  final List<Deco?> _weaponDecos;
  @override
  @JsonKey(fromJson: _jsonToDecoList, toJson: _decoListToJson)
  List<Deco?> get weaponDecos {
    if (_weaponDecos is EqualUnmodifiableListView) return _weaponDecos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weaponDecos);
  }

  final List<EquipmentPiece> _pieces;
  @override
  @JsonKey(fromJson: _jsonToEquipmentList, toJson: _equipmentListToJson)
  List<EquipmentPiece> get pieces {
    if (_pieces is EqualUnmodifiableListView) return _pieces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pieces);
  }

  @override
  @JsonKey(fromJson: Charm.fromString, toJson: Equipment.asString)
  final Charm charm;

  @override
  String toString() {
    return 'ArmorSet(weaponDecos: $weaponDecos, pieces: $pieces, charm: $charm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArmorSetImpl &&
            const DeepCollectionEquality()
                .equals(other._weaponDecos, _weaponDecos) &&
            const DeepCollectionEquality().equals(other._pieces, _pieces) &&
            (identical(other.charm, charm) || other.charm == charm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_weaponDecos),
      const DeepCollectionEquality().hash(_pieces),
      charm);

  /// Create a copy of ArmorSet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArmorSetImplCopyWith<_$ArmorSetImpl> get copyWith =>
      __$$ArmorSetImplCopyWithImpl<_$ArmorSetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArmorSetImplToJson(
      this,
    );
  }
}

abstract class _ArmorSet extends ArmorSet {
  const factory _ArmorSet(
      {@JsonKey(fromJson: _jsonToDecoList, toJson: _decoListToJson)
      required final List<Deco?> weaponDecos,
      @JsonKey(fromJson: _jsonToEquipmentList, toJson: _equipmentListToJson)
      required final List<EquipmentPiece> pieces,
      @JsonKey(fromJson: Charm.fromString, toJson: Equipment.asString)
      required final Charm charm}) = _$ArmorSetImpl;
  const _ArmorSet._() : super._();

  factory _ArmorSet.fromJson(Map<String, dynamic> json) =
      _$ArmorSetImpl.fromJson;

  @override
  @JsonKey(fromJson: _jsonToDecoList, toJson: _decoListToJson)
  List<Deco?> get weaponDecos;
  @override
  @JsonKey(fromJson: _jsonToEquipmentList, toJson: _equipmentListToJson)
  List<EquipmentPiece> get pieces;
  @override
  @JsonKey(fromJson: Charm.fromString, toJson: Equipment.asString)
  Charm get charm;

  /// Create a copy of ArmorSet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArmorSetImplCopyWith<_$ArmorSetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
