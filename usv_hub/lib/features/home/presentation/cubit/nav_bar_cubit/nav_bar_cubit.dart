import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'nav_bar_state.dart';

@injectable
class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(const NavBarState(0));

  void changeIndex(int index) {
    emit(NavBarState(index));
  }
}
