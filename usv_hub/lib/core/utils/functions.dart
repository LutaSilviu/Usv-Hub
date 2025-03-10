import 'package:permission_handler/permission_handler.dart';
import 'package:usv_hub/core/utils/consts.dart';

String dayFromInt(int date) {
  switch (date) {
    case 1:
      return DaysOfWeek.luni;
    case 2:
      return DaysOfWeek.marti;
    case 3:
      return DaysOfWeek.miercuri;
    case 4:
      return DaysOfWeek.joi;
    case 5:
      return DaysOfWeek.vineri;
    case 6:
      return DaysOfWeek.sambata;
    case 7:
      return DaysOfWeek.duminica;
    default:
      return '';
  }
}

Future<void> requestStoragePermission() async {
  // Check if storage permission is granted
  var status = await Permission.storage.status;

  // If permission is denied, request it
  if (status.isDenied) {
    // Request permission
    status = await Permission.storage.request();
  } else if (status.isPermanentlyDenied) {
    // Handle the case where permission is permanently denied
    // and the user needs to go to settings
    openAppSettings();
  } else {}
}
