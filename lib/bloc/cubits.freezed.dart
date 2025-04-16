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
mixin _$SearcherState {
  List<Stack<SkillTemplate>> get skills;
  List<Stack<ArmorFilter>> get armorFilters;
  bool get useMyDeco;

  /// Create a copy of SearcherState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SearcherStateCopyWith<SearcherState> get copyWith =>
      _$SearcherStateCopyWithImpl<SearcherState>(
          this as SearcherState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SearcherState &&
            const DeepCollectionEquality().equals(other.skills, skills) &&
            const DeepCollectionEquality()
                .equals(other.armorFilters, armorFilters) &&
            (identical(other.useMyDeco, useMyDeco) ||
                other.useMyDeco == useMyDeco));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(skills),
      const DeepCollectionEquality().hash(armorFilters),
      useMyDeco);

  @override
  String toString() {
    return 'SearcherState(skills: $skills, armorFilters: $armorFilters, useMyDeco: $useMyDeco)';
  }
}

/// @nodoc
abstract mixin class $SearcherStateCopyWith<$Res> {
  factory $SearcherStateCopyWith(
          SearcherState value, $Res Function(SearcherState) _then) =
      _$SearcherStateCopyWithImpl;
  @useResult
  $Res call(
      {List<Stack<SkillTemplate>> skills,
      List<Stack<ArmorFilter>> armorFilters,
      bool useMyDeco});
}

/// @nodoc
class _$SearcherStateCopyWithImpl<$Res>
    implements $SearcherStateCopyWith<$Res> {
  _$SearcherStateCopyWithImpl(this._self, this._then);

  final SearcherState _self;
  final $Res Function(SearcherState) _then;

  /// Create a copy of SearcherState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skills = null,
    Object? armorFilters = null,
    Object? useMyDeco = null,
  }) {
    return _then(_self.copyWith(
      skills: null == skills
          ? _self.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<Stack<SkillTemplate>>,
      armorFilters: null == armorFilters
          ? _self.armorFilters
          : armorFilters // ignore: cast_nullable_to_non_nullable
              as List<Stack<ArmorFilter>>,
      useMyDeco: null == useMyDeco
          ? _self.useMyDeco
          : useMyDeco // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _SearcherState extends SearcherState {
  const _SearcherState(
      {required final List<Stack<SkillTemplate>> skills,
      required final List<Stack<ArmorFilter>> armorFilters,
      required this.useMyDeco})
      : _skills = skills,
        _armorFilters = armorFilters,
        super._();

  final List<Stack<SkillTemplate>> _skills;
  @override
  List<Stack<SkillTemplate>> get skills {
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skills);
  }

  final List<Stack<ArmorFilter>> _armorFilters;
  @override
  List<Stack<ArmorFilter>> get armorFilters {
    if (_armorFilters is EqualUnmodifiableListView) return _armorFilters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_armorFilters);
  }

  @override
  final bool useMyDeco;

  /// Create a copy of SearcherState
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
            (identical(other.useMyDeco, useMyDeco) ||
                other.useMyDeco == useMyDeco));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_skills),
      const DeepCollectionEquality().hash(_armorFilters),
      useMyDeco);

  @override
  String toString() {
    return 'SearcherState(skills: $skills, armorFilters: $armorFilters, useMyDeco: $useMyDeco)';
  }
}

/// @nodoc
abstract mixin class _$SearcherStateCopyWith<$Res>
    implements $SearcherStateCopyWith<$Res> {
  factory _$SearcherStateCopyWith(
          _SearcherState value, $Res Function(_SearcherState) _then) =
      __$SearcherStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<Stack<SkillTemplate>> skills,
      List<Stack<ArmorFilter>> armorFilters,
      bool useMyDeco});
}

/// @nodoc
class __$SearcherStateCopyWithImpl<$Res>
    implements _$SearcherStateCopyWith<$Res> {
  __$SearcherStateCopyWithImpl(this._self, this._then);

  final _SearcherState _self;
  final $Res Function(_SearcherState) _then;

  /// Create a copy of SearcherState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? skills = null,
    Object? armorFilters = null,
    Object? useMyDeco = null,
  }) {
    return _then(_SearcherState(
      skills: null == skills
          ? _self._skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<Stack<SkillTemplate>>,
      armorFilters: null == armorFilters
          ? _self._armorFilters
          : armorFilters // ignore: cast_nullable_to_non_nullable
              as List<Stack<ArmorFilter>>,
      useMyDeco: null == useMyDeco
          ? _self.useMyDeco
          : useMyDeco // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
