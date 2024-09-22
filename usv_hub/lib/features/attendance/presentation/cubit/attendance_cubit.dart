import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:usv_hub/features/attendance/domain/entities/attendance_entity.dart';
import 'package:usv_hub/features/grade/domain/entities/course_entity.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit() : super(AttendanceInitial());
}
