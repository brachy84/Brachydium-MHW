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

/// @nodoc
mixin _$SearcherArgsState {
  List<Leveled<SkillTemplate>> get skills;
  List<Leveled<ArmorFilter>> get armorFilters;
  Map<Deco, int>? get decos;
  Map<CharmFamily, int>? get charms;

  /// Create a copy of SearcherArgsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SearcherArgsStateCopyWith<SearcherArgsState> get copyWith =>
      _$SearcherArgsStateCopyWithImpl<SearcherArgsState>(
          this as SearcherArgsState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SearcherArgsState &&
            const DeepCollectionEquality().equals(other.skills, skills) &&
            const DeepCollectionEquality()
                .equals(other.armorFilters, armorFilters) &&
            const DeepCollectionEquality().equals(other.decos, decos) &&
            const DeepCollectionEquality().equals(other.charms, charms));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(skills),
      const DeepCollectionEquality().hash(armorFilters),
      const DeepCollectionEquality().hash(decos),
      const DeepCollectionEquality().hash(charms));

  @override
  String toString() {
    return 'SearcherArgsState(skills: $skills, armorFilters: $armorFilters, decos: $decos, charms: $charms)';
  }
}

/// @nodoc
abstract mixin class $SearcherArgsStateCopyWith<$Res> {
  factory $SearcherArgsStateCopyWith(
          SearcherArgsState value, $Res Function(SearcherArgsState) _then) =
      _$SearcherArgsStateCopyWithImpl;
  @useResult
  $Res call(
      {List<Leveled<SkillTemplate>> skills,
      List<Leveled<ArmorFilter>> armorFilters,
      Map<Deco, int>? decos,
      Map<CharmFamily, int>? charms});
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
    Object? armorFilters = null,
    Object? decos = freezed,
    Object? charms = freezed,
  }) {
    return _then(_self.copyWith(
      skills: null == skills
          ? _self.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<Leveled<SkillTemplate>>,
      armorFilters: null == armorFilters
          ? _self.armorFilters
          : armorFilters // ignore: cast_nullable_to_non_nullable
              as List<Leveled<ArmorFilter>>,
      decos: freezed == decos
          ? _self.decos
          : decos // ignore: cast_nullable_to_non_nullable
              as Map<Deco, int>?,
      charms: freezed == charms
          ? _self.charms
          : charms // ignore: cast_nullable_to_non_nullable
              as Map<CharmFamily, int>?,
    ));
  }
}

/// @nodoc

class _SearcherState extends SearcherArgsState {
  const _SearcherState(
      {required final List<Leveled<SkillTemplate>> skills,
      required final List<Leveled<ArmorFilter>> armorFilters,
      required final Map<Deco, int>? decos,
      required final Map<CharmFamily, int>? charms})
      : _skills = skills,
        _armorFilters = armorFilters,
        _decos = decos,
        _charms = charms,
        super._();

  final List<Leveled<SkillTemplate>> _skills;
  @override
  List<Leveled<SkillTemplate>> get skills {
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skills);
  }

  final List<Leveled<ArmorFilter>> _armorFilters;
  @override
  List<Leveled<ArmorFilter>> get armorFilters {
    if (_armorFilters is EqualUnmodifiableListView) return _armorFilters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_armorFilters);
  }

  final Map<Deco, int>? _decos;
  @override
  Map<Deco, int>? get decos {
    final value = _decos;
    if (value == null) return null;
    if (_decos is EqualUnmodifiableMapView) return _decos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<CharmFamily, int>? _charms;
  @override
  Map<CharmFamily, int>? get charms {
    final value = _charms;
    if (value == null) return null;
    if (_charms is EqualUnmodifiableMapView) return _charms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Create a copy of SearcherArgsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SearcherStateCopyWith<_SearcherState> get copyWith =>
      __$SearcherStateCopyWithImpl<_SearcherState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SearcherState &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            const DeepCollectionEquality()
                .equals(other._armorFilters, _armorFilters) &&
            const DeepCollectionEquality().equals(other._decos, _decos) &&
            const DeepCollectionEquality().equals(other._charms, _charms));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_skills),
      const DeepCollectionEquality().hash(_armorFilters),
      const DeepCollectionEquality().hash(_decos),
      const DeepCollectionEquality().hash(_charms));

  @override
  String toString() {
    return 'SearcherArgsState(skills: $skills, armorFilters: $armorFilters, decos: $decos, charms: $charms)';
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
      {List<Leveled<SkillTemplate>> skills,
      List<Leveled<ArmorFilter>> armorFilters,
      Map<Deco, int>? decos,
      Map<CharmFamily, int>? charms});
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
    Object? armorFilters = null,
    Object? decos = freezed,
    Object? charms = freezed,
  }) {
    return _then(_SearcherState(
      skills: null == skills
          ? _self._skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<Leveled<SkillTemplate>>,
      armorFilters: null == armorFilters
          ? _self._armorFilters
          : armorFilters // ignore: cast_nullable_to_non_nullable
              as List<Leveled<ArmorFilter>>,
      decos: freezed == decos
          ? _self._decos
          : decos // ignore: cast_nullable_to_non_nullable
              as Map<Deco, int>?,
      charms: freezed == charms
          ? _self._charms
          : charms // ignore: cast_nullable_to_non_nullable
              as Map<CharmFamily, int>?,
    ));
  }
}

// dart format on
