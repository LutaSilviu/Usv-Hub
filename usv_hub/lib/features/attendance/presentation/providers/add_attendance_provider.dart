import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/core/utils/custom_snackbar.dart';
import 'package:usv_hub/features/attendance/domain/entities/attendance_entity.dart';
import 'package:usv_hub/features/attendance/domain/usecases/add_attandance.dart';
import 'package:usv_hub/features/attendance/domain/usecases/get_attendance_for_student.dart';
import 'package:usv_hub/features/grade/domain/usecases/get_student_grade.dart';

@Injectable()
class AddAttendanceProvider extends ChangeNotifier {
  final GetAttendanceForStudent _getAttendanceForStudent;
  final AddAttandance _addAttandance;
  AddAttendanceProvider(this._getAttendanceForStudent, this._addAttandance);

  Map<int, AttendanceStatus> _listOfAttendancesLaboratory = {};
  final Map<int, AttendanceStatus> _listOfAttendancesCourse = {};

  int _selectedLab = 1;
  int _selectedCourse = 1;
  late String attendanceId;

  int get selectedLab => _selectedLab;
  int get selectedCourse => _selectedCourse;

  set selectedLab(int value) {
    _selectedLab = value;
    notifyListeners();
  }

  set selectedCourse(int value) {
    _selectedCourse = value;
    notifyListeners();
  }

  Map<int, AttendanceStatus> get listOfAttendancesLaboratory =>
      _listOfAttendancesLaboratory;

  set listOfAttendancesLaboratory(Map<int, AttendanceStatus> value) {
    _listOfAttendancesLaboratory = value;
    notifyListeners();
  }

  Map<int, AttendanceStatus> get listOfAttendancesCourse =>
      _listOfAttendancesCourse;

  void setAttendanceLab(AttendanceStatus attendanceStatus) {
    _listOfAttendancesLaboratory[_selectedLab] = attendanceStatus;
    notifyListeners();
  }

  void setAttendanceCourse(AttendanceStatus attendanceStatus) {
    _listOfAttendancesCourse[_selectedCourse] = attendanceStatus;
    notifyListeners();
  }

  void removeAttendanceCourse() {
    _listOfAttendancesCourse.remove(_selectedCourse);
    notifyListeners();
  }

  void removeAttendanceLab() {
    _listOfAttendancesLaboratory.remove(_selectedLab);
    notifyListeners();
  }

  Future<void> addAttendance(
      String studentId, String courseId, BuildContext context) async {
    AttendanceEntity attendanceEntity = AttendanceEntity(
      id: attendanceId,
      courseId: courseId,
      studentId: studentId,
      courseAttendance: _listOfAttendancesCourse.map(
        (key, value) {
          if (value == AttendanceStatus.present) {
            return MapEntry(key.toString(), true);
          }
          return MapEntry(key.toString(), false);
        },
      ),
      labortoryAttendance: _listOfAttendancesLaboratory.map(
        (key, value) {
          if (value == AttendanceStatus.present) {
            return MapEntry(key.toString(), true);
          }
          return MapEntry(key.toString(), false);
        },
      ),
    );
    (await _addAttandance.call(params: attendanceEntity)).fold((ifLeft) {
      CustomSnackbar.show(context, ifLeft.message);
    }, (ifRight) {
      Navigator.pop(context);
    });
  }

  Future<void> getAttendance(
      String studentId, String courseId, BuildContext context) async {
    (await _getAttendanceForStudent.call(
            params: GetStudentsParams(studentId, courseId)))
        .fold((l) {
      CustomSnackbar.show(context, AppErrorMessages.firebaseError);
    }, (r) {
      attendanceId = r.id;
      r.courseAttendance.forEach((key, value) {
        _listOfAttendancesCourse[int.parse(key)] =
            value ? AttendanceStatus.present : AttendanceStatus.absent;
      });
      r.labortoryAttendance.forEach((key, value) {
        _listOfAttendancesLaboratory[int.parse(key)] =
            value ? AttendanceStatus.present : AttendanceStatus.absent;
      });
    });
  }
}
