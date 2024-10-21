import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/features/assigments/domain/entities/assigment_entity.dart';
import 'package:usv_hub/features/assigments/domain/entities/submision_entity.dart';
import 'package:usv_hub/features/grade/domain/entities/course_entity.dart';

abstract class AssigmentsRepo {
  Future<Either<Failure, Map<AssigmentEntity, CourseEntity>>> getAssigments();
  Future<Either<Failure, void>> postSubmission(SubmisionEntity submision);
}
