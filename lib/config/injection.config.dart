// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../core/di/third_party_module.dart' as _i1048;
import '../core/services/alert_service.dart' as _i428;
import '../features/fatigue/data/services/face_detector_service.dart' as _i22;
import '../features/history/data/history_repository.dart' as _i634;
import '../features/onboarding/data/onboarding_repository.dart' as _i679;

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
    gh.singleton<_i428.AlertService>(() => _i428.AlertService());
    gh.singletonAsync<_i634.HistoryRepository>(
      () => _i634.HistoryRepository.init(),
    );
    gh.lazySingleton<_i22.FaceDetectorService>(
      () => _i22.FaceDetectorService(),
    );
    gh.factory<_i679.OnboardingRepository>(
      () => _i679.OnboardingRepository(gh<_i460.SharedPreferences>()),
    );
    return this;
  }
}

class _$ThirdPartyModule extends _i1048.ThirdPartyModule {}
