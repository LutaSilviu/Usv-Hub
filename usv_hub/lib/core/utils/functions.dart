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
