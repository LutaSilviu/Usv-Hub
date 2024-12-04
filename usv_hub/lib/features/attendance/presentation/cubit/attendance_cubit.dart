// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/core/utils/extensions.dart';

import 'package:usv_hub/features/attendance/domain/entities/attendance_entity.dart';
import 'package:usv_hub/features/attendance/domain/usecases/get_attendance_for_student.dart';
import 'package:usv_hub/features/grade/domain/usecases/get_student_grade.dart';
import 'package:usv_hub/features/select_course/domain/entities/course_entity.dart';

part 'attendance_state.dart';

@injectable
class AttendanceCubit extends Cubit<AttendanceState> {
  final GetAttendanceForStudent _attendance;
  AttendanceCubit(
    this._attendance,
  ) : super(AttendanceInitial());

  Future<void> getAttendance(String courseId) async {
    safeEmit(LoadingState());
    final userId = FirebaseAuth.instance.currentUser!.uid;

    (await _attendance.call(params: GetStudentsParams(userId, courseId))).fold(
      (l) {
        safeEmit(AttendanceError(errorMessage: l.message));
      },
      (r) {
        ///CAN BE EMPTY!
        safeEmit(AttendanceLoaded(attendance: r));
      },
    );
  }
}
