import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/core/utils/consts.dart';

import 'package:usv_hub/features/select_course/domain/entities/course_entity.dart';

import 'package:injectable/injectable.dart';
import 'package:usv_hub/features/select_course/data/datasources/course_api_service.dart';
import 'package:usv_hub/features/select_course/domain/repositories/courses_repository.dart';

@LazySingleton(as: CoursesRepository)
class CoursesRepoImpl extends CoursesRepository {
  final CourseApiService _courseApiService;
  CoursesRepoImpl(this._courseApiService);

  @override
  Future<Either<Failure, Map<ProfesorType, List<CourseEntity>>>>
      getAllCoursesForStudents() async {
    try {
      return Right(await _courseApiService.getAllCoursesForStudent());
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Map<ProfesorType, List<CourseEntity>>>>
      getAllCoursesForTeachers() async {
    try {
      return Right(await _courseApiService.getAllCoursesForTeacher());
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }
}
