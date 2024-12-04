import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/features/assigments/domain/entities/submision_entity.dart';
import 'package:usv_hub/features/assigments/domain/usecases/get_submissions_usecase.dart';

part 'submission_state.dart';

@injectable
class SubmissionCubit extends Cubit<SubmissionState> {
  final GetSubmissionsUsecase _getSubmissionsUsecase;

  SubmissionCubit(this._getSubmissionsUsecase) : super(SubmissionInitial());

  Future<void> getSubmisions(String assigmentId) async {
    emit(SubmissionLoading());

    (await _getSubmissionsUsecase.call(params: assigmentId)).fold(
      (failure) => emit(SubmissionError(failure.message)),
      (assigments) => emit(SubmissionLoaded(assigments)),
    );
  }
}
