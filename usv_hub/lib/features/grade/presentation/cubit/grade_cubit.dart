import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:usv_hub/core/utils/consts.dart';

import 'package:usv_hub/features/grade/domain/entities/course_entity.dart';
import 'package:usv_hub/features/grade/domain/entities/grade_entity.dart';
import 'package:usv_hub/features/grade/domain/usecases/get_all_courses.dart';

part 'grade_state.dart';

class GradeCubit extends Cubit<GradeState> {
  final GetAllCourses _getAllCourses;
  GradeCubit(
    this._getAllCourses,
  ) : super(GradeInitial());

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
}
