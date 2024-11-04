import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/features/chat/domain/entities/user.dart';
import 'package:usv_hub/features/grade/domain/entities/course_entity.dart';
import 'package:usv_hub/features/grade/domain/entities/grade_entity.dart';

abstract class GradeRepository {
  Future<Either<Failure, Map<GradeEntity, CourseEntity>>>
      getAllCoursesForStudents();

  Future<Either<Failure, Map<bool, CourseEntity>>> getAllCoursesForTeachers();
  Future<Either<Failure, List<UserEntity>>> getStudentsForCourse(
      String courseId);
  Future<Either<Failure, GradeEntity?>> getStudentGrade(
      String studentId, String courseId);
  Future<Either<Failure, void>> addStudentGrade(GradeEntity grade);
}
