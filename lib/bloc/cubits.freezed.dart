// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cubits.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearcherState {
  List<Stack<Skill>> get skills => throw _privateConstructorUsedError;
  List<Stack<ArmorFilter>> get armorFilters =>
      throw _privateConstructorUsedError;
  bool get useMyDeco => throw _privateConstructorUsedError;

  /// Create a copy of SearcherState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearcherStateCopyWith<SearcherState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearcherStateCopyWith<$Res> {
  factory $SearcherStateCopyWith(
          SearcherState value, $Res Function(SearcherState) then) =
      _$SearcherStateCopyWithImpl<$Res, SearcherState>;
  @useResult
  $Res call(
      {List<Stack<Skill>> skills,
      List<Stack<ArmorFilter>> armorFilters,
      bool useMyDeco});
}

/// @nodoc
class _$SearcherStateCopyWithImpl<$Res, $Val extends SearcherState>
    implements $SearcherStateCopyWith<$Res> {
  _$SearcherStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearcherState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skills = null,
    Object? armorFilters = null,
    Object? useMyDeco = null,
  }) {
    return _then(_value.copyWith(
      skills: null == skills
          ? _value.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<Stack<Skill>>,
      armorFilters: null == armorFilters
          ? _value.armorFilters
          : armorFilters // ignore: cast_nullable_to_non_nullable
              as List<Stack<ArmorFilter>>,
      useMyDeco: null == useMyDeco
          ? _value.useMyDeco
          : useMyDeco // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearcherStateImplCopyWith<$Res>
    implements $SearcherStateCopyWith<$Res> {
  factory _$$SearcherStateImplCopyWith(
          _$SearcherStateImpl value, $Res Function(_$SearcherStateImpl) then) =
      __$$SearcherStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Stack<Skill>> skills,
      List<Stack<ArmorFilter>> armorFilters,
      bool useMyDeco});
}

/// @nodoc
class __$$SearcherStateImplCopyWithImpl<$Res>
    extends _$SearcherStateCopyWithImpl<$Res, _$SearcherStateImpl>
    implements _$$SearcherStateImplCopyWith<$Res> {
  __$$SearcherStateImplCopyWithImpl(
      _$SearcherStateImpl _value, $Res Function(_$SearcherStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearcherState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skills = null,
    Object? armorFilters = null,
    Object? useMyDeco = null,
  }) {
    return _then(_$SearcherStateImpl(
      skills: null == skills
          ? _value._skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<Stack<Skill>>,
      armorFilters: null == armorFilters
          ? _value._armorFilters
          : armorFilters // ignore: cast_nullable_to_non_nullable
              as List<Stack<ArmorFilter>>,
      useMyDeco: null == useMyDeco
          ? _value.useMyDeco
          : useMyDeco // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SearcherStateImpl extends _SearcherState {
  const _$SearcherStateImpl(
      {required final List<Stack<Skill>> skills,
      required final List<Stack<ArmorFilter>> armorFilters,
      required this.useMyDeco})
      : _skills = skills,
        _armorFilters = armorFilters,
        super._();

  final List<Stack<Skill>> _skills;
  @override
  List<Stack<Skill>> get skills {
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

  @override
  String toString() {
    return 'SearcherState(skills: $skills, armorFilters: $armorFilters, useMyDeco: $useMyDeco)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearcherStateImpl &&
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

  /// Create a copy of SearcherState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearcherStateImplCopyWith<_$SearcherStateImpl> get copyWith =>
      __$$SearcherStateImplCopyWithImpl<_$SearcherStateImpl>(this, _$identity);
}

abstract class _SearcherState extends SearcherState {
  const factory _SearcherState(
      {required final List<Stack<Skill>> skills,
      required final List<Stack<ArmorFilter>> armorFilters,
      required final bool useMyDeco}) = _$SearcherStateImpl;
  const _SearcherState._() : super._();

  @override
  List<Stack<Skill>> get skills;
  @override
  List<Stack<ArmorFilter>> get armorFilters;
  @override
  bool get useMyDeco;

  /// Create a copy of SearcherState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearcherStateImplCopyWith<_$SearcherStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
