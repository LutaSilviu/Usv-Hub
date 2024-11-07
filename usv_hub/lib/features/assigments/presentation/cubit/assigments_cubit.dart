import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/assigments/domain/entities/assigment_entity.dart';
import 'package:usv_hub/features/assigments/domain/usecases/get_assigments_usecase.dart';
import 'package:usv_hub/features/select_course/domain/entities/course_entity.dart';
import 'package:usv_hub/features/select_course/domain/usecases/get_all_courses_for_teacher.dart';

part 'assigments_state.dart';

@injectable
class AssigmentsCubit extends Cubit<AssigmentsState> {
  final GetAssigmentsUsecase _getAssigmentsUsecase;
  final GetAllCoursesForTeacher _allCoursesForTeacher;

  AssigmentsCubit(
    this._getAssigmentsUsecase,
    this._allCoursesForTeacher,
  ) : super(AssigmentsInitial());

  Future<void> getAssigments(String courseId) async {
    emit(AssigmentsLoading());

    (await _getAssigmentsUsecase.call(params: courseId)).fold(
      (failure) => emit(AssigmentsError(failure.message)),
      (assigments) => emit(AssigmentsLoaded(assigments)),
    );
  }

  Future<void> getCourses() async {
    emit(AssigmentsLoading());

    (await _allCoursesForTeacher.call()).fold(
      (failure) => emit(AssigmentsError(failure.message)),
      (assigments) => emit(CoursesLoaded(assigments)),
    );
  }
}
