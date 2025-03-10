import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:usv_hub/core/utils/custom_snackbar.dart';
import 'package:usv_hub/features/assigments/domain/entities/submision_entity.dart';
import 'package:usv_hub/features/assigments/domain/usecases/post_subbmision_usecase.dart';

@injectable
class PickedFilesProvider extends ChangeNotifier {
  final PostSubbmisionUsecase _postSubbmisionUsecase;
  PickedFilesProvider(this._postSubbmisionUsecase);

  final List<FilePickerResult> _pickedFiles = [];
  bool loading = false;

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
      loading = true;
      notifyListeners();

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

          SubmisionEntity entity = SubmisionEntity(
            "",
            assigmentId,
            "",
            downloadURL,
            DateTime.now(),
          );
          _postSubbmisionUsecase.call(params: entity);

          //_pickedFiles.remove(result);
          notifyListeners();
        } on FirebaseException catch (e) {
          if (context.mounted) CustomSnackbar.show(context, e.message!);
        } catch (e) {
          if (context.mounted) CustomSnackbar.show(context, "Unexpected error");
        }
      }
      if (context.mounted) {
        CustomSnackbar.show(context, "Files uploaded successfully!");
      }
      _pickedFiles.clear();
      loading = false;
      notifyListeners();
      if (context.mounted) Navigator.pop(context);
    } else {
      if (context.mounted) CustomSnackbar.show(context, "No file selected");
    }
  }

  void removeFile(FilePickerResult file) {
    _pickedFiles.remove(file);
    notifyListeners();
  }

  // Future<void> downloadFile(String path, BuildContext context) async {
  //   final ref = FirebaseStorage.instance.ref(path);

  //   final Directory appDocDir = await getApplicationDocumentsDirectory();
  //   final String appDocPath = appDocDir.path;
  //   final File tempFile = File(appDocPath);
  //   try {
  //     await ref.writeToFile(tempFile);
  //     await tempFile.create();
  //     await OpenFile.open(tempFile.path);
  //   } on FirebaseException catch (e) {
  //     if (context.mounted) {
  //       CustomSnackbar.show(context, "Error downloading file: ${e.message}");
  //     }
  //   } catch (e) {
  //     if (context.mounted) {
  //       CustomSnackbar.show(context, "Error downloading file: $e");
  //     }
  //   }
  // }

  Future<void> downloadFile(
      String firebaseFilePath, String localFileName) async {
    try {
      // Reference to the file in Firebase Storage
      loading = true;
      notifyListeners();
      final ref = FirebaseStorage.instance.ref(firebaseFilePath);

      // Get the device's temporary directory
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = '${tempDir.path}/$localFileName';

      // Create the local file
      File file = File(tempPath);

      // Download the file to the local file path
      await ref.writeToFile(file);

      loading = false;
      notifyListeners();
    } catch (e) {
      // e.g, e.code == 'canceled'
    }
  }
}
