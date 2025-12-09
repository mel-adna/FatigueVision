// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fatigue_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FatigueController)
const fatigueControllerProvider = FatigueControllerProvider._();

final class FatigueControllerProvider
    extends $NotifierProvider<FatigueController, FatigueState> {
  const FatigueControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fatigueControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fatigueControllerHash();

  @$internal
  @override
  FatigueController create() => FatigueController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FatigueState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FatigueState>(value),
    );
  }
}

String _$fatigueControllerHash() => r'd65b2ae47dba6e4ae409d9d024ff8a5844ca0bd9';

abstract class _$FatigueController extends $Notifier<FatigueState> {
  FatigueState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<FatigueState, FatigueState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FatigueState, FatigueState>,
              FatigueState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
