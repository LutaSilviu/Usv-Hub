import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'assigments_state.dart';

class AssigmentsCubit extends Cubit<AssigmentsState> {
  AssigmentsCubit() : super(AssigmentsInitial());
}
