// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cubits.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
SearcherArgsState _$SearcherArgsStateFromJson(Map<String, dynamic> json) {
  return _SearcherState.fromJson(json);
}

/// @nodoc
mixin _$SearcherArgsState {
  @JsonKey(fromJson: _jsonToSkills, toJson: _skillsToJson)
  List<Leveled<SkillTemplate>> get skills;
  @JsonKey(fromJson: _jsonToArmor, toJson: _armorToJson)
  Set<Armor> get blacklistedArmors;
  @JsonKey(fromJson: _jsonToDecos, toJson: _decosToJson)
  Map<Deco, int> get decos;
  bool get useAllDecos;
  @JsonKey(fromJson: _jsonToCharms, toJson: _charmsToJson)
  Map<CharmFamily, int> get charms;
  bool get useAllCharms;
  int get minRarity;
  int get maxRarity;
  bool get includeEmptyArmor;

  /// Create a copy of SearcherArgsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SearcherArgsStateCopyWith<SearcherArgsState> get copyWith =>
      _$SearcherArgsStateCopyWithImpl<SearcherArgsState>(
          this as SearcherArgsState, _$identity);

  /// Serializes this SearcherArgsState to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SearcherArgsState &&
            const DeepCollectionEquality().equals(other.skills, skills) &&
            const DeepCollectionEquality()
                .equals(other.blacklistedArmors, blacklistedArmors) &&
            const DeepCollectionEquality().equals(other.decos, decos) &&
            (identical(other.useAllDecos, useAllDecos) ||
                other.useAllDecos == useAllDecos) &&
            const DeepCollectionEquality().equals(other.charms, charms) &&
            (identical(other.useAllCharms, useAllCharms) ||
                other.useAllCharms == useAllCharms) &&
            (identical(other.minRarity, minRarity) ||
                other.minRarity == minRarity) &&
            (identical(other.maxRarity, maxRarity) ||
                other.maxRarity == maxRarity) &&
            (identical(other.includeEmptyArmor, includeEmptyArmor) ||
                other.includeEmptyArmor == includeEmptyArmor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(skills),
      const DeepCollectionEquality().hash(blacklistedArmors),
      const DeepCollectionEquality().hash(decos),
      useAllDecos,
      const DeepCollectionEquality().hash(charms),
      useAllCharms,
      minRarity,
      maxRarity,
      includeEmptyArmor);

  @override
  String toString() {
    return 'SearcherArgsState(skills: $skills, blacklistedArmors: $blacklistedArmors, decos: $decos, useAllDecos: $useAllDecos, charms: $charms, useAllCharms: $useAllCharms, minRarity: $minRarity, maxRarity: $maxRarity, includeEmptyArmor: $includeEmptyArmor)';
  }
}

/// @nodoc
abstract mixin class $SearcherArgsStateCopyWith<$Res> {
  factory $SearcherArgsStateCopyWith(
          SearcherArgsState value, $Res Function(SearcherArgsState) _then) =
      _$SearcherArgsStateCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(fromJson: _jsonToSkills, toJson: _skillsToJson)
      List<Leveled<SkillTemplate>> skills,
      @JsonKey(fromJson: _jsonToArmor, toJson: _armorToJson)
      Set<Armor> blacklistedArmors,
      @JsonKey(fromJson: _jsonToDecos, toJson: _decosToJson)
      Map<Deco, int> decos,
      bool useAllDecos,
      @JsonKey(fromJson: _jsonToCharms, toJson: _charmsToJson)
      Map<CharmFamily, int> charms,
      bool useAllCharms,
      int minRarity,
      int maxRarity,
      bool includeEmptyArmor});
}

/// @nodoc
class _$SearcherArgsStateCopyWithImpl<$Res>
    implements $SearcherArgsStateCopyWith<$Res> {
  _$SearcherArgsStateCopyWithImpl(this._self, this._then);

  final SearcherArgsState _self;
  final $Res Function(SearcherArgsState) _then;

  /// Create a copy of SearcherArgsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skills = null,
    Object? blacklistedArmors = null,
    Object? decos = null,
    Object? useAllDecos = null,
    Object? charms = null,
    Object? useAllCharms = null,
    Object? minRarity = null,
    Object? maxRarity = null,
    Object? includeEmptyArmor = null,
  }) {
    return _then(_self.copyWith(
      skills: null == skills
          ? _self.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<Leveled<SkillTemplate>>,
      blacklistedArmors: null == blacklistedArmors
          ? _self.blacklistedArmors
          : blacklistedArmors // ignore: cast_nullable_to_non_nullable
              as Set<Armor>,
      decos: null == decos
          ? _self.decos
          : decos // ignore: cast_nullable_to_non_nullable
              as Map<Deco, int>,
      useAllDecos: null == useAllDecos
          ? _self.useAllDecos
          : useAllDecos // ignore: cast_nullable_to_non_nullable
              as bool,
      charms: null == charms
          ? _self.charms
          : charms // ignore: cast_nullable_to_non_nullable
              as Map<CharmFamily, int>,
      useAllCharms: null == useAllCharms
          ? _self.useAllCharms
          : useAllCharms // ignore: cast_nullable_to_non_nullable
              as bool,
      minRarity: null == minRarity
          ? _self.minRarity
          : minRarity // ignore: cast_nullable_to_non_nullable
              as int,
      maxRarity: null == maxRarity
          ? _self.maxRarity
          : maxRarity // ignore: cast_nullable_to_non_nullable
              as int,
      includeEmptyArmor: null == includeEmptyArmor
          ? _self.includeEmptyArmor
          : includeEmptyArmor // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SearcherState extends SearcherArgsState {
  const _SearcherState(
      {@JsonKey(fromJson: _jsonToSkills, toJson: _skillsToJson)
      required final List<Leveled<SkillTemplate>> skills,
      @JsonKey(fromJson: _jsonToArmor, toJson: _armorToJson)
      required final Set<Armor> blacklistedArmors,
      @JsonKey(fromJson: _jsonToDecos, toJson: _decosToJson)
      required final Map<Deco, int> decos,
      required this.useAllDecos,
      @JsonKey(fromJson: _jsonToCharms, toJson: _charmsToJson)
      required final Map<CharmFamily, int> charms,
      required this.useAllCharms,
      required this.minRarity,
      required this.maxRarity,
      this.includeEmptyArmor = true})
      : _skills = skills,
        _blacklistedArmors = blacklistedArmors,
        _decos = decos,
        _charms = charms,
        super._();
  factory _SearcherState.fromJson(Map<String, dynamic> json) =>
      _$SearcherStateFromJson(json);

  final List<Leveled<SkillTemplate>> _skills;
  @override
  @JsonKey(fromJson: _jsonToSkills, toJson: _skillsToJson)
  List<Leveled<SkillTemplate>> get skills {
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skills);
  }

  final Set<Armor> _blacklistedArmors;
  @override
  @JsonKey(fromJson: _jsonToArmor, toJson: _armorToJson)
  Set<Armor> get blacklistedArmors {
    if (_blacklistedArmors is EqualUnmodifiableSetView)
      return _blacklistedArmors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_blacklistedArmors);
  }

  final Map<Deco, int> _decos;
  @override
  @JsonKey(fromJson: _jsonToDecos, toJson: _decosToJson)
  Map<Deco, int> get decos {
    if (_decos is EqualUnmodifiableMapView) return _decos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_decos);
  }

  @override
  final bool useAllDecos;
  final Map<CharmFamily, int> _charms;
  @override
  @JsonKey(fromJson: _jsonToCharms, toJson: _charmsToJson)
  Map<CharmFamily, int> get charms {
    if (_charms is EqualUnmodifiableMapView) return _charms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_charms);
  }

  @override
  final bool useAllCharms;
  @override
  final int minRarity;
  @override
  final int maxRarity;
  @override
  @JsonKey()
  final bool includeEmptyArmor;

  /// Create a copy of SearcherArgsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SearcherStateCopyWith<_SearcherState> get copyWith =>
      __$SearcherStateCopyWithImpl<_SearcherState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SearcherStateToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SearcherState &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            const DeepCollectionEquality()
                .equals(other._blacklistedArmors, _blacklistedArmors) &&
            const DeepCollectionEquality().equals(other._decos, _decos) &&
            (identical(other.useAllDecos, useAllDecos) ||
                other.useAllDecos == useAllDecos) &&
            const DeepCollectionEquality().equals(other._charms, _charms) &&
            (identical(other.useAllCharms, useAllCharms) ||
                other.useAllCharms == useAllCharms) &&
            (identical(other.minRarity, minRarity) ||
                other.minRarity == minRarity) &&
            (identical(other.maxRarity, maxRarity) ||
                other.maxRarity == maxRarity) &&
            (identical(other.includeEmptyArmor, includeEmptyArmor) ||
                other.includeEmptyArmor == includeEmptyArmor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_skills),
      const DeepCollectionEquality().hash(_blacklistedArmors),
      const DeepCollectionEquality().hash(_decos),
      useAllDecos,
      const DeepCollectionEquality().hash(_charms),
      useAllCharms,
      minRarity,
      maxRarity,
      includeEmptyArmor);

  @override
  String toString() {
    return 'SearcherArgsState(skills: $skills, blacklistedArmors: $blacklistedArmors, decos: $decos, useAllDecos: $useAllDecos, charms: $charms, useAllCharms: $useAllCharms, minRarity: $minRarity, maxRarity: $maxRarity, includeEmptyArmor: $includeEmptyArmor)';
  }
}

/// @nodoc
abstract mixin class _$SearcherStateCopyWith<$Res>
    implements $SearcherArgsStateCopyWith<$Res> {
  factory _$SearcherStateCopyWith(
          _SearcherState value, $Res Function(_SearcherState) _then) =
      __$SearcherStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: _jsonToSkills, toJson: _skillsToJson)
      List<Leveled<SkillTemplate>> skills,
      @JsonKey(fromJson: _jsonToArmor, toJson: _armorToJson)
      Set<Armor> blacklistedArmors,
      @JsonKey(fromJson: _jsonToDecos, toJson: _decosToJson)
      Map<Deco, int> decos,
      bool useAllDecos,
      @JsonKey(fromJson: _jsonToCharms, toJson: _charmsToJson)
      Map<CharmFamily, int> charms,
      bool useAllCharms,
      int minRarity,
      int maxRarity,
      bool includeEmptyArmor});
}

/// @nodoc
class __$SearcherStateCopyWithImpl<$Res>
    implements _$SearcherStateCopyWith<$Res> {
  __$SearcherStateCopyWithImpl(this._self, this._then);

  final _SearcherState _self;
  final $Res Function(_SearcherState) _then;

  /// Create a copy of SearcherArgsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? skills = null,
    Object? blacklistedArmors = null,
    Object? decos = null,
    Object? useAllDecos = null,
    Object? charms = null,
    Object? useAllCharms = null,
    Object? minRarity = null,
    Object? maxRarity = null,
    Object? includeEmptyArmor = null,
  }) {
    return _then(_SearcherState(
      skills: null == skills
          ? _self._skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<Leveled<SkillTemplate>>,
      blacklistedArmors: null == blacklistedArmors
          ? _self._blacklistedArmors
          : blacklistedArmors // ignore: cast_nullable_to_non_nullable
              as Set<Armor>,
      decos: null == decos
          ? _self._decos
          : decos // ignore: cast_nullable_to_non_nullable
              as Map<Deco, int>,
      useAllDecos: null == useAllDecos
          ? _self.useAllDecos
          : useAllDecos // ignore: cast_nullable_to_non_nullable
              as bool,
      charms: null == charms
          ? _self._charms
          : charms // ignore: cast_nullable_to_non_nullable
              as Map<CharmFamily, int>,
      useAllCharms: null == useAllCharms
          ? _self.useAllCharms
          : useAllCharms // ignore: cast_nullable_to_non_nullable
              as bool,
      minRarity: null == minRarity
          ? _self.minRarity
          : minRarity // ignore: cast_nullable_to_non_nullable
              as int,
      maxRarity: null == maxRarity
          ? _self.maxRarity
          : maxRarity // ignore: cast_nullable_to_non_nullable
              as int,
      includeEmptyArmor: null == includeEmptyArmor
          ? _self.includeEmptyArmor
          : includeEmptyArmor // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
