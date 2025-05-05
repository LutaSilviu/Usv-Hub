import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/errors/exceptions.dart';
import 'package:usv_hub/core/errors/failures.dart';
import 'package:usv_hub/features/assigments/data/datasources/assigments_api_service.dart';
import 'package:usv_hub/features/assigments/data/models/assigments_model.dart';
import 'package:usv_hub/features/assigments/data/models/subbmision_model.dart';
import 'package:usv_hub/features/assigments/domain/entities/assigment_entity.dart';
import 'package:usv_hub/features/assigments/domain/entities/submision_entity.dart';
import 'package:usv_hub/features/assigments/domain/repositories/assigments_repo.dart';

@LazySingleton(as: AssigmentsRepo)
class AssigmentsRepoImpl extends AssigmentsRepo {
  final AssigmentsApiService _assigmentsApiService;

  AssigmentsRepoImpl(this._assigmentsApiService);

  @override
  Future<Either<Failure, List<AssigmentEntity>>> getAssigments(
      String courseId) async {
    try {
      return Right(await _assigmentsApiService.getAssigments(courseId));
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> postSubmission(
      SubmisionEntity submision) async {
    try {
      SubbmisionModel subbmisionModel = SubbmisionModel(
        submision.id,
        submision.assigmentId,
        submision.studentId,
        submision.downloadUrl,
        submision.postDate,
      );
      return Right(await _assigmentsApiService.postSubbmision(subbmisionModel));
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> hasSubbmision(String assigmentId) async {
    try {
      return Right(await _assigmentsApiService.hasSubbmision(assigmentId));
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Map<SubbmisionModel, String>>> getSubbmisions(
      String assigmentId) async {
    try {
      return Right(await _assigmentsApiService.getSubbmisions(assigmentId));
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> postAssigment(
      AssigmentEntity assigmentEntity) async {
    try {
      AssigmentsModel assigmentsModel = AssigmentsModel(
        id: assigmentEntity.id,
        courseId: assigmentEntity.courseId,
        title: assigmentEntity.title,
        description: assigmentEntity.description,
        startTime: assigmentEntity.startTime,
        endTime: assigmentEntity.endTime,
      );

      return Right(_assigmentsApiService.postAssigment(assigmentsModel));
    } on MediumException catch (e) {
      return Left(MediumFailure(message: e.message));
    }
  }
}
