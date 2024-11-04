import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:usv_hub/core/utils/consts.dart';

import 'package:usv_hub/features/grade/domain/entities/course_entity.dart';
import 'package:usv_hub/features/grade/domain/entities/grade_entity.dart';
import 'package:usv_hub/features/grade/domain/usecases/get_all_courses.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/features/grade/domain/usecases/get_all_courses_for_teacher.dart';

part 'grade_state.dart';

@injectable
class GradeCubit extends Cubit<GradeState> {
  final GetAllCourses _getAllCourses;
  final GetAllCoursesForTeacher _getAllCoursesForTeacher;
  GradeCubit(
    this._getAllCourses,
    this._getAllCoursesForTeacher,
  ) : super(GradeInitial()) {
    getCourses();
  }

  Future<void> getCourses() async {
    emit(LoadingState());

    (await _getAllCourses.call()).fold(
      (l) => {
        emit(
          ErrorState(message: l.message),
        )
      },
      (r) => {
        if (r.isEmpty)
          {
            emit(
              const ErrorState(message: AppErrorMessages.noCoursesFound),
            )
          }
        else
          {
            emit(
              CoursesLoadedState(mapCoursesGrades: r),
            )
          },
      },
    );
  }

  Future<void> getTeacherCourses() async {
    emit(LoadingState());

    (await _getAllCoursesForTeacher.call()).fold(
      (l) => {
        emit(
          ErrorState(message: l.message),
        )
      },
      (r) => {
        if (r.isEmpty)
          {
            emit(
              const ErrorState(message: AppErrorMessages.noCoursesFound),
            )
          }
        else
          {
            emit(
              TeacherCoursesLoadedState(mapCoursesGrades: r),
            )
          },
      },
    );
  }
}
