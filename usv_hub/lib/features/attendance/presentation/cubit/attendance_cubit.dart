// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:usv_hub/features/attendance/domain/entities/attendance_entity.dart';
import 'package:usv_hub/features/attendance/domain/usecases/get_attendance.dart';
import 'package:usv_hub/features/grade/domain/entities/course_entity.dart';

part 'attendance_state.dart';

@injectable
class AttendanceCubit extends Cubit<AttendanceState> {
  final GetAttendance _attendance;
  AttendanceCubit(
    this._attendance,
  ) : super(AttendanceInitial());

  Future<void> getAttendance() async {
    emit(LoadingState());

    (await _attendance.call()).fold(
      (l) {
        emit(AttendanceError(errorMessage: l.message));
      },
      (r) {
        ///CAN BE EMPTY!
        emit(AttendanceLoaded(attendanceAndCourses: r));
      },
    );
  }
}
