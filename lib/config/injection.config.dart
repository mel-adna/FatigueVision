// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fatigue_vision/core/di/third_party_module.dart' as _i800;
import 'package:fatigue_vision/core/services/alert_service.dart' as _i1028;
import 'package:fatigue_vision/features/fatigue/data/services/face_detector_service.dart'
    as _i552;
import 'package:fatigue_vision/features/history/data/history_repository.dart'
    as _i126;
import 'package:fatigue_vision/features/onboarding/data/onboarding_repository.dart'
    as _i1039;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final thirdPartyModule = _$ThirdPartyModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => thirdPartyModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i1028.AlertService>(() => _i1028.AlertService());
    gh.singletonAsync<_i126.HistoryRepository>(
      () => _i126.HistoryRepository.init(),
    );
    gh.lazySingleton<_i552.FaceDetectorService>(
      () => _i552.FaceDetectorService(),
    );
    gh.factory<_i1039.OnboardingRepository>(
      () => _i1039.OnboardingRepository(gh<_i460.SharedPreferences>()),
    );
    return this;
  }
}

class _$ThirdPartyModule extends _i800.ThirdPartyModule {}
