// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'features/home/presentation/cubit/home_cubit/home_cubit.dart' as _i604;
import 'features/home/presentation/cubit/nav_bar_cubit/nav_bar_cubit.dart'
    as _i105;
import 'features/login/data/datasources/authentication_firestore_api.dart'
    as _i285;
import 'features/login/data/repositories/auth_repo_impl.dart' as _i1007;
import 'features/login/domain/repositories/auth_repo.dart' as _i17;
import 'features/login/domain/usecases/auth_usecase.dart' as _i864;
import 'features/login/domain/validators.dart' as _i507;
import 'features/login/presentation/cubit/login_cubit.dart' as _i774;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i604.HomeCubit>(() => _i604.HomeCubit());
    gh.factory<_i105.NavBarCubit>(() => _i105.NavBarCubit());
    gh.lazySingleton<_i285.AuthenticationFirestoreApi>(
        () => _i285.AuthenticationFirestoreApi());
    gh.lazySingleton<_i507.AuthenticationValidator>(
        () => _i507.AuthenticationValidator());
    gh.lazySingleton<_i17.AuthRepo>(
        () => _i1007.AuthRepoImpl(gh<_i285.AuthenticationFirestoreApi>()));
    gh.lazySingleton<_i864.AuthUseCase>(() => _i864.AuthUseCase(
          authRepo: gh<_i17.AuthRepo>(),
          fieldValidator: gh<_i507.AuthenticationValidator>(),
        ));
    gh.factory<_i774.LoginCubit>(
        () => _i774.LoginCubit(authUseCase: gh<_i864.AuthUseCase>()));
    return this;
  }
}
