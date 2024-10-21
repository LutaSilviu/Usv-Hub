// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'features/assigments/data/datasources/assigments_api_service.dart'
    as _i424;
import 'features/assigments/data/repositories/assigments_repo_impl.dart'
    as _i632;
import 'features/assigments/domain/repositories/assigments_repo.dart' as _i12;
import 'features/assigments/domain/usecases/get_assigments_usecase.dart'
    as _i548;
import 'features/assigments/presentation/cubit/assigments_cubit.dart' as _i698;
import 'features/attendance/data/datasources/attendance_api_service.dart'
    as _i240;
import 'features/attendance/data/repositories/attendance_repo_impl.dart'
    as _i1059;
import 'features/attendance/domain/repositories/attendance_repository.dart'
    as _i114;
import 'features/attendance/domain/usecases/get_attendance.dart' as _i521;
import 'features/attendance/presentation/cubit/attendance_cubit.dart' as _i61;
import 'features/chat/data/datasources/chat_firestore_api.dart' as _i1028;
import 'features/chat/data/repositories/chat_repo_impl.dart' as _i843;
import 'features/chat/domain/repositories/chat_repo.dart' as _i359;
import 'features/chat/domain/usecases/get_all_messages.dart' as _i365;
import 'features/chat/domain/usecases/get_contacts_usecase.dart' as _i229;
import 'features/chat/domain/usecases/send_message_usecase.dart' as _i72;
import 'features/chat/presentation/cubit/contacts/contacts_cubit.dart' as _i392;
import 'features/events/data/datasources/event_service_api.dart' as _i242;
import 'features/events/data/repositories/event_repo_impl.dart' as _i877;
import 'features/events/domain/repositories/event_repo.dart' as _i351;
import 'features/events/domain/usecases/get_events_usecase.dart' as _i331;
import 'features/events/presentation/cubit/events_cubit.dart' as _i132;
import 'features/grade/data/datasources/grade_api_service.dart' as _i1020;
import 'features/grade/data/repositories/grade_repo_impl.dart' as _i34;
import 'features/grade/domain/repositories/grade_repository.dart' as _i535;
import 'features/grade/domain/usecases/get_all_courses.dart' as _i650;
import 'features/grade/presentation/cubit/grade_cubit.dart' as _i772;
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
import 'features/schedule/data/datasources/schedule_firestore_api.dart'
    as _i654;
import 'features/schedule/data/repositories/schedule_repo_impl.dart' as _i707;
import 'features/schedule/domain/repositories/schedule_repo.dart' as _i901;
import 'features/schedule/domain/usecases/get_student_schedule.dart' as _i23;
import 'features/schedule/presentation/cubit/schedule_cubit.dart' as _i211;

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
    gh.lazySingleton<_i240.AttendanceApiService>(
        () => _i240.AttendanceApiService());
    gh.lazySingleton<_i1028.ChatFirestoreApi>(() => _i1028.ChatFirestoreApi());
    gh.lazySingleton<_i242.EventServiceApi>(() => _i242.EventServiceApi());
    gh.lazySingleton<_i1020.GradeApiService>(() => _i1020.GradeApiService());
    gh.lazySingleton<_i285.AuthenticationFirestoreApi>(
        () => _i285.AuthenticationFirestoreApi());
    gh.lazySingleton<_i507.AuthenticationValidator>(
        () => _i507.AuthenticationValidator());
    gh.lazySingleton<_i654.ScheduleFirestoreApi>(
        () => _i654.ScheduleFirestoreApi());
    gh.lazySingleton<_i424.AssigmentsApiService>(
        () => _i424.AssigmentsApiService());
    gh.lazySingleton<_i17.AuthRepo>(
        () => _i1007.AuthRepoImpl(gh<_i285.AuthenticationFirestoreApi>()));
    gh.lazySingleton<_i864.AuthUseCase>(() => _i864.AuthUseCase(
          authRepo: gh<_i17.AuthRepo>(),
          fieldValidator: gh<_i507.AuthenticationValidator>(),
        ));
    gh.lazySingleton<_i12.AssigmentsRepo>(
        () => _i632.AssigmentsRepoImpl(gh<_i424.AssigmentsApiService>()));
    gh.lazySingleton<_i359.ChatRepo>(
        () => _i843.ChatRepoImpl(gh<_i1028.ChatFirestoreApi>()));
    gh.lazySingleton<_i535.GradeRepository>(() => _i34.GradeRepoImpl());
    gh.lazySingleton<_i114.AttendanceRepository>(
        () => _i1059.AttendanceRepoImpl(gh<_i240.AttendanceApiService>()));
    gh.lazySingleton<_i365.GetAllMessages>(
        () => _i365.GetAllMessages(gh<_i1028.ChatFirestoreApi>()));
    gh.lazySingleton<_i650.GetAllCourses>(
        () => _i650.GetAllCourses(gh<_i535.GradeRepository>()));
    gh.lazySingleton<_i521.GetAttendance>(
        () => _i521.GetAttendance(gh<_i114.AttendanceRepository>()));
    gh.factory<_i774.LoginCubit>(
        () => _i774.LoginCubit(authUseCase: gh<_i864.AuthUseCase>()));
    gh.lazySingleton<_i548.GetAssigmentsUsecase>(
        () => _i548.GetAssigmentsUsecase(gh<_i12.AssigmentsRepo>()));
    gh.lazySingleton<_i351.EventRepo>(
        () => _i877.EventRepoImpl(gh<_i242.EventServiceApi>()));
    gh.lazySingleton<_i229.GetContactsUsecase>(
        () => _i229.GetContactsUsecase(gh<_i359.ChatRepo>()));
    gh.lazySingleton<_i72.GetContactsUsecase>(
        () => _i72.GetContactsUsecase(gh<_i359.ChatRepo>()));
    gh.factory<_i392.ContactsCubit>(
        () => _i392.ContactsCubit(gh<_i359.ChatRepo>()));
    gh.factory<_i698.AssigmentsCubit>(
        () => _i698.AssigmentsCubit(gh<_i548.GetAssigmentsUsecase>()));
    gh.lazySingleton<_i901.ScheduleRepo>(
        () => _i707.ScheduleRepoImpl(gh<_i654.ScheduleFirestoreApi>()));
    gh.factory<_i61.AttendanceCubit>(
        () => _i61.AttendanceCubit(gh<_i521.GetAttendance>()));
    gh.factory<_i772.GradeCubit>(
        () => _i772.GradeCubit(gh<_i650.GetAllCourses>()));
    gh.lazySingleton<_i331.GetEventsUsecase>(
        () => _i331.GetEventsUsecase(gh<_i351.EventRepo>()));
    gh.lazySingleton<_i23.GetStudentSchedule>(
        () => _i23.GetStudentSchedule(gh<_i901.ScheduleRepo>()));
    gh.factory<_i132.EventsCubit>(
        () => _i132.EventsCubit(gh<_i331.GetEventsUsecase>()));
    gh.factory<_i211.ScheduleCubit>(
        () => _i211.ScheduleCubit(gh<_i23.GetStudentSchedule>()));
    return this;
  }
}
