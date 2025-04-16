// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'equipment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Skill {
  String get name;
  SkillCategory get category;
  int get maxLevel;
  String get desc;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SkillCopyWith<Skill> get copyWith =>
      _$SkillCopyWithImpl<Skill>(this as Skill, _$identity);

  /// Serializes this Skill to a JSON map.
  Map<String, dynamic> toJson();
}

/// @nodoc
abstract mixin class $SkillCopyWith<$Res> {
  factory $SkillCopyWith(Skill value, $Res Function(Skill) _then) =
      _$SkillCopyWithImpl;
  @useResult
  $Res call({String name, SkillCategory category, int maxLevel, String desc});
}

/// @nodoc
class _$SkillCopyWithImpl<$Res> implements $SkillCopyWith<$Res> {
  _$SkillCopyWithImpl(this._self, this._then);

  final Skill _self;
  final $Res Function(Skill) _then;

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
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as SkillCategory,
      maxLevel: null == maxLevel
          ? _self.maxLevel
          : maxLevel // ignore: cast_nullable_to_non_nullable
              as int,
      desc: null == desc
          ? _self.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Skill extends Skill {
  const _Skill(
      {required this.name,
      required this.category,
      required this.maxLevel,
      required this.desc})
      : super._();
  factory _Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);

  @override
  final String name;
  @override
  final SkillCategory category;
  @override
  final int maxLevel;
  @override
  final String desc;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SkillCopyWith<_Skill> get copyWith =>
      __$SkillCopyWithImpl<_Skill>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SkillToJson(
      this,
    );
  }
}

/// @nodoc
abstract mixin class _$SkillCopyWith<$Res> implements $SkillCopyWith<$Res> {
  factory _$SkillCopyWith(_Skill value, $Res Function(_Skill) _then) =
      __$SkillCopyWithImpl;
  @override
  @useResult
  $Res call({String name, SkillCategory category, int maxLevel, String desc});
}

/// @nodoc
class __$SkillCopyWithImpl<$Res> implements _$SkillCopyWith<$Res> {
  __$SkillCopyWithImpl(this._self, this._then);

  final _Skill _self;
  final $Res Function(_Skill) _then;

  /// Create a copy of Skill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? category = null,
    Object? maxLevel = null,
    Object? desc = null,
  }) {
    return _then(_Skill(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as SkillCategory,
      maxLevel: null == maxLevel
          ? _self.maxLevel
          : maxLevel // ignore: cast_nullable_to_non_nullable
              as int,
      desc: null == desc
          ? _self.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$BonusSkill {
  String get name;
  SkillCategory get category;
  int get maxLevel;
  int get primaryCount;
  int get secondaryCount;
  String get primaryDesc;
  String get secondaryDesc;

  /// Create a copy of BonusSkill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BonusSkillCopyWith<BonusSkill> get copyWith =>
      _$BonusSkillCopyWithImpl<BonusSkill>(this as BonusSkill, _$identity);

  /// Serializes this BonusSkill to a JSON map.
  Map<String, dynamic> toJson();
}

/// @nodoc
abstract mixin class $BonusSkillCopyWith<$Res> {
  factory $BonusSkillCopyWith(
          BonusSkill value, $Res Function(BonusSkill) _then) =
      _$BonusSkillCopyWithImpl;
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
class _$BonusSkillCopyWithImpl<$Res> implements $BonusSkillCopyWith<$Res> {
  _$BonusSkillCopyWithImpl(this._self, this._then);

  final BonusSkill _self;
  final $Res Function(BonusSkill) _then;

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
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as SkillCategory,
      maxLevel: null == maxLevel
          ? _self.maxLevel
          : maxLevel // ignore: cast_nullable_to_non_nullable
              as int,
      primaryCount: null == primaryCount
          ? _self.primaryCount
          : primaryCount // ignore: cast_nullable_to_non_nullable
              as int,
      secondaryCount: null == secondaryCount
          ? _self.secondaryCount
          : secondaryCount // ignore: cast_nullable_to_non_nullable
              as int,
      primaryDesc: null == primaryDesc
          ? _self.primaryDesc
          : primaryDesc // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryDesc: null == secondaryDesc
          ? _self.secondaryDesc
          : secondaryDesc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _BonusSkill extends BonusSkill {
  const _BonusSkill(
      {required this.name,
      required this.category,
      required this.maxLevel,
      required this.primaryCount,
      required this.secondaryCount,
      required this.primaryDesc,
      required this.secondaryDesc})
      : super._();
  factory _BonusSkill.fromJson(Map<String, dynamic> json) =>
      _$BonusSkillFromJson(json);

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

  /// Create a copy of BonusSkill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BonusSkillCopyWith<_BonusSkill> get copyWith =>
      __$BonusSkillCopyWithImpl<_BonusSkill>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BonusSkillToJson(
      this,
    );
  }
}

/// @nodoc
abstract mixin class _$BonusSkillCopyWith<$Res>
    implements $BonusSkillCopyWith<$Res> {
  factory _$BonusSkillCopyWith(
          _BonusSkill value, $Res Function(_BonusSkill) _then) =
      __$BonusSkillCopyWithImpl;
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
class __$BonusSkillCopyWithImpl<$Res> implements _$BonusSkillCopyWith<$Res> {
  __$BonusSkillCopyWithImpl(this._self, this._then);

  final _BonusSkill _self;
  final $Res Function(_BonusSkill) _then;

  /// Create a copy of BonusSkill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? category = null,
    Object? maxLevel = null,
    Object? primaryCount = null,
    Object? secondaryCount = null,
    Object? primaryDesc = null,
    Object? secondaryDesc = null,
  }) {
    return _then(_BonusSkill(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as SkillCategory,
      maxLevel: null == maxLevel
          ? _self.maxLevel
          : maxLevel // ignore: cast_nullable_to_non_nullable
              as int,
      primaryCount: null == primaryCount
          ? _self.primaryCount
          : primaryCount // ignore: cast_nullable_to_non_nullable
              as int,
      secondaryCount: null == secondaryCount
          ? _self.secondaryCount
          : secondaryCount // ignore: cast_nullable_to_non_nullable
              as int,
      primaryDesc: null == primaryDesc
          ? _self.primaryDesc
          : primaryDesc // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryDesc: null == secondaryDesc
          ? _self.secondaryDesc
          : secondaryDesc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$Armor {
  String get name;
  Part get part;
  int get rarity;
  @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
  Skill get primary;
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  Skill? get secondary;
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  Skill? get ternary;
  @JsonKey(fromJson: BonusSkill.fromStringNullable, toJson: BonusSkill.asString)
  BonusSkill? get groupBonus;
  @JsonKey(fromJson: BonusSkill.fromStringNullable, toJson: BonusSkill.asString)
  BonusSkill? get setBonus;
  int get primaryLv;
  int get secondaryLv;
  int get ternaryLv;
  int get primarySlotSize;
  int get secondarySlotSize;
  int get ternarySlotSize;
  int get minDef;
  int get maxDef;
  int get defFire;
  int get defWater;
  int get defThunder;
  int get defIce;
  int get defDragon;

  /// Create a copy of Armor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ArmorCopyWith<Armor> get copyWith =>
      _$ArmorCopyWithImpl<Armor>(this as Armor, _$identity);

  /// Serializes this Armor to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Armor &&
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
}

/// @nodoc
abstract mixin class $ArmorCopyWith<$Res> {
  factory $ArmorCopyWith(Armor value, $Res Function(Armor) _then) =
      _$ArmorCopyWithImpl;
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
class _$ArmorCopyWithImpl<$Res> implements $ArmorCopyWith<$Res> {
  _$ArmorCopyWithImpl(this._self, this._then);

  final Armor _self;
  final $Res Function(Armor) _then;

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
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      part: null == part
          ? _self.part
          : part // ignore: cast_nullable_to_non_nullable
              as Part,
      rarity: null == rarity
          ? _self.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      primary: null == primary
          ? _self.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as Skill,
      secondary: freezed == secondary
          ? _self.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as Skill?,
      ternary: freezed == ternary
          ? _self.ternary
          : ternary // ignore: cast_nullable_to_non_nullable
              as Skill?,
      groupBonus: freezed == groupBonus
          ? _self.groupBonus
          : groupBonus // ignore: cast_nullable_to_non_nullable
              as BonusSkill?,
      setBonus: freezed == setBonus
          ? _self.setBonus
          : setBonus // ignore: cast_nullable_to_non_nullable
              as BonusSkill?,
      primaryLv: null == primaryLv
          ? _self.primaryLv
          : primaryLv // ignore: cast_nullable_to_non_nullable
              as int,
      secondaryLv: null == secondaryLv
          ? _self.secondaryLv
          : secondaryLv // ignore: cast_nullable_to_non_nullable
              as int,
      ternaryLv: null == ternaryLv
          ? _self.ternaryLv
          : ternaryLv // ignore: cast_nullable_to_non_nullable
              as int,
      primarySlotSize: null == primarySlotSize
          ? _self.primarySlotSize
          : primarySlotSize // ignore: cast_nullable_to_non_nullable
              as int,
      secondarySlotSize: null == secondarySlotSize
          ? _self.secondarySlotSize
          : secondarySlotSize // ignore: cast_nullable_to_non_nullable
              as int,
      ternarySlotSize: null == ternarySlotSize
          ? _self.ternarySlotSize
          : ternarySlotSize // ignore: cast_nullable_to_non_nullable
              as int,
      minDef: null == minDef
          ? _self.minDef
          : minDef // ignore: cast_nullable_to_non_nullable
              as int,
      maxDef: null == maxDef
          ? _self.maxDef
          : maxDef // ignore: cast_nullable_to_non_nullable
              as int,
      defFire: null == defFire
          ? _self.defFire
          : defFire // ignore: cast_nullable_to_non_nullable
              as int,
      defWater: null == defWater
          ? _self.defWater
          : defWater // ignore: cast_nullable_to_non_nullable
              as int,
      defThunder: null == defThunder
          ? _self.defThunder
          : defThunder // ignore: cast_nullable_to_non_nullable
              as int,
      defIce: null == defIce
          ? _self.defIce
          : defIce // ignore: cast_nullable_to_non_nullable
              as int,
      defDragon: null == defDragon
          ? _self.defDragon
          : defDragon // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of Armor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res> get primary {
    return $SkillCopyWith<$Res>(_self.primary, (value) {
      return _then(_self.copyWith(primary: value));
    });
  }

  /// Create a copy of Armor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res>? get secondary {
    if (_self.secondary == null) {
      return null;
    }

    return $SkillCopyWith<$Res>(_self.secondary!, (value) {
      return _then(_self.copyWith(secondary: value));
    });
  }

  /// Create a copy of Armor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res>? get ternary {
    if (_self.ternary == null) {
      return null;
    }

    return $SkillCopyWith<$Res>(_self.ternary!, (value) {
      return _then(_self.copyWith(ternary: value));
    });
  }

  /// Create a copy of Armor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BonusSkillCopyWith<$Res>? get groupBonus {
    if (_self.groupBonus == null) {
      return null;
    }

    return $BonusSkillCopyWith<$Res>(_self.groupBonus!, (value) {
      return _then(_self.copyWith(groupBonus: value));
    });
  }

  /// Create a copy of Armor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BonusSkillCopyWith<$Res>? get setBonus {
    if (_self.setBonus == null) {
      return null;
    }

    return $BonusSkillCopyWith<$Res>(_self.setBonus!, (value) {
      return _then(_self.copyWith(setBonus: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _Armor extends Armor {
  const _Armor(
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
  factory _Armor.fromJson(Map<String, dynamic> json) => _$ArmorFromJson(json);

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

  /// Create a copy of Armor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ArmorCopyWith<_Armor> get copyWith =>
      __$ArmorCopyWithImpl<_Armor>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ArmorToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Armor &&
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
}

/// @nodoc
abstract mixin class _$ArmorCopyWith<$Res> implements $ArmorCopyWith<$Res> {
  factory _$ArmorCopyWith(_Armor value, $Res Function(_Armor) _then) =
      __$ArmorCopyWithImpl;
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
class __$ArmorCopyWithImpl<$Res> implements _$ArmorCopyWith<$Res> {
  __$ArmorCopyWithImpl(this._self, this._then);

  final _Armor _self;
  final $Res Function(_Armor) _then;

  /// Create a copy of Armor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_Armor(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      part: null == part
          ? _self.part
          : part // ignore: cast_nullable_to_non_nullable
              as Part,
      rarity: null == rarity
          ? _self.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      primary: null == primary
          ? _self.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as Skill,
      secondary: freezed == secondary
          ? _self.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as Skill?,
      ternary: freezed == ternary
          ? _self.ternary
          : ternary // ignore: cast_nullable_to_non_nullable
              as Skill?,
      groupBonus: freezed == groupBonus
          ? _self.groupBonus
          : groupBonus // ignore: cast_nullable_to_non_nullable
              as BonusSkill?,
      setBonus: freezed == setBonus
          ? _self.setBonus
          : setBonus // ignore: cast_nullable_to_non_nullable
              as BonusSkill?,
      primaryLv: null == primaryLv
          ? _self.primaryLv
          : primaryLv // ignore: cast_nullable_to_non_nullable
              as int,
      secondaryLv: null == secondaryLv
          ? _self.secondaryLv
          : secondaryLv // ignore: cast_nullable_to_non_nullable
              as int,
      ternaryLv: null == ternaryLv
          ? _self.ternaryLv
          : ternaryLv // ignore: cast_nullable_to_non_nullable
              as int,
      primarySlotSize: null == primarySlotSize
          ? _self.primarySlotSize
          : primarySlotSize // ignore: cast_nullable_to_non_nullable
              as int,
      secondarySlotSize: null == secondarySlotSize
          ? _self.secondarySlotSize
          : secondarySlotSize // ignore: cast_nullable_to_non_nullable
              as int,
      ternarySlotSize: null == ternarySlotSize
          ? _self.ternarySlotSize
          : ternarySlotSize // ignore: cast_nullable_to_non_nullable
              as int,
      minDef: null == minDef
          ? _self.minDef
          : minDef // ignore: cast_nullable_to_non_nullable
              as int,
      maxDef: null == maxDef
          ? _self.maxDef
          : maxDef // ignore: cast_nullable_to_non_nullable
              as int,
      defFire: null == defFire
          ? _self.defFire
          : defFire // ignore: cast_nullable_to_non_nullable
              as int,
      defWater: null == defWater
          ? _self.defWater
          : defWater // ignore: cast_nullable_to_non_nullable
              as int,
      defThunder: null == defThunder
          ? _self.defThunder
          : defThunder // ignore: cast_nullable_to_non_nullable
              as int,
      defIce: null == defIce
          ? _self.defIce
          : defIce // ignore: cast_nullable_to_non_nullable
              as int,
      defDragon: null == defDragon
          ? _self.defDragon
          : defDragon // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of Armor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res> get primary {
    return $SkillCopyWith<$Res>(_self.primary, (value) {
      return _then(_self.copyWith(primary: value));
    });
  }

  /// Create a copy of Armor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res>? get secondary {
    if (_self.secondary == null) {
      return null;
    }

    return $SkillCopyWith<$Res>(_self.secondary!, (value) {
      return _then(_self.copyWith(secondary: value));
    });
  }

  /// Create a copy of Armor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res>? get ternary {
    if (_self.ternary == null) {
      return null;
    }

    return $SkillCopyWith<$Res>(_self.ternary!, (value) {
      return _then(_self.copyWith(ternary: value));
    });
  }

  /// Create a copy of Armor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BonusSkillCopyWith<$Res>? get groupBonus {
    if (_self.groupBonus == null) {
      return null;
    }

    return $BonusSkillCopyWith<$Res>(_self.groupBonus!, (value) {
      return _then(_self.copyWith(groupBonus: value));
    });
  }

  /// Create a copy of Armor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BonusSkillCopyWith<$Res>? get setBonus {
    if (_self.setBonus == null) {
      return null;
    }

    return $BonusSkillCopyWith<$Res>(_self.setBonus!, (value) {
      return _then(_self.copyWith(setBonus: value));
    });
  }
}

/// @nodoc
mixin _$Deco {
  String get name;
  @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
  Skill get primary;
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  Skill? get secondary;
  int get primaryLvl;
  int get size;

  /// Create a copy of Deco
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DecoCopyWith<Deco> get copyWith =>
      _$DecoCopyWithImpl<Deco>(this as Deco, _$identity);

  /// Serializes this Deco to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Deco &&
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
}

/// @nodoc
abstract mixin class $DecoCopyWith<$Res> {
  factory $DecoCopyWith(Deco value, $Res Function(Deco) _then) =
      _$DecoCopyWithImpl;
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
class _$DecoCopyWithImpl<$Res> implements $DecoCopyWith<$Res> {
  _$DecoCopyWithImpl(this._self, this._then);

  final Deco _self;
  final $Res Function(Deco) _then;

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
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      primary: null == primary
          ? _self.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as Skill,
      secondary: freezed == secondary
          ? _self.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as Skill?,
      primaryLvl: null == primaryLvl
          ? _self.primaryLvl
          : primaryLvl // ignore: cast_nullable_to_non_nullable
              as int,
      size: null == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of Deco
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res> get primary {
    return $SkillCopyWith<$Res>(_self.primary, (value) {
      return _then(_self.copyWith(primary: value));
    });
  }

  /// Create a copy of Deco
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res>? get secondary {
    if (_self.secondary == null) {
      return null;
    }

    return $SkillCopyWith<$Res>(_self.secondary!, (value) {
      return _then(_self.copyWith(secondary: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _Deco extends Deco {
  const _Deco(
      {required this.name,
      @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
      required this.primary,
      @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
      this.secondary,
      required this.primaryLvl,
      required this.size})
      : super._();
  factory _Deco.fromJson(Map<String, dynamic> json) => _$DecoFromJson(json);

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

  /// Create a copy of Deco
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DecoCopyWith<_Deco> get copyWith =>
      __$DecoCopyWithImpl<_Deco>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DecoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Deco &&
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
}

/// @nodoc
abstract mixin class _$DecoCopyWith<$Res> implements $DecoCopyWith<$Res> {
  factory _$DecoCopyWith(_Deco value, $Res Function(_Deco) _then) =
      __$DecoCopyWithImpl;
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
class __$DecoCopyWithImpl<$Res> implements _$DecoCopyWith<$Res> {
  __$DecoCopyWithImpl(this._self, this._then);

  final _Deco _self;
  final $Res Function(_Deco) _then;

  /// Create a copy of Deco
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? primary = null,
    Object? secondary = freezed,
    Object? primaryLvl = null,
    Object? size = null,
  }) {
    return _then(_Deco(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      primary: null == primary
          ? _self.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as Skill,
      secondary: freezed == secondary
          ? _self.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as Skill?,
      primaryLvl: null == primaryLvl
          ? _self.primaryLvl
          : primaryLvl // ignore: cast_nullable_to_non_nullable
              as int,
      size: null == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of Deco
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res> get primary {
    return $SkillCopyWith<$Res>(_self.primary, (value) {
      return _then(_self.copyWith(primary: value));
    });
  }

  /// Create a copy of Deco
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res>? get secondary {
    if (_self.secondary == null) {
      return null;
    }

    return $SkillCopyWith<$Res>(_self.secondary!, (value) {
      return _then(_self.copyWith(secondary: value));
    });
  }
}

/// @nodoc
mixin _$Charm {
  String get name;
  int get rarity;
  @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
  Skill get primary;
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  Skill? get secondary;
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  Skill? get ternary;
  int get primaryLv;
  int get secondaryLv;
  int get ternaryLv;

  /// Create a copy of Charm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CharmCopyWith<Charm> get copyWith =>
      _$CharmCopyWithImpl<Charm>(this as Charm, _$identity);

  /// Serializes this Charm to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Charm &&
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
}

/// @nodoc
abstract mixin class $CharmCopyWith<$Res> {
  factory $CharmCopyWith(Charm value, $Res Function(Charm) _then) =
      _$CharmCopyWithImpl;
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
class _$CharmCopyWithImpl<$Res> implements $CharmCopyWith<$Res> {
  _$CharmCopyWithImpl(this._self, this._then);

  final Charm _self;
  final $Res Function(Charm) _then;

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
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rarity: null == rarity
          ? _self.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      primary: null == primary
          ? _self.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as Skill,
      secondary: freezed == secondary
          ? _self.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as Skill?,
      ternary: freezed == ternary
          ? _self.ternary
          : ternary // ignore: cast_nullable_to_non_nullable
              as Skill?,
      primaryLv: null == primaryLv
          ? _self.primaryLv
          : primaryLv // ignore: cast_nullable_to_non_nullable
              as int,
      secondaryLv: null == secondaryLv
          ? _self.secondaryLv
          : secondaryLv // ignore: cast_nullable_to_non_nullable
              as int,
      ternaryLv: null == ternaryLv
          ? _self.ternaryLv
          : ternaryLv // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of Charm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res> get primary {
    return $SkillCopyWith<$Res>(_self.primary, (value) {
      return _then(_self.copyWith(primary: value));
    });
  }

  /// Create a copy of Charm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res>? get secondary {
    if (_self.secondary == null) {
      return null;
    }

    return $SkillCopyWith<$Res>(_self.secondary!, (value) {
      return _then(_self.copyWith(secondary: value));
    });
  }

  /// Create a copy of Charm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res>? get ternary {
    if (_self.ternary == null) {
      return null;
    }

    return $SkillCopyWith<$Res>(_self.ternary!, (value) {
      return _then(_self.copyWith(ternary: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _Charm extends Charm {
  const _Charm(
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
  factory _Charm.fromJson(Map<String, dynamic> json) => _$CharmFromJson(json);

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

  /// Create a copy of Charm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CharmCopyWith<_Charm> get copyWith =>
      __$CharmCopyWithImpl<_Charm>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CharmToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Charm &&
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
}

/// @nodoc
abstract mixin class _$CharmCopyWith<$Res> implements $CharmCopyWith<$Res> {
  factory _$CharmCopyWith(_Charm value, $Res Function(_Charm) _then) =
      __$CharmCopyWithImpl;
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
class __$CharmCopyWithImpl<$Res> implements _$CharmCopyWith<$Res> {
  __$CharmCopyWithImpl(this._self, this._then);

  final _Charm _self;
  final $Res Function(_Charm) _then;

  /// Create a copy of Charm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_Charm(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rarity: null == rarity
          ? _self.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      primary: null == primary
          ? _self.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as Skill,
      secondary: freezed == secondary
          ? _self.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as Skill?,
      ternary: freezed == ternary
          ? _self.ternary
          : ternary // ignore: cast_nullable_to_non_nullable
              as Skill?,
      primaryLv: null == primaryLv
          ? _self.primaryLv
          : primaryLv // ignore: cast_nullable_to_non_nullable
              as int,
      secondaryLv: null == secondaryLv
          ? _self.secondaryLv
          : secondaryLv // ignore: cast_nullable_to_non_nullable
              as int,
      ternaryLv: null == ternaryLv
          ? _self.ternaryLv
          : ternaryLv // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of Charm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res> get primary {
    return $SkillCopyWith<$Res>(_self.primary, (value) {
      return _then(_self.copyWith(primary: value));
    });
  }

  /// Create a copy of Charm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res>? get secondary {
    if (_self.secondary == null) {
      return null;
    }

    return $SkillCopyWith<$Res>(_self.secondary!, (value) {
      return _then(_self.copyWith(secondary: value));
    });
  }

  /// Create a copy of Charm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res>? get ternary {
    if (_self.ternary == null) {
      return null;
    }

    return $SkillCopyWith<$Res>(_self.ternary!, (value) {
      return _then(_self.copyWith(ternary: value));
    });
  }
}

/// @nodoc
mixin _$Weapon {
  String get name;
  WeaponType get type;
  int get rarity;
  @JsonKey(fromJson: Skill.fromString, toJson: Skill.asString)
  Skill get primary;
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  Skill? get secondary;
  @JsonKey(fromJson: Skill.fromStringNullable, toJson: Skill.asString)
  Skill? get ternary;
  int get primaryLv;
  int get secondaryLv;
  int get ternaryLv;
  int get primarySlotSize;
  int get secondarySlotSize;
  int get ternarySlotSize;

  /// Create a copy of Weapon
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WeaponCopyWith<Weapon> get copyWith =>
      _$WeaponCopyWithImpl<Weapon>(this as Weapon, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Weapon &&
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
                other.ternaryLv == ternaryLv) &&
            (identical(other.primarySlotSize, primarySlotSize) ||
                other.primarySlotSize == primarySlotSize) &&
            (identical(other.secondarySlotSize, secondarySlotSize) ||
                other.secondarySlotSize == secondarySlotSize) &&
            (identical(other.ternarySlotSize, ternarySlotSize) ||
                other.ternarySlotSize == ternarySlotSize));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      type,
      rarity,
      primary,
      secondary,
      ternary,
      primaryLv,
      secondaryLv,
      ternaryLv,
      primarySlotSize,
      secondarySlotSize,
      ternarySlotSize);
}

/// @nodoc
abstract mixin class $WeaponCopyWith<$Res> {
  factory $WeaponCopyWith(Weapon value, $Res Function(Weapon) _then) =
      _$WeaponCopyWithImpl;
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
      int ternaryLv,
      int primarySlotSize,
      int secondarySlotSize,
      int ternarySlotSize});

  $SkillCopyWith<$Res> get primary;
  $SkillCopyWith<$Res>? get secondary;
  $SkillCopyWith<$Res>? get ternary;
}

/// @nodoc
class _$WeaponCopyWithImpl<$Res> implements $WeaponCopyWith<$Res> {
  _$WeaponCopyWithImpl(this._self, this._then);

  final Weapon _self;
  final $Res Function(Weapon) _then;

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
    Object? primarySlotSize = null,
    Object? secondarySlotSize = null,
    Object? ternarySlotSize = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as WeaponType,
      rarity: null == rarity
          ? _self.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      primary: null == primary
          ? _self.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as Skill,
      secondary: freezed == secondary
          ? _self.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as Skill?,
      ternary: freezed == ternary
          ? _self.ternary
          : ternary // ignore: cast_nullable_to_non_nullable
              as Skill?,
      primaryLv: null == primaryLv
          ? _self.primaryLv
          : primaryLv // ignore: cast_nullable_to_non_nullable
              as int,
      secondaryLv: null == secondaryLv
          ? _self.secondaryLv
          : secondaryLv // ignore: cast_nullable_to_non_nullable
              as int,
      ternaryLv: null == ternaryLv
          ? _self.ternaryLv
          : ternaryLv // ignore: cast_nullable_to_non_nullable
              as int,
      primarySlotSize: null == primarySlotSize
          ? _self.primarySlotSize
          : primarySlotSize // ignore: cast_nullable_to_non_nullable
              as int,
      secondarySlotSize: null == secondarySlotSize
          ? _self.secondarySlotSize
          : secondarySlotSize // ignore: cast_nullable_to_non_nullable
              as int,
      ternarySlotSize: null == ternarySlotSize
          ? _self.ternarySlotSize
          : ternarySlotSize // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of Weapon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res> get primary {
    return $SkillCopyWith<$Res>(_self.primary, (value) {
      return _then(_self.copyWith(primary: value));
    });
  }

  /// Create a copy of Weapon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res>? get secondary {
    if (_self.secondary == null) {
      return null;
    }

    return $SkillCopyWith<$Res>(_self.secondary!, (value) {
      return _then(_self.copyWith(secondary: value));
    });
  }

  /// Create a copy of Weapon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res>? get ternary {
    if (_self.ternary == null) {
      return null;
    }

    return $SkillCopyWith<$Res>(_self.ternary!, (value) {
      return _then(_self.copyWith(ternary: value));
    });
  }
}

/// @nodoc

class _Weapon extends Weapon {
  const _Weapon(
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
      this.ternaryLv = 0,
      required this.primarySlotSize,
      required this.secondarySlotSize,
      required this.ternarySlotSize})
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
  final int primarySlotSize;
  @override
  final int secondarySlotSize;
  @override
  final int ternarySlotSize;

  /// Create a copy of Weapon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WeaponCopyWith<_Weapon> get copyWith =>
      __$WeaponCopyWithImpl<_Weapon>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Weapon &&
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
                other.ternaryLv == ternaryLv) &&
            (identical(other.primarySlotSize, primarySlotSize) ||
                other.primarySlotSize == primarySlotSize) &&
            (identical(other.secondarySlotSize, secondarySlotSize) ||
                other.secondarySlotSize == secondarySlotSize) &&
            (identical(other.ternarySlotSize, ternarySlotSize) ||
                other.ternarySlotSize == ternarySlotSize));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      type,
      rarity,
      primary,
      secondary,
      ternary,
      primaryLv,
      secondaryLv,
      ternaryLv,
      primarySlotSize,
      secondarySlotSize,
      ternarySlotSize);
}

/// @nodoc
abstract mixin class _$WeaponCopyWith<$Res> implements $WeaponCopyWith<$Res> {
  factory _$WeaponCopyWith(_Weapon value, $Res Function(_Weapon) _then) =
      __$WeaponCopyWithImpl;
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
      int ternaryLv,
      int primarySlotSize,
      int secondarySlotSize,
      int ternarySlotSize});

  @override
  $SkillCopyWith<$Res> get primary;
  @override
  $SkillCopyWith<$Res>? get secondary;
  @override
  $SkillCopyWith<$Res>? get ternary;
}

/// @nodoc
class __$WeaponCopyWithImpl<$Res> implements _$WeaponCopyWith<$Res> {
  __$WeaponCopyWithImpl(this._self, this._then);

  final _Weapon _self;
  final $Res Function(_Weapon) _then;

  /// Create a copy of Weapon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    Object? primarySlotSize = null,
    Object? secondarySlotSize = null,
    Object? ternarySlotSize = null,
  }) {
    return _then(_Weapon(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as WeaponType,
      rarity: null == rarity
          ? _self.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      primary: null == primary
          ? _self.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as Skill,
      secondary: freezed == secondary
          ? _self.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as Skill?,
      ternary: freezed == ternary
          ? _self.ternary
          : ternary // ignore: cast_nullable_to_non_nullable
              as Skill?,
      primaryLv: null == primaryLv
          ? _self.primaryLv
          : primaryLv // ignore: cast_nullable_to_non_nullable
              as int,
      secondaryLv: null == secondaryLv
          ? _self.secondaryLv
          : secondaryLv // ignore: cast_nullable_to_non_nullable
              as int,
      ternaryLv: null == ternaryLv
          ? _self.ternaryLv
          : ternaryLv // ignore: cast_nullable_to_non_nullable
              as int,
      primarySlotSize: null == primarySlotSize
          ? _self.primarySlotSize
          : primarySlotSize // ignore: cast_nullable_to_non_nullable
              as int,
      secondarySlotSize: null == secondarySlotSize
          ? _self.secondarySlotSize
          : secondarySlotSize // ignore: cast_nullable_to_non_nullable
              as int,
      ternarySlotSize: null == ternarySlotSize
          ? _self.ternarySlotSize
          : ternarySlotSize // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of Weapon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res> get primary {
    return $SkillCopyWith<$Res>(_self.primary, (value) {
      return _then(_self.copyWith(primary: value));
    });
  }

  /// Create a copy of Weapon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res>? get secondary {
    if (_self.secondary == null) {
      return null;
    }

    return $SkillCopyWith<$Res>(_self.secondary!, (value) {
      return _then(_self.copyWith(secondary: value));
    });
  }

  /// Create a copy of Weapon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res>? get ternary {
    if (_self.ternary == null) {
      return null;
    }

    return $SkillCopyWith<$Res>(_self.ternary!, (value) {
      return _then(_self.copyWith(ternary: value));
    });
  }
}

/// @nodoc
mixin _$EquipmentPiece {
  @JsonKey(fromJson: Equipment.fromString, toJson: Equipment.asString)
  Equipment get equipment;
  @JsonKey(fromJson: _jsonToDecoList, toJson: _decoListToJson)
  List<Deco?> get decorations;

  /// Create a copy of EquipmentPiece
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EquipmentPieceCopyWith<EquipmentPiece> get copyWith =>
      _$EquipmentPieceCopyWithImpl<EquipmentPiece>(
          this as EquipmentPiece, _$identity);

  /// Serializes this EquipmentPiece to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EquipmentPiece &&
            (identical(other.equipment, equipment) ||
                other.equipment == equipment) &&
            const DeepCollectionEquality()
                .equals(other.decorations, decorations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, equipment, const DeepCollectionEquality().hash(decorations));

  @override
  String toString() {
    return 'EquipmentPiece(equipment: $equipment, decorations: $decorations)';
  }
}

/// @nodoc
abstract mixin class $EquipmentPieceCopyWith<$Res> {
  factory $EquipmentPieceCopyWith(
          EquipmentPiece value, $Res Function(EquipmentPiece) _then) =
      _$EquipmentPieceCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(fromJson: Equipment.fromString, toJson: Equipment.asString)
      Equipment equipment,
      @JsonKey(fromJson: _jsonToDecoList, toJson: _decoListToJson)
      List<Deco?> decorations});
}

/// @nodoc
class _$EquipmentPieceCopyWithImpl<$Res>
    implements $EquipmentPieceCopyWith<$Res> {
  _$EquipmentPieceCopyWithImpl(this._self, this._then);

  final EquipmentPiece _self;
  final $Res Function(EquipmentPiece) _then;

  /// Create a copy of EquipmentPiece
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? equipment = null,
    Object? decorations = null,
  }) {
    return _then(_self.copyWith(
      equipment: null == equipment
          ? _self.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as Equipment,
      decorations: null == decorations
          ? _self.decorations
          : decorations // ignore: cast_nullable_to_non_nullable
              as List<Deco?>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _EquipmentPiece extends EquipmentPiece {
  const _EquipmentPiece(
      {@JsonKey(fromJson: Equipment.fromString, toJson: Equipment.asString)
      required this.equipment,
      @JsonKey(fromJson: _jsonToDecoList, toJson: _decoListToJson)
      required final List<Deco?> decorations})
      : _decorations = decorations,
        super._();
  factory _EquipmentPiece.fromJson(Map<String, dynamic> json) =>
      _$EquipmentPieceFromJson(json);

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

  /// Create a copy of EquipmentPiece
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EquipmentPieceCopyWith<_EquipmentPiece> get copyWith =>
      __$EquipmentPieceCopyWithImpl<_EquipmentPiece>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EquipmentPieceToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EquipmentPiece &&
            (identical(other.equipment, equipment) ||
                other.equipment == equipment) &&
            const DeepCollectionEquality()
                .equals(other._decorations, _decorations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, equipment,
      const DeepCollectionEquality().hash(_decorations));

  @override
  String toString() {
    return 'EquipmentPiece(equipment: $equipment, decorations: $decorations)';
  }
}

/// @nodoc
abstract mixin class _$EquipmentPieceCopyWith<$Res>
    implements $EquipmentPieceCopyWith<$Res> {
  factory _$EquipmentPieceCopyWith(
          _EquipmentPiece value, $Res Function(_EquipmentPiece) _then) =
      __$EquipmentPieceCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: Equipment.fromString, toJson: Equipment.asString)
      Equipment equipment,
      @JsonKey(fromJson: _jsonToDecoList, toJson: _decoListToJson)
      List<Deco?> decorations});
}

/// @nodoc
class __$EquipmentPieceCopyWithImpl<$Res>
    implements _$EquipmentPieceCopyWith<$Res> {
  __$EquipmentPieceCopyWithImpl(this._self, this._then);

  final _EquipmentPiece _self;
  final $Res Function(_EquipmentPiece) _then;

  /// Create a copy of EquipmentPiece
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? equipment = null,
    Object? decorations = null,
  }) {
    return _then(_EquipmentPiece(
      equipment: null == equipment
          ? _self.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as Equipment,
      decorations: null == decorations
          ? _self._decorations
          : decorations // ignore: cast_nullable_to_non_nullable
              as List<Deco?>,
    ));
  }
}

/// @nodoc
mixin _$ArmorSet {
  @JsonKey(fromJson: _jsonToDecoList, toJson: _decoListToJson)
  List<Deco?> get weaponDecos;
  @JsonKey(fromJson: _jsonToEquipmentList, toJson: _equipmentListToJson)
  List<EquipmentPiece> get pieces;
  @JsonKey(fromJson: Charm.fromString, toJson: Equipment.asString)
  Charm get charm;

  /// Create a copy of ArmorSet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ArmorSetCopyWith<ArmorSet> get copyWith =>
      _$ArmorSetCopyWithImpl<ArmorSet>(this as ArmorSet, _$identity);

  /// Serializes this ArmorSet to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ArmorSet &&
            const DeepCollectionEquality()
                .equals(other.weaponDecos, weaponDecos) &&
            const DeepCollectionEquality().equals(other.pieces, pieces) &&
            (identical(other.charm, charm) || other.charm == charm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(weaponDecos),
      const DeepCollectionEquality().hash(pieces),
      charm);

  @override
  String toString() {
    return 'ArmorSet(weaponDecos: $weaponDecos, pieces: $pieces, charm: $charm)';
  }
}

/// @nodoc
abstract mixin class $ArmorSetCopyWith<$Res> {
  factory $ArmorSetCopyWith(ArmorSet value, $Res Function(ArmorSet) _then) =
      _$ArmorSetCopyWithImpl;
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
class _$ArmorSetCopyWithImpl<$Res> implements $ArmorSetCopyWith<$Res> {
  _$ArmorSetCopyWithImpl(this._self, this._then);

  final ArmorSet _self;
  final $Res Function(ArmorSet) _then;

  /// Create a copy of ArmorSet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weaponDecos = null,
    Object? pieces = null,
    Object? charm = null,
  }) {
    return _then(_self.copyWith(
      weaponDecos: null == weaponDecos
          ? _self.weaponDecos
          : weaponDecos // ignore: cast_nullable_to_non_nullable
              as List<Deco?>,
      pieces: null == pieces
          ? _self.pieces
          : pieces // ignore: cast_nullable_to_non_nullable
              as List<EquipmentPiece>,
      charm: null == charm
          ? _self.charm
          : charm // ignore: cast_nullable_to_non_nullable
              as Charm,
    ));
  }

  /// Create a copy of ArmorSet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CharmCopyWith<$Res> get charm {
    return $CharmCopyWith<$Res>(_self.charm, (value) {
      return _then(_self.copyWith(charm: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _ArmorSet extends ArmorSet {
  const _ArmorSet(
      {@JsonKey(fromJson: _jsonToDecoList, toJson: _decoListToJson)
      required final List<Deco?> weaponDecos,
      @JsonKey(fromJson: _jsonToEquipmentList, toJson: _equipmentListToJson)
      required final List<EquipmentPiece> pieces,
      @JsonKey(fromJson: Charm.fromString, toJson: Equipment.asString)
      required this.charm})
      : _weaponDecos = weaponDecos,
        _pieces = pieces,
        super._();
  factory _ArmorSet.fromJson(Map<String, dynamic> json) =>
      _$ArmorSetFromJson(json);

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

  /// Create a copy of ArmorSet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ArmorSetCopyWith<_ArmorSet> get copyWith =>
      __$ArmorSetCopyWithImpl<_ArmorSet>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ArmorSetToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ArmorSet &&
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

  @override
  String toString() {
    return 'ArmorSet(weaponDecos: $weaponDecos, pieces: $pieces, charm: $charm)';
  }
}

/// @nodoc
abstract mixin class _$ArmorSetCopyWith<$Res>
    implements $ArmorSetCopyWith<$Res> {
  factory _$ArmorSetCopyWith(_ArmorSet value, $Res Function(_ArmorSet) _then) =
      __$ArmorSetCopyWithImpl;
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
class __$ArmorSetCopyWithImpl<$Res> implements _$ArmorSetCopyWith<$Res> {
  __$ArmorSetCopyWithImpl(this._self, this._then);

  final _ArmorSet _self;
  final $Res Function(_ArmorSet) _then;

  /// Create a copy of ArmorSet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? weaponDecos = null,
    Object? pieces = null,
    Object? charm = null,
  }) {
    return _then(_ArmorSet(
      weaponDecos: null == weaponDecos
          ? _self._weaponDecos
          : weaponDecos // ignore: cast_nullable_to_non_nullable
              as List<Deco?>,
      pieces: null == pieces
          ? _self._pieces
          : pieces // ignore: cast_nullable_to_non_nullable
              as List<EquipmentPiece>,
      charm: null == charm
          ? _self.charm
          : charm // ignore: cast_nullable_to_non_nullable
              as Charm,
    ));
  }

  /// Create a copy of ArmorSet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CharmCopyWith<$Res> get charm {
    return $CharmCopyWith<$Res>(_self.charm, (value) {
      return _then(_self.copyWith(charm: value));
    });
  }
}

// dart format on
