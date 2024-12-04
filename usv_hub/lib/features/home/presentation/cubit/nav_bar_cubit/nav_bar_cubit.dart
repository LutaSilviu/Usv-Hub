import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/utils/extensions.dart';

part 'nav_bar_state.dart';

@injectable
class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(const NavBarState(0));

  void changeIndex(int index) {
    safeEmit(NavBarState(index));
  }
}
