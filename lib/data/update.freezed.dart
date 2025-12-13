// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Update {
  String get id;
  String get minVersion;
  DateTime get availableSince;
  int get updateVersion;
  bool get ignore;

  /// Create a copy of Update
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UpdateCopyWith<Update> get copyWith =>
      _$UpdateCopyWithImpl<Update>(this as Update, _$identity);

  /// Serializes this Update to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Update &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.minVersion, minVersion) ||
                other.minVersion == minVersion) &&
            (identical(other.availableSince, availableSince) ||
                other.availableSince == availableSince) &&
            (identical(other.updateVersion, updateVersion) ||
                other.updateVersion == updateVersion) &&
            (identical(other.ignore, ignore) || other.ignore == ignore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, minVersion, availableSince, updateVersion, ignore);

  @override
  String toString() {
    return 'Update(id: $id, minVersion: $minVersion, availableSince: $availableSince, updateVersion: $updateVersion, ignore: $ignore)';
  }
}

/// @nodoc
abstract mixin class $UpdateCopyWith<$Res> {
  factory $UpdateCopyWith(Update value, $Res Function(Update) _then) =
      _$UpdateCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String minVersion,
      DateTime availableSince,
      int updateVersion,
      bool ignore});
}

/// @nodoc
class _$UpdateCopyWithImpl<$Res> implements $UpdateCopyWith<$Res> {
  _$UpdateCopyWithImpl(this._self, this._then);

  final Update _self;
  final $Res Function(Update) _then;

  /// Create a copy of Update
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? minVersion = null,
    Object? availableSince = null,
    Object? updateVersion = null,
    Object? ignore = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      minVersion: null == minVersion
          ? _self.minVersion
          : minVersion // ignore: cast_nullable_to_non_nullable
              as String,
      availableSince: null == availableSince
          ? _self.availableSince
          : availableSince // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updateVersion: null == updateVersion
          ? _self.updateVersion
          : updateVersion // ignore: cast_nullable_to_non_nullable
              as int,
      ignore: null == ignore
          ? _self.ignore
          : ignore // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [Update].
extension UpdatePatterns on Update {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Update value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Update() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Update value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Update():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Update value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Update() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String id, String minVersion, DateTime availableSince,
            int updateVersion, bool ignore)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Update() when $default != null:
        return $default(_that.id, _that.minVersion, _that.availableSince,
            _that.updateVersion, _that.ignore);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String id, String minVersion, DateTime availableSince,
            int updateVersion, bool ignore)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Update():
        return $default(_that.id, _that.minVersion, _that.availableSince,
            _that.updateVersion, _that.ignore);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String id, String minVersion, DateTime availableSince,
            int updateVersion, bool ignore)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Update() when $default != null:
        return $default(_that.id, _that.minVersion, _that.availableSince,
            _that.updateVersion, _that.ignore);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Update implements Update {
  const _Update(
      {required this.id,
      required this.minVersion,
      required this.availableSince,
      this.updateVersion = 0,
      this.ignore = false});
  factory _Update.fromJson(Map<String, dynamic> json) => _$UpdateFromJson(json);

  @override
  final String id;
  @override
  final String minVersion;
  @override
  final DateTime availableSince;
  @override
  @JsonKey()
  final int updateVersion;
  @override
  @JsonKey()
  final bool ignore;

  /// Create a copy of Update
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UpdateCopyWith<_Update> get copyWith =>
      __$UpdateCopyWithImpl<_Update>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UpdateToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Update &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.minVersion, minVersion) ||
                other.minVersion == minVersion) &&
            (identical(other.availableSince, availableSince) ||
                other.availableSince == availableSince) &&
            (identical(other.updateVersion, updateVersion) ||
                other.updateVersion == updateVersion) &&
            (identical(other.ignore, ignore) || other.ignore == ignore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, minVersion, availableSince, updateVersion, ignore);

  @override
  String toString() {
    return 'Update(id: $id, minVersion: $minVersion, availableSince: $availableSince, updateVersion: $updateVersion, ignore: $ignore)';
  }
}

/// @nodoc
abstract mixin class _$UpdateCopyWith<$Res> implements $UpdateCopyWith<$Res> {
  factory _$UpdateCopyWith(_Update value, $Res Function(_Update) _then) =
      __$UpdateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String minVersion,
      DateTime availableSince,
      int updateVersion,
      bool ignore});
}

/// @nodoc
class __$UpdateCopyWithImpl<$Res> implements _$UpdateCopyWith<$Res> {
  __$UpdateCopyWithImpl(this._self, this._then);

  final _Update _self;
  final $Res Function(_Update) _then;

  /// Create a copy of Update
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? minVersion = null,
    Object? availableSince = null,
    Object? updateVersion = null,
    Object? ignore = null,
  }) {
    return _then(_Update(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      minVersion: null == minVersion
          ? _self.minVersion
          : minVersion // ignore: cast_nullable_to_non_nullable
              as String,
      availableSince: null == availableSince
          ? _self.availableSince
          : availableSince // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updateVersion: null == updateVersion
          ? _self.updateVersion
          : updateVersion // ignore: cast_nullable_to_non_nullable
              as int,
      ignore: null == ignore
          ? _self.ignore
          : ignore // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
