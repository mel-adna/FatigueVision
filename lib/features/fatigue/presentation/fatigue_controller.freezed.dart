// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fatigue_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FatigueState {

 bool get isScanning; double get currentEAR; FatigueLevel get fatigueLevel; List<double> get historyEAR;
/// Create a copy of FatigueState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FatigueStateCopyWith<FatigueState> get copyWith => _$FatigueStateCopyWithImpl<FatigueState>(this as FatigueState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FatigueState&&(identical(other.isScanning, isScanning) || other.isScanning == isScanning)&&(identical(other.currentEAR, currentEAR) || other.currentEAR == currentEAR)&&(identical(other.fatigueLevel, fatigueLevel) || other.fatigueLevel == fatigueLevel)&&const DeepCollectionEquality().equals(other.historyEAR, historyEAR));
}


@override
int get hashCode => Object.hash(runtimeType,isScanning,currentEAR,fatigueLevel,const DeepCollectionEquality().hash(historyEAR));

@override
String toString() {
  return 'FatigueState(isScanning: $isScanning, currentEAR: $currentEAR, fatigueLevel: $fatigueLevel, historyEAR: $historyEAR)';
}


}

/// @nodoc
abstract mixin class $FatigueStateCopyWith<$Res>  {
  factory $FatigueStateCopyWith(FatigueState value, $Res Function(FatigueState) _then) = _$FatigueStateCopyWithImpl;
@useResult
$Res call({
 bool isScanning, double currentEAR, FatigueLevel fatigueLevel, List<double> historyEAR
});




}
/// @nodoc
class _$FatigueStateCopyWithImpl<$Res>
    implements $FatigueStateCopyWith<$Res> {
  _$FatigueStateCopyWithImpl(this._self, this._then);

  final FatigueState _self;
  final $Res Function(FatigueState) _then;

/// Create a copy of FatigueState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isScanning = null,Object? currentEAR = null,Object? fatigueLevel = null,Object? historyEAR = null,}) {
  return _then(_self.copyWith(
isScanning: null == isScanning ? _self.isScanning : isScanning // ignore: cast_nullable_to_non_nullable
as bool,currentEAR: null == currentEAR ? _self.currentEAR : currentEAR // ignore: cast_nullable_to_non_nullable
as double,fatigueLevel: null == fatigueLevel ? _self.fatigueLevel : fatigueLevel // ignore: cast_nullable_to_non_nullable
as FatigueLevel,historyEAR: null == historyEAR ? _self.historyEAR : historyEAR // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}

}


/// Adds pattern-matching-related methods to [FatigueState].
extension FatigueStatePatterns on FatigueState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FatigueState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FatigueState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FatigueState value)  $default,){
final _that = this;
switch (_that) {
case _FatigueState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FatigueState value)?  $default,){
final _that = this;
switch (_that) {
case _FatigueState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isScanning,  double currentEAR,  FatigueLevel fatigueLevel,  List<double> historyEAR)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FatigueState() when $default != null:
return $default(_that.isScanning,_that.currentEAR,_that.fatigueLevel,_that.historyEAR);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isScanning,  double currentEAR,  FatigueLevel fatigueLevel,  List<double> historyEAR)  $default,) {final _that = this;
switch (_that) {
case _FatigueState():
return $default(_that.isScanning,_that.currentEAR,_that.fatigueLevel,_that.historyEAR);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isScanning,  double currentEAR,  FatigueLevel fatigueLevel,  List<double> historyEAR)?  $default,) {final _that = this;
switch (_that) {
case _FatigueState() when $default != null:
return $default(_that.isScanning,_that.currentEAR,_that.fatigueLevel,_that.historyEAR);case _:
  return null;

}
}

}

/// @nodoc


class _FatigueState implements FatigueState {
  const _FatigueState({this.isScanning = false, this.currentEAR = 0.0, this.fatigueLevel = FatigueLevel.normal, final  List<double> historyEAR = const []}): _historyEAR = historyEAR;
  

@override@JsonKey() final  bool isScanning;
@override@JsonKey() final  double currentEAR;
@override@JsonKey() final  FatigueLevel fatigueLevel;
 final  List<double> _historyEAR;
@override@JsonKey() List<double> get historyEAR {
  if (_historyEAR is EqualUnmodifiableListView) return _historyEAR;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_historyEAR);
}


/// Create a copy of FatigueState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FatigueStateCopyWith<_FatigueState> get copyWith => __$FatigueStateCopyWithImpl<_FatigueState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FatigueState&&(identical(other.isScanning, isScanning) || other.isScanning == isScanning)&&(identical(other.currentEAR, currentEAR) || other.currentEAR == currentEAR)&&(identical(other.fatigueLevel, fatigueLevel) || other.fatigueLevel == fatigueLevel)&&const DeepCollectionEquality().equals(other._historyEAR, _historyEAR));
}


@override
int get hashCode => Object.hash(runtimeType,isScanning,currentEAR,fatigueLevel,const DeepCollectionEquality().hash(_historyEAR));

@override
String toString() {
  return 'FatigueState(isScanning: $isScanning, currentEAR: $currentEAR, fatigueLevel: $fatigueLevel, historyEAR: $historyEAR)';
}


}

/// @nodoc
abstract mixin class _$FatigueStateCopyWith<$Res> implements $FatigueStateCopyWith<$Res> {
  factory _$FatigueStateCopyWith(_FatigueState value, $Res Function(_FatigueState) _then) = __$FatigueStateCopyWithImpl;
@override @useResult
$Res call({
 bool isScanning, double currentEAR, FatigueLevel fatigueLevel, List<double> historyEAR
});




}
/// @nodoc
class __$FatigueStateCopyWithImpl<$Res>
    implements _$FatigueStateCopyWith<$Res> {
  __$FatigueStateCopyWithImpl(this._self, this._then);

  final _FatigueState _self;
  final $Res Function(_FatigueState) _then;

/// Create a copy of FatigueState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isScanning = null,Object? currentEAR = null,Object? fatigueLevel = null,Object? historyEAR = null,}) {
  return _then(_FatigueState(
isScanning: null == isScanning ? _self.isScanning : isScanning // ignore: cast_nullable_to_non_nullable
as bool,currentEAR: null == currentEAR ? _self.currentEAR : currentEAR // ignore: cast_nullable_to_non_nullable
as double,fatigueLevel: null == fatigueLevel ? _self.fatigueLevel : fatigueLevel // ignore: cast_nullable_to_non_nullable
as FatigueLevel,historyEAR: null == historyEAR ? _self._historyEAR : historyEAR // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}


}

// dart format on
