import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/core/utils/custom_snackbar.dart';
import 'package:usv_hub/features/assigments/domain/entities/submision_entity.dart';
import 'package:usv_hub/features/assigments/domain/usecases/post_subbmision_usecase.dart';

@injectable
class PickedFilesProvider extends ChangeNotifier {
  final PostSubbmisionUsecase _postSubbmisionUsecase;
  PickedFilesProvider(this._postSubbmisionUsecase);

  final List<FilePickerResult> _pickedFiles = [];

  List<FilePickerResult> get pickedFiles => _pickedFiles;

  Future<void> pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    if (result != null) {
      _pickedFiles.add(result);
      notifyListeners();
    } else {
      if (context.mounted) CustomSnackbar.show(context, "No file selected");
    }
  }

  Future<void> uploadFiles(BuildContext context, String assigmentId) async {
    // Pick a file

    if (_pickedFiles.isNotEmpty) {
      for (final result in _pickedFiles) {
        // Get the file
        File file = File(result.files.single.path!);

        // Define the storage reference (where the file will be saved)
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref =
            storage.ref().child('uploads/${result.files.single.name}');

        // Upload the file
        try {
          await ref.putFile(file);

          // Get the download URL
          String downloadURL = await ref.getDownloadURL();
          if (context.mounted) {
            CustomSnackbar.show(context, "File uploaded successfully!");
          }
          SubmisionEntity entity = SubmisionEntity(
            "",
            assigmentId,
            "",
            downloadURL,
            DateTime.now(),
          );
          _postSubbmisionUsecase.call(params: entity);
        } on FirebaseException catch (e) {
          if (context.mounted) CustomSnackbar.show(context, e.message!);
        } catch (e) {
          if (context.mounted) CustomSnackbar.show(context, "Unexpected error");
        }
      }
    } else {
      if (context.mounted) CustomSnackbar.show(context, "No file selected");
    }
  }

  void removeFile(FilePickerResult file) {
    _pickedFiles.remove(file);
    notifyListeners();
  }
}
