import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/grade/domain/usecases/get_student_grade.dart';

import 'package:usv_hub/features/grade/domain/entities/grade_entity.dart';
import 'package:injectable/injectable.dart';

part 'grade_state.dart';

@injectable
class GradeCubit extends Cubit<GradeState> {
  final GetStudentGrade _getStudentGrade;

  GradeCubit(
    this._getStudentGrade,
  ) : super(
          GradeInitial(),
        );

  Future<void> getGrades(String courseId) async {
    emit(LoadingState());
    String userId = FirebaseAuth.instance.currentUser!.uid;
    (await _getStudentGrade.call(params: GetStudentsParams(userId, courseId)))
        .fold(
      (l) => {
        emit(
          ErrorState(message: l.message),
        )
      },
      (r) => {
        if (r == null)
          {
            emit(
              const ErrorState(message: AppErrorMessages.noGradeFound),
            )
          }
        else
          {
            emit(
              GradeLoadedState(grade: r),
            )
          },
      },
    );
  }
}
