import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/core/utils/custom_snackbar.dart';
import 'package:usv_hub/core/utils/extensions.dart';
import 'package:usv_hub/features/grade/domain/entities/grade_entity.dart';
import 'package:usv_hub/features/grade/domain/usecases/add_student_grade.dart';
import 'package:usv_hub/features/grade/domain/usecases/get_student_grade.dart';

part 'add_grade_state.dart';

@injectable
class AddGradeCubit extends Cubit<AddGradeState> {
  final GetStudentGrade _getStudentGrade;
  final AddStudentGrade _addStudentGrade;
  AddGradeCubit(this._getStudentGrade, this._addStudentGrade)
      : super(AddGradeInitial());

  Future<void> getGrade(String studentId, String courseId) async {
    safeEmit(LoadingState());
    (await _getStudentGrade.call(
      params: GetStudentsParams(studentId, courseId),
    ))
        .fold(
            (ifLeft) => safeEmit(
                  ErrorState(ifLeft.message),
                ), (r) {
      safeEmit(GradeLoaded(r));
    });
  }

  Future<void> addGrade(
    String studentId,
    String courseId,
    double? labGrade,
    double? courseGrade,
    BuildContext context,
    String gradeId,
  ) async {
    if (labGrade == null && courseGrade == null) {
      CustomSnackbar.show(context, AppTextConst.emptyNumber);
    } else if ((labGrade != null && labGrade > 0 && labGrade <= 10) &&
        (courseGrade != null && courseGrade > 0 && courseGrade <= 10)) {
      GradeEntity grade = GradeEntity(
        id: gradeId,
        studentId: studentId,
        courseGrade: courseGrade,
        labGrade: labGrade,
        courseId: courseId,
      );
      (await _addStudentGrade.call(params: grade)).fold((l) {
        CustomSnackbar.show(context, l.message);
      }, (r) {
        Navigator.pop(context);
      });
    } else {
      CustomSnackbar.show(context, AppTextConst.invalidNumber);
    }
  }
}
