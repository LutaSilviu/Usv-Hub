import 'package:flutter/material.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/assigments/domain/entities/assigment_entity.dart';
import 'package:usv_hub/features/assigments/presentation/pages/assigments_home_page.dart';
import 'package:usv_hub/features/assigments/presentation/pages/assigments_info_page.dart';
import 'package:usv_hub/features/attendance/domain/entities/attendance_entity.dart';
import 'package:usv_hub/features/attendance/presentation/pages/attendance_details_page.dart';
import 'package:usv_hub/features/attendance/presentation/pages/home_attendance_page.dart';
import 'package:usv_hub/features/chat/domain/entities/contact_entity.dart';
import 'package:usv_hub/features/chat/presentation/pages/add_chat_page.dart';
import 'package:usv_hub/features/chat/presentation/pages/chat_page.dart';
import 'package:usv_hub/features/events/presentation/pages/events_home_page.dart';
import 'package:usv_hub/features/grade/domain/entities/course_entity.dart';
import 'package:usv_hub/features/grade/domain/entities/grade_entity.dart';
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
        if (settings.arguments != null) {
          Map arg = settings.arguments as Map;
          GradeEntity grade = arg[AppArguments.gradeEntity];
          CourseEntity course = arg[AppArguments.courseEntity];
          return routeBuilder(GradeDetailPage(
            grade: grade,
            course: course,
          ));
        } else {
          return routeBuilder(const ErrorPage());
        }
      case AppRouteConst.attendance:
        return routeBuilder(const HomeAttendancePage());
      case AppRouteConst.attendanceDetailPage:
        if (settings.arguments != null) {
          Map arg = settings.arguments as Map;
          AttendanceEntity attendanceEntity =
              arg[AppArguments.attendanceEntity];
          CourseEntity course = arg[AppArguments.courseEntity];
          return routeBuilder(AttendanceDetailsPage(
            attendanceEntity: attendanceEntity,
            course: course,
          ));
        } else {
          return routeBuilder(const ErrorPage());
        }

      case AppRouteConst.schedule:
        return routeBuilder(const ScheduleHomePage());
      case AppRouteConst.assignments:
        return routeBuilder(const AssigmentsHomePage());
      case AppRouteConst.assigmentInfoPage:
        if (settings.arguments != null) {
          AssigmentEntity asssigmentEntity =
              settings.arguments as AssigmentEntity;

          return routeBuilder(AssigmentInfoPage(
            assigmentEntity: asssigmentEntity,
          ));
        } else {
          return routeBuilder(const ErrorPage());
        }

      case AppRouteConst.chat:
        if (settings.arguments != null) {
          final ContactEntity contact = settings.arguments! as ContactEntity;
          return routeBuilder(ChatPage(
            contact: contact,
          ));
        } else {
          return routeBuilder(const ErrorPage());
        }

      case AppRouteConst.addChat:
        if (settings.arguments != null) {
          final List<String> contact = settings.arguments! as List<String>;
          return routeBuilder(AddChatPage(
            contact: contact,
          ));
        } else {
          return routeBuilder(const ErrorPage());
        }

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

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(AppErrorMessages.noCoursesFound),
      ),
    );
  }
}
