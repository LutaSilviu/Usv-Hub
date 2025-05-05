import 'package:dartz/dartz.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/features/assigments/domain/entities/assigment_entity.dart';
import 'package:usv_hub/features/assigments/domain/entities/submision_entity.dart';

abstract class AssigmentsRepo {
  Future<Either<Failure, List<AssigmentEntity>>> getAssigments(String courseId);
  Future<Either<Failure, void>> postSubmission(SubmisionEntity submision);
  Future<Either<Failure, bool>> hasSubbmision(String assigmentId);
  Future<Either<Failure, Map<SubmisionEntity, String>>> getSubbmisions(
      String assigmentId);
  Future<Either<Failure, void>> postAssigment(AssigmentEntity assigmentEntity);
}
