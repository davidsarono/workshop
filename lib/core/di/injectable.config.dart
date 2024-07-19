// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_generative_ai/google_generative_ai.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:playground/core/di/injectable.dart' as _i14;
import 'package:playground/core/services/api_service_impl.dart' as _i10;
import 'package:playground/data/services/api/gemini_api_impl.dart' as _i6;
import 'package:playground/data/services/api/users_api_impl.dart' as _i12;
import 'package:playground/data/services/api_service.dart' as _i9;
import 'package:playground/domain/contracts/api/gemini_api.dart' as _i5;
import 'package:playground/domain/contracts/users_api.dart' as _i11;
import 'package:playground/domain/mappers/user_mapper.dart' as _i3;
import 'package:playground/domain/repositories/gemini_repository.dart' as _i7;
import 'package:playground/domain/repositories/user_repository.dart' as _i13;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i3.UserMapper>(() => _i3.UserMapper());
    gh.lazySingleton<_i4.GenerativeModel>(
        () => registerModule.generativeModel());
    gh.factory<String>(
      () => registerModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.lazySingleton<_i5.GeminiApi>(
        () => _i6.GeminiApiImpl(gh<_i4.GenerativeModel>()));
    gh.factory<_i7.GeminiRepository>(
        () => _i7.GeminiRepository(gh<_i5.GeminiApi>()));
    gh.lazySingleton<_i8.Dio>(
        () => registerModule.dio(gh<String>(instanceName: 'BaseUrl')));
    gh.lazySingleton<_i9.ApiService>(() => _i10.ApiServiceImpl(gh<_i8.Dio>()));
    gh.lazySingleton<_i11.UsersApi>(
        () => _i12.UsersApiImpl(gh<_i9.ApiService>()));
    gh.factory<_i13.UserRepository>(() => _i13.UserRepository(
          gh<_i11.UsersApi>(),
          gh<_i3.UserMapper>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i14.RegisterModule {}
