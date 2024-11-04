import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/features/assigments/domain/usecases/has_subbmision_usecase.dart';

@injectable
class InfoProvider extends ChangeNotifier {
  final HasSubbmissionUsecase _hasSubbmissionUsecase;

  InfoProvider(this._hasSubbmissionUsecase);

  bool _hasSubbmision = false;

  bool get hasSubbmision => _hasSubbmision;

  set hasSubbmision(bool value) {
    _hasSubbmision = value;
    notifyListeners();
  }

  Future<void> getHasSubbmision(String assigmentId) async {
    hasSubbmision =
        (await _hasSubbmissionUsecase.call(params: assigmentId)).fold(
      (l) => false,
      (r) => r,
    );
  }
}
