// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HistoryEvent {

 DateTime get date; String get level;// 'Normal', 'Drowsy'
 double get ear;
/// Create a copy of HistoryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryEventCopyWith<HistoryEvent> get copyWith => _$HistoryEventCopyWithImpl<HistoryEvent>(this as HistoryEvent, _$identity);

  /// Serializes this HistoryEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryEvent&&(identical(other.date, date) || other.date == date)&&(identical(other.level, level) || other.level == level)&&(identical(other.ear, ear) || other.ear == ear));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,level,ear);

@override
String toString() {
  return 'HistoryEvent(date: $date, level: $level, ear: $ear)';
}


}

/// @nodoc
abstract mixin class $HistoryEventCopyWith<$Res>  {
  factory $HistoryEventCopyWith(HistoryEvent value, $Res Function(HistoryEvent) _then) = _$HistoryEventCopyWithImpl;
@useResult
$Res call({
 DateTime date, String level, double ear
});




}
/// @nodoc
class _$HistoryEventCopyWithImpl<$Res>
    implements $HistoryEventCopyWith<$Res> {
  _$HistoryEventCopyWithImpl(this._self, this._then);

  final HistoryEvent _self;
  final $Res Function(HistoryEvent) _then;

/// Create a copy of HistoryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? level = null,Object? ear = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,ear: null == ear ? _self.ear : ear // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [HistoryEvent].
extension HistoryEventPatterns on HistoryEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoryEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoryEvent() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoryEvent value)  $default,){
final _that = this;
switch (_that) {
case _HistoryEvent():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoryEvent value)?  $default,){
final _that = this;
switch (_that) {
case _HistoryEvent() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  String level,  double ear)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoryEvent() when $default != null:
return $default(_that.date,_that.level,_that.ear);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  String level,  double ear)  $default,) {final _that = this;
switch (_that) {
case _HistoryEvent():
return $default(_that.date,_that.level,_that.ear);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  String level,  double ear)?  $default,) {final _that = this;
switch (_that) {
case _HistoryEvent() when $default != null:
return $default(_that.date,_that.level,_that.ear);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HistoryEvent implements HistoryEvent {
  const _HistoryEvent({required this.date, required this.level, required this.ear});
  factory _HistoryEvent.fromJson(Map<String, dynamic> json) => _$HistoryEventFromJson(json);

@override final  DateTime date;
@override final  String level;
// 'Normal', 'Drowsy'
@override final  double ear;

/// Create a copy of HistoryEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryEventCopyWith<_HistoryEvent> get copyWith => __$HistoryEventCopyWithImpl<_HistoryEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistoryEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryEvent&&(identical(other.date, date) || other.date == date)&&(identical(other.level, level) || other.level == level)&&(identical(other.ear, ear) || other.ear == ear));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,level,ear);

@override
String toString() {
  return 'HistoryEvent(date: $date, level: $level, ear: $ear)';
}


}

/// @nodoc
abstract mixin class _$HistoryEventCopyWith<$Res> implements $HistoryEventCopyWith<$Res> {
  factory _$HistoryEventCopyWith(_HistoryEvent value, $Res Function(_HistoryEvent) _then) = __$HistoryEventCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, String level, double ear
});




}
/// @nodoc
class __$HistoryEventCopyWithImpl<$Res>
    implements _$HistoryEventCopyWith<$Res> {
  __$HistoryEventCopyWithImpl(this._self, this._then);

  final _HistoryEvent _self;
  final $Res Function(_HistoryEvent) _then;

/// Create a copy of HistoryEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? level = null,Object? ear = null,}) {
  return _then(_HistoryEvent(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,ear: null == ear ? _self.ear : ear // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
