import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/features/assigments/domain/entities/assigment_entity.dart';
import 'package:usv_hub/features/assigments/domain/usecases/get_assigments_usecase.dart';

part 'assigments_state.dart';

@injectable
class AssigmentsCubit extends Cubit<AssigmentsState> {
  final GetAssigmentsUsecase _getAssigmentsUsecase;

  AssigmentsCubit(
    this._getAssigmentsUsecase,
  ) : super(AssigmentsInitial());

  Future<void> getAssigments(String courseId) async {
    emit(AssigmentsLoading());

    (await _getAssigmentsUsecase.call(params: courseId)).fold(
      (failure) => emit(AssigmentsError(failure.message)),
      (assigments) => emit(AssigmentsLoaded(assigments)),
    );
  }
}
