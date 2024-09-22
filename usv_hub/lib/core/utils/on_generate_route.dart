import 'package:flutter/material.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/assigments/presentation/pages/assigments_home_page.dart';
import 'package:usv_hub/features/assigments/presentation/pages/assigments_info_page.dart';
import 'package:usv_hub/features/attendance/presentation/pages/attendance_details_page.dart';
import 'package:usv_hub/features/attendance/presentation/pages/home_attendance_page.dart';
import 'package:usv_hub/features/chat/presentation/pages/add_chat_page.dart';
import 'package:usv_hub/features/chat/presentation/pages/chat_page.dart';
import 'package:usv_hub/features/events/presentation/pages/events_home_page.dart';
import 'package:usv_hub/features/grade/presentation/pages/grade_detail_page.dart';
import 'package:usv_hub/features/grade/presentation/pages/home_grade_page.dart';
import 'package:usv_hub/features/home/presentation/pages/home_page.dart';
import 'package:usv_hub/features/login/presentation/pages/login_page.dart';
import 'package:usv_hub/features/schedule/presentation/pages/schedule_home_page.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteConst.login:
        return routeBuilder(const LoginPage());
      case AppRouteConst.home:
        return routeBuilder(const HomePage());
      case AppRouteConst.grades:
        return routeBuilder(const HomeGradePage());
      case AppRouteConst.gradeDetailPage:
        return routeBuilder(const GradeDetailPage());
      case AppRouteConst.attendance:
        return routeBuilder(const HomeAttendancePage());
      case AppRouteConst.attendanceDetailPage:
        return routeBuilder(const AttendanceDetailsPage());
      case AppRouteConst.schedule:
        return routeBuilder(const ScheduleHomePage());
      case AppRouteConst.assignments:
        return routeBuilder(const AssigmentsHomePage());
      case AppRouteConst.assigmentInfoPage:
        return routeBuilder(const AssigmentInfoPage());
      case AppRouteConst.chat:
        return routeBuilder(const ChatPage());
      case AppRouteConst.addChat:
        return routeBuilder(const AddChatPage());
      case AppRouteConst.eventsHomePage:
        return routeBuilder(const EventsHomePage());
      default:
        return routeBuilder(const LoginPage());
    }
  }
}

dynamic routeBuilder(Widget page) {
  return MaterialPageRoute(builder: (_) => page);
}
