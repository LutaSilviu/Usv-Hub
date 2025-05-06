import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/assigments/domain/entities/assigment_entity.dart';
import 'package:usv_hub/features/assigments/domain/usecases/post_assigment_usecase.dart';

@injectable
class AddAssigmentProvider extends ChangeNotifier {
  final PostAssigmentUsecase _postAssigmentUsecase;
  AddAssigmentProvider(this._postAssigmentUsecase);

  String? _title;
  String? _description;
  DateTime? _startDate;
  DateTime? _endDate;

  String? _errorMessage;

  String? get title => _title;
  String? get description => _description;
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  String? get errorMessage => _errorMessage;

  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  void setDescription(String description) {
    _description = description;
    notifyListeners();
  }

  void setStartDate(DateTime startDate) {
    _startDate = startDate;
    notifyListeners();
  }

  void setEndDate(DateTime endDate) {
    _endDate = endDate;
    notifyListeners();
  }

  void setErrorMessage(String errorMessage) {
    _errorMessage = errorMessage;
    notifyListeners();
  }

  void clearFields() {
    _title = null;
    _description = null;
    _startDate = null;
    _endDate = null;
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> postAssigment(String courseId) async {
    if (_title == null ||
        _description == null ||
        _startDate == null ||
        _endDate == null) {
      setErrorMessage(AppErrorMessages.allFieldsRequired);
      return;
    }

    final result = await _postAssigmentUsecase.call(
      params: AssigmentEntity(
        id: '',
        courseId: courseId, // Replace with actual course ID
        title: _title!,
        description: _description!,
        startTime: _startDate!,
        endTime: _endDate!,
      ),
    );

    result.fold(
      (failure) {
        setErrorMessage("Failed to post assigment: ${failure.message}");
      },
      (success) {
        clearFields();
      },
    );
  }
}
