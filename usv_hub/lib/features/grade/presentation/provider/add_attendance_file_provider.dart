import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:usv_hub/features/attendance/domain/entities/attendance_entity.dart';
import 'package:usv_hub/features/attendance/domain/usecases/add_attandance.dart';
import 'package:usv_hub/features/attendance/domain/usecases/get_attendance_for_student.dart';
import 'package:usv_hub/features/attendance/domain/usecases/get_student_by_name.dart';
import 'package:usv_hub/features/grade/domain/usecases/get_student_grade.dart';
import 'package:http/http.dart' as http;

@injectable
class AddAttendanceFileProvider extends ChangeNotifier {
  File? file;
  AddAttandance addAttandance;
  bool isLoading = false;
  String? _errorMessage;
  GetStudentByName getStudentAfterName;
  GetAttendanceForStudent getAttendanceForStudent;
  File? _image;
  int _selectedIndex = 1;

  int get selectedIndex => _selectedIndex;

  String? _extractedText;
  String? get extractedText => _extractedText;
  String? get errorMessage => _errorMessage;

  final String _endpoint = dotenv.env['AZURE_ENDPOINT'] ?? '';
  final String _subscriptionKey = dotenv.env['AZURE_KEY'] ?? '';
  final String _modelId = dotenv.env['AZURE_MODEL_ID'] ?? '';
  final ImagePicker _picker = ImagePicker();
  AddAttendanceFileProvider(this.addAttandance, this.getStudentAfterName,
      this.getAttendanceForStudent);

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv', 'xlsx'],
    );

    if (result != null) {
      file = File(result.files.single.path!);
    }
  }

  Future<List<List<dynamic>>> readExcel(File file) async {
    var bytes = file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    List<List<dynamic>> data = [];
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        data.add(row.map((cell) => cell?.value).toList());
      }
    }
    return data;
  }

  Future<bool> processExcel(File file, String courseId, bool courseList) async {
    isLoading = true;
    List<List<dynamic>> data = await readExcel(file);
    for (var i = 1; i < data.length; i++) {
      await proccesStudentNames(data, i, courseId, courseList);
    }
    isLoading = false;
    return true;
  }

  Future<void> proccesStudentNames(
      List<List<dynamic>> data, int i, String courseId, bool courseList) async {
    (await getStudentAfterName.call(
      params: data[i][0].toString(),
    ))
        .fold(
      (l) {
        isLoading = false;
        return false;
      },
      (student) async {
        (await getAttendanceForStudent.call(
                params: GetStudentsParams(student.id, courseId)))
            .fold(
          (l) {
            isLoading = false;
            return false;
          },
          (attendance) async {
            Map<String, bool> attendanceMap = courseList
                ? attendance.courseAttendance
                : attendance.labortoryAttendance;
            for (int j = 1; j < data[i].length; j++) {
              var element = data[i][j];
              if (element.toString() == "P") {
                attendanceMap.update(j.toString(), (value) => true,
                    ifAbsent: () => true);
              } else if (element.toString() == "A") {
                attendanceMap.update(j.toString(), (value) => false,
                    ifAbsent: () => false);
              }
            }
            (await addAttandance.call(
              params: AttendanceEntity(
                id: attendance.id,
                courseId: courseId,
                studentId: student.id,
                courseAttendance:
                    courseList ? attendanceMap : attendance.courseAttendance,
                labortoryAttendance:
                    courseList ? attendance.labortoryAttendance : attendanceMap,
              ),
            ))
                .fold(
              (l) {
                isLoading = false;
                return false;
              },
              (r) {
                isLoading = false;
                return true;
              },
            );
          },
        );
      },
    );
  }

  Future<void> proccesStudentName(
      String name, String courseId, bool courseList) async {
    (await getStudentAfterName.call(
      params: name,
    ))
        .fold(
      (l) {
        isLoading = false;
        return false;
      },
      (student) async {
        (await getAttendanceForStudent.call(
                params: GetStudentsParams(student.id, courseId)))
            .fold(
          (l) {
            isLoading = false;
            return false;
          },
          (attendance) async {
            Map<String, bool> attendanceMap = courseList
                ? attendance.courseAttendance
                : attendance.labortoryAttendance;
            attendanceMap.update(
              _selectedIndex.toString(),
              (value) => true,
              ifAbsent: () => true,
            );
            (await addAttandance.call(
              params: AttendanceEntity(
                id: attendance.id,
                courseId: courseId,
                studentId: student.id,
                courseAttendance:
                    courseList ? attendanceMap : attendance.courseAttendance,
                labortoryAttendance:
                    courseList ? attendance.labortoryAttendance : attendanceMap,
              ),
            ))
                .fold(
              (l) {
                isLoading = false;
                return false;
              },
              (r) {
                isLoading = false;
                return true;
              },
            );
          },
        );
      },
    );
  }

  Future<void> pickImage(
      ImageSource source, String courseId, bool courseList) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _extractedText = ''; // Clear previous text

        await analyzeDocument(_image!, courseId, courseList);
        // log('GALERIE ${_extractedText}');
        notifyListeners();
      }
    } catch (e) {
      log('ERROR: $e');
    }
  }

  // Future<void> _recognizeText() async {
  //   if (_image == null) return;

  //   final textRecognizer = TextRecognizer();
  //   final inputImage = InputImage.fromFile(_image!);
  //   final RecognizedText recognizedText =
  //       await textRecognizer.processImage(inputImage);

  //   _extractedText = recognizedText.text;
  //   textRecognizer.close();
  // }

  Future<void> analyzeDocument(
      File file, String courseId, bool courseList) async {
    isLoading = true;

    notifyListeners();
    try {
      final url = Uri.parse(
          "$_endpoint/documentintelligence/documentModels/$_modelId:analyze?api-version=2024-11-30");

      final bytes = await file.readAsBytes();

      final response = await http.post(
        url,
        headers: {
          "Ocp-Apim-Subscription-Key": _subscriptionKey,
          "Content-Type": "application/octet-stream",
        },
        body: bytes,
      );

      if (response.statusCode == 202) {
        final operationLocation = response.headers['operation-location'] ?? '';
        await fetchResult(operationLocation, courseId, courseList);
      } else {
        _errorMessage = "❌ Error: ${response.statusCode}\n${response.body}";
      }
    } catch (e) {
      _errorMessage = "❌ Exception: $e";
    } finally {
      isLoading = false;
      resetProvider();
      notifyListeners();
    }
  }

  Future<void> fetchResult(
      String operationLocation, String courseId, bool courseList) async {
    await Future.delayed(const Duration(seconds: 5));
    final response = await http.get(
      Uri.parse(operationLocation),
      headers: {"Ocp-Apim-Subscription-Key": _subscriptionKey},
    );

    if (response.statusCode == 200) {
      final jsonResult = json.decode(response.body);

      if (jsonResult["status"] == "running") {
        await fetchResult(operationLocation, courseId, courseList);
      } else {
        _extractedText = const JsonEncoder.withIndent('  ')
            .convert(jsonResult["analyzeResult"]);

        for (var document in jsonResult["analyzeResult"]['documents'][0]
            ['fields']['Names']['valueArray']) {
          // Căutăm câmpul "Nume Student" în fiecare document
          if (document['valueObject']['Nume Student']['valueString'] != null) {
            final name = document['valueObject']['Nume Student']['valueString'];

            await proccesStudentName(name, courseId, courseList);
          }
        }
        notifyListeners();
      }
    } else {
      _errorMessage =
          "❌ Error fetching result: ${response.statusCode} ${response.body}";
    }
  }

  void resetProvider() {
    _extractedText = '';
    //_errorMessage = '';
    _selectedIndex = 1;

    notifyListeners();
  }

  // Future<void> pickFileForAI() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
  //   );

  //   if (result != null && result.files.single.path != null) {
  //     final file = File(result.files.single.path!);
  //   }
  // }
}
