import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'personal_data_state.dart';

class PersonalDataCubit extends Cubit<PersonalDataState> {
  PersonalDataCubit() : super(PersonalDataInitial());
}
