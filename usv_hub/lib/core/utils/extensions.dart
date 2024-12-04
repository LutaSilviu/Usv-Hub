import 'package:flutter_bloc/flutter_bloc.dart';

extension SafeEmit on Cubit {
  void safeEmit(dynamic state) {
    if (!isClosed) emit(state);
  }
}
