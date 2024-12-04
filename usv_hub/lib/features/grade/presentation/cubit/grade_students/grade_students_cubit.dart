import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/core/utils/extensions.dart';
import 'package:usv_hub/features/chat/domain/entities/user.dart';
import 'package:usv_hub/features/grade/domain/usecases/get_students_for_course.dart';

part 'grade_students_state.dart';

@injectable
class GradeStudentsCubit extends Cubit<GradeStudentsState> {
  final GetStudentsForCourse _gradeRepository;

  GradeStudentsCubit(this._gradeRepository) : super(GradeStudentsInitial());

  Future<void> getStudents(String courseId) async {
    safeEmit(LoadingState());

    (await _gradeRepository.call(params: courseId)).fold(
      (l) => {
        safeEmit(
          ErrorState(l.message),
        )
      },
      (r) => {
        if (r.isEmpty)
          {
            safeEmit(
              const ErrorState(AppErrorMessages.noCoursesFound),
            )
          }
        else
          {
            safeEmit(
              GradeStudentsLoaded(r),
            )
          },
      },
    );
  }
}
