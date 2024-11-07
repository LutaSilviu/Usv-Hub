import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/select_course/domain/entities/course_entity.dart';
import 'package:usv_hub/features/select_course/domain/usecases/get_all_courses.dart';
import 'package:usv_hub/features/select_course/domain/usecases/get_all_courses_for_teacher.dart';

part 'select_course_state.dart';

@injectable
class SelectCourseCubit extends Cubit<SelectCourseState> {
  final GetAllCoursesForTeacher _allCoursesForTeacher;
  final GetAllCourses _allCourses;

  SelectCourseCubit(this._allCoursesForTeacher, this._allCourses)
      : super(
          SelectCourseInitial(),
        );

  Future<void> getCourses(bool isTeacher) async {
    emit(CoursesLoading());
    if (isTeacher) {
      (await _allCoursesForTeacher.call()).fold(
        (failure) => emit(CoursesError(failure.message)),
        (assigments) => emit(CoursesLoaded(assigments)),
      );
    } else {
      (await _allCourses.call()).fold(
        (failure) => emit(CoursesError(failure.message)),
        (assigments) => emit(CoursesLoaded(assigments)),
      );
    }
  }
}
