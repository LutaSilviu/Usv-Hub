// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'features/adresses/data/datasources/addresses_api_service.dart' as _i55;
import 'features/adresses/data/repositories/addresses_repo_impl.dart' as _i751;
import 'features/adresses/domain/repositories/addresses_repo.dart' as _i533;
import 'features/adresses/presentation/cubit/adresses_cubit.dart' as _i408;
import 'features/assigments/data/datasources/assigments_api_service.dart'
    as _i424;
import 'features/assigments/data/repositories/assigments_repo_impl.dart'
    as _i632;
import 'features/assigments/domain/repositories/assigments_repo.dart' as _i12;
import 'features/assigments/domain/usecases/get_assigments_usecase.dart'
    as _i548;
import 'features/assigments/domain/usecases/get_submissions_usecase.dart'
    as _i631;
import 'features/assigments/domain/usecases/has_subbmision_usecase.dart'
    as _i878;
import 'features/assigments/domain/usecases/post_assigment_usecase.dart'
    as _i456;
import 'features/assigments/domain/usecases/post_subbmision_usecase.dart'
    as _i291;
import 'features/assigments/presentation/cubits/assigments_cubit/assigments_cubit.dart'
    as _i346;
import 'features/assigments/presentation/cubits/subbmision_cubit/submission_cubit.dart'
    as _i577;
import 'features/assigments/presentation/providers/add_assigment_provider.dart'
    as _i705;
import 'features/assigments/presentation/providers/info_provider.dart' as _i39;
import 'features/assigments/presentation/providers/picked_files_provider.dart'
    as _i79;
import 'features/attendance/data/datasources/attendance_api_service.dart'
    as _i240;
import 'features/attendance/data/repositories/attendance_repo_impl.dart'
    as _i1059;
import 'features/attendance/domain/repositories/attendance_repository.dart'
    as _i114;
import 'features/attendance/domain/usecases/add_attandance.dart' as _i181;
import 'features/attendance/domain/usecases/get_attendance_for_student.dart'
    as _i186;
import 'features/attendance/domain/usecases/get_student_by_name.dart' as _i986;
import 'features/attendance/presentation/cubit/attendance_cubit.dart' as _i61;
import 'features/attendance/presentation/providers/add_attendance_provider.dart'
    as _i564;
import 'features/chat/data/datasources/chat_firestore_api.dart' as _i1028;
import 'features/chat/data/repositories/chat_repo_impl.dart' as _i843;
import 'features/chat/domain/repositories/chat_repo.dart' as _i359;
import 'features/chat/domain/usecases/create_contact.dart' as _i791;
import 'features/chat/domain/usecases/get_all_messages.dart' as _i365;
import 'features/chat/domain/usecases/get_contacts_usecase.dart' as _i229;
import 'features/chat/domain/usecases/get_potential_contacts.dart' as _i82;
import 'features/chat/domain/usecases/send_message_usecase.dart' as _i72;
import 'features/chat/presentation/cubit/contacts/contacts_cubit.dart' as _i392;
import 'features/chat/presentation/cubit/messages/messages_cubit.dart' as _i73;
import 'features/chat/presentation/cubit/potential_contacts/potential_contacts_cubit.dart'
    as _i553;
import 'features/events/data/datasources/event_service_api.dart' as _i242;
import 'features/events/data/repositories/event_repo_impl.dart' as _i877;
import 'features/events/domain/repositories/event_repo.dart' as _i351;
import 'features/events/domain/usecases/get_events_usecase.dart' as _i331;
import 'features/events/domain/usecases/get_teacher_events_usecase.dart'
    as _i376;
import 'features/events/presentation/cubit/events_cubit.dart' as _i132;
import 'features/grade/data/datasources/grade_api_service.dart' as _i1020;
import 'features/grade/data/repositories/grade_repo_impl.dart' as _i34;
import 'features/grade/domain/repositories/grade_repository.dart' as _i535;
import 'features/grade/domain/usecases/add_student_grade.dart' as _i1037;
import 'features/grade/domain/usecases/get_student_grade.dart' as _i207;
import 'features/grade/domain/usecases/get_students_for_course.dart' as _i559;
import 'features/grade/presentation/cubit/add_grade/add_grade_cubit.dart'
    as _i35;
import 'features/grade/presentation/cubit/grade_courses/grade_cubit.dart'
    as _i442;
import 'features/grade/presentation/cubit/grade_students/grade_students_cubit.dart'
    as _i52;
import 'features/grade/presentation/provider/add_attendance_file_provider.dart'
    as _i1037;
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
import 'features/login/presentation/providers/user_provider.dart' as _i170;
import 'features/schedule/data/datasources/schedule_firestore_api.dart'
    as _i654;
import 'features/schedule/data/repositories/schedule_repo_impl.dart' as _i707;
import 'features/schedule/domain/repositories/schedule_repo.dart' as _i901;
import 'features/schedule/domain/usecases/get_student_schedule.dart' as _i23;
import 'features/schedule/presentation/cubit/schedule_cubit.dart' as _i211;
import 'features/select_course/data/datasources/course_api_service.dart'
    as _i221;
import 'features/select_course/data/repositories/courses_repo_impl.dart'
    as _i763;
import 'features/select_course/domain/repositories/courses_repository.dart'
    as _i23;
import 'features/select_course/domain/usecases/get_all_courses.dart' as _i221;
import 'features/select_course/domain/usecases/get_all_courses_for_teacher.dart'
    as _i681;
import 'features/select_course/presentation/cubit/select_course_cubit.dart'
    as _i363;

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
    gh.lazySingleton<_i55.AddressesApiService>(
        () => _i55.AddressesApiService());
    gh.lazySingleton<_i424.AssigmentsApiService>(
        () => _i424.AssigmentsApiService());
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
    gh.lazySingleton<_i221.CourseApiService>(() => _i221.CourseApiService());
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
    gh.lazySingleton<_i23.CoursesRepository>(
        () => _i763.CoursesRepoImpl(gh<_i221.CourseApiService>()));
    gh.lazySingleton<_i365.GetAllMessages>(
        () => _i365.GetAllMessages(gh<_i1028.ChatFirestoreApi>()));
    gh.factory<_i170.UserProvider>(
        () => _i170.UserProvider(authRepo: gh<_i17.AuthRepo>()));
    gh.lazySingleton<_i533.AddressesRepo>(
        () => _i751.AddressesRepoImpl(gh<_i55.AddressesApiService>()));
    gh.lazySingleton<_i221.GetAllCourses>(
        () => _i221.GetAllCourses(gh<_i23.CoursesRepository>()));
    gh.lazySingleton<_i114.AttendanceRepository>(
        () => _i1059.AttendanceRepoImpl(gh<_i240.AttendanceApiService>()));
    gh.lazySingleton<_i181.AddAttandance>(
        () => _i181.AddAttandance(gh<_i114.AttendanceRepository>()));
    gh.lazySingleton<_i186.GetAttendanceForStudent>(
        () => _i186.GetAttendanceForStudent(gh<_i114.AttendanceRepository>()));
    gh.lazySingleton<_i986.GetStudentByName>(
        () => _i986.GetStudentByName(gh<_i114.AttendanceRepository>()));
    gh.factory<_i774.LoginCubit>(
        () => _i774.LoginCubit(authUseCase: gh<_i864.AuthUseCase>()));
    gh.factory<_i1037.AddAttendanceFileProvider>(
        () => _i1037.AddAttendanceFileProvider(
              gh<_i181.AddAttandance>(),
              gh<_i986.GetStudentByName>(),
              gh<_i186.GetAttendanceForStudent>(),
            ));
    gh.lazySingleton<_i548.GetAssigmentsUsecase>(
        () => _i548.GetAssigmentsUsecase(gh<_i12.AssigmentsRepo>()));
    gh.lazySingleton<_i631.GetSubmissionsUsecase>(
        () => _i631.GetSubmissionsUsecase(gh<_i12.AssigmentsRepo>()));
    gh.lazySingleton<_i878.HasSubbmissionUsecase>(
        () => _i878.HasSubbmissionUsecase(gh<_i12.AssigmentsRepo>()));
    gh.lazySingleton<_i291.PostSubbmisionUsecase>(
        () => _i291.PostSubbmisionUsecase(gh<_i12.AssigmentsRepo>()));
    gh.lazySingleton<_i456.PostAssigmentUsecase>(
        () => _i456.PostAssigmentUsecase(gh<_i12.AssigmentsRepo>()));
    gh.lazySingleton<_i351.EventRepo>(
        () => _i877.EventRepoImpl(gh<_i242.EventServiceApi>()));
    gh.lazySingleton<_i791.CreateContact>(
        () => _i791.CreateContact(gh<_i359.ChatRepo>()));
    gh.lazySingleton<_i229.GetContactsUsecase>(
        () => _i229.GetContactsUsecase(gh<_i359.ChatRepo>()));
    gh.lazySingleton<_i82.GetPotentialContacts>(
        () => _i82.GetPotentialContacts(gh<_i359.ChatRepo>()));
    gh.lazySingleton<_i72.SendMessageUsecase>(
        () => _i72.SendMessageUsecase(gh<_i359.ChatRepo>()));
    gh.factory<_i346.AssigmentsCubit>(
        () => _i346.AssigmentsCubit(gh<_i548.GetAssigmentsUsecase>()));
    gh.lazySingleton<_i535.GradeRepository>(
        () => _i34.GradeRepoImpl(gh<_i1020.GradeApiService>()));
    gh.lazySingleton<_i901.ScheduleRepo>(
        () => _i707.ScheduleRepoImpl(gh<_i654.ScheduleFirestoreApi>()));
    gh.factory<_i61.AttendanceCubit>(
        () => _i61.AttendanceCubit(gh<_i186.GetAttendanceForStudent>()));
    gh.factory<_i39.InfoProvider>(
        () => _i39.InfoProvider(gh<_i878.HasSubbmissionUsecase>()));
    gh.factory<_i553.PotentialContactsCubit>(() => _i553.PotentialContactsCubit(
          gh<_i82.GetPotentialContacts>(),
          gh<_i791.CreateContact>(),
        ));
    gh.factory<_i564.AddAttendanceProvider>(() => _i564.AddAttendanceProvider(
          gh<_i186.GetAttendanceForStudent>(),
          gh<_i181.AddAttandance>(),
        ));
    gh.factory<_i705.AddAssigmentProvider>(
        () => _i705.AddAssigmentProvider(gh<_i456.PostAssigmentUsecase>()));
    gh.lazySingleton<_i681.GetAllCoursesForTeacher>(
        () => _i681.GetAllCoursesForTeacher(gh<_i23.CoursesRepository>()));
    gh.factory<_i392.ContactsCubit>(
        () => _i392.ContactsCubit(gh<_i229.GetContactsUsecase>()));
    gh.factory<_i79.PickedFilesProvider>(
        () => _i79.PickedFilesProvider(gh<_i291.PostSubbmisionUsecase>()));
    gh.factory<_i73.MessagesCubit>(
        () => _i73.MessagesCubit(gh<_i72.SendMessageUsecase>()));
    gh.lazySingleton<_i331.GetEventsUsecase>(
        () => _i331.GetEventsUsecase(gh<_i351.EventRepo>()));
    gh.lazySingleton<_i376.GetTeacherEventsUsecase>(
        () => _i376.GetTeacherEventsUsecase(gh<_i351.EventRepo>()));
    gh.factory<_i132.EventsCubit>(() => _i132.EventsCubit(
          gh<_i331.GetEventsUsecase>(),
          gh<_i376.GetTeacherEventsUsecase>(),
        ));
    gh.factory<_i408.AddressesCubit>(
        () => _i408.AddressesCubit(gh<_i533.AddressesRepo>()));
    gh.lazySingleton<_i1037.AddStudentGrade>(
        () => _i1037.AddStudentGrade(gh<_i535.GradeRepository>()));
    gh.lazySingleton<_i559.GetStudentsForCourse>(
        () => _i559.GetStudentsForCourse(gh<_i535.GradeRepository>()));
    gh.lazySingleton<_i207.GetStudentGrade>(
        () => _i207.GetStudentGrade(gh<_i535.GradeRepository>()));
    gh.lazySingleton<_i23.GetStudentSchedule>(
        () => _i23.GetStudentSchedule(gh<_i901.ScheduleRepo>()));
    gh.factory<_i577.SubmissionCubit>(
        () => _i577.SubmissionCubit(gh<_i631.GetSubmissionsUsecase>()));
    gh.factory<_i363.SelectCourseCubit>(() => _i363.SelectCourseCubit(
          gh<_i681.GetAllCoursesForTeacher>(),
          gh<_i221.GetAllCourses>(),
        ));
    gh.factory<_i442.GradeCubit>(
        () => _i442.GradeCubit(gh<_i207.GetStudentGrade>()));
    gh.factory<_i52.GradeStudentsCubit>(
        () => _i52.GradeStudentsCubit(gh<_i559.GetStudentsForCourse>()));
    gh.factory<_i211.ScheduleCubit>(
        () => _i211.ScheduleCubit(gh<_i23.GetStudentSchedule>()));
    gh.factory<_i35.AddGradeCubit>(() => _i35.AddGradeCubit(
          gh<_i207.GetStudentGrade>(),
          gh<_i1037.AddStudentGrade>(),
        ));
    return this;
  }
}
