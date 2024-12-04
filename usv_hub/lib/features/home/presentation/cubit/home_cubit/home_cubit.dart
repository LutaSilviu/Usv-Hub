import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/utils/extensions.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void triggerDrawer({bool isDrawerOpen = false}) {
    safeEmit(TriggerDrawer(isDrawerOpen: isDrawerOpen));
  }
}
