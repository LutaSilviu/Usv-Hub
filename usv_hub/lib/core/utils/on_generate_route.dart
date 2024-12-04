import 'package:flutter/material.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/assigments/domain/entities/assigment_entity.dart';
import 'package:usv_hub/features/assigments/presentation/pages/assigments_home_page.dart';
import 'package:usv_hub/features/assigments/presentation/pages/assigments_info_page.dart';
import 'package:usv_hub/features/assigments/presentation/pages/view_submissions_page.dart';
import 'package:usv_hub/features/attendance/presentation/pages/add_attendance_page.dart';
import 'package:usv_hub/features/attendance/presentation/pages/attendance_details_page.dart';
import 'package:usv_hub/features/chat/domain/entities/contact_entity.dart';
import 'package:usv_hub/features/chat/presentation/pages/add_chat_page.dart';
import 'package:usv_hub/features/chat/presentation/pages/chat_page.dart';
import 'package:usv_hub/features/adresses/presentation/pages/adresses_page.dart';
import 'package:usv_hub/features/events/presentation/pages/events_home_page.dart';
import 'package:usv_hub/features/select_course/domain/entities/course_entity.dart';
import 'package:usv_hub/features/grade/presentation/pages/add_grade_page.dart';
import 'package:usv_hub/features/grade/presentation/pages/grade_detail_page.dart';
import 'package:usv_hub/features/grade/presentation/pages/view_students.dart';
import 'package:usv_hub/features/home/presentation/pages/home_page.dart';
import 'package:usv_hub/features/login/presentation/pages/login_page.dart';
import 'package:usv_hub/features/personal_data/presentation/pages/personal_data_page.dart';
import 'package:usv_hub/features/schedule/presentation/pages/schedule_home_page.dart';
import 'package:usv_hub/features/select_course/presentation/pages/select_course_page.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteConst.login:
        return routeBuilder(const LoginPage());
      case AppRouteConst.adresses:
        return routeBuilder(const AdressesPage());
      case AppRouteConst.personalData:
        return routeBuilder(const PersonalDataPage());
      case AppRouteConst.home:
        if (settings.arguments != null) {
          final arg = settings.arguments as Map;

          return routeBuilder(HomePage(
            courseEntity: arg[AppArguments.courseEntity],
            isTeacher: arg[AppArguments.isTeacher],
          ));
        } else {
          return routeBuilder(const ErrorPage());
        }

      // case AppRouteConst.grades:
      //   return routeBuilder(const HomeGradePage());
      case AppRouteConst.gradeDetailPage:
        if (settings.arguments != null) {
          Map arg = settings.arguments as Map;
          CourseEntity course = arg[AppArguments.courseEntity];
          return routeBuilder(GradeDetailPage(
            course: course,
          ));
        } else {
          return routeBuilder(const ErrorPage());
        }
      case AppRouteConst.addGrade:
        if (settings.arguments != null) {
          Map arg = settings.arguments as Map;

          return routeBuilder(AddGradePage(
            isTeacher: arg[AppArguments.isTeacher],
            student: arg[AppArguments.studentEntity],
            courseId: arg[AppArguments.courseId],
          ));
        } else {
          return routeBuilder(const ErrorPage());
        }
      case AppRouteConst.addAttandance:
        if (settings.arguments != null) {
          Map arg = settings.arguments as Map;

          return routeBuilder(AddAttandancePage(
            isTeacher: arg[AppArguments.isTeacher],
            student: arg[AppArguments.studentEntity],
            courseId: arg[AppArguments.courseId],
            courseLenght: arg[AppArguments.courseLenght],
          ));
        } else {
          return routeBuilder(const ErrorPage());
        }
      case AppRouteConst.viewStudents:
        if (settings.arguments != null) {
          Map arg = settings.arguments as Map;
          return routeBuilder(
            ViewStudents(
              courseId: arg[AppArguments.courseId],
              isTeacher: arg[AppArguments.isTeacher],
              clickType: arg[AppArguments.clickType],
              courseLenght: arg[AppArguments.courseLenght],
            ),
          );
        } else {
          return routeBuilder(const ErrorPage());
        }
      case AppRouteConst.attendanceDetailPage:
        if (settings.arguments != null) {
          Map arg = settings.arguments as Map;

          CourseEntity course = arg[AppArguments.courseEntity];
          return routeBuilder(AttendanceDetailsPage(
            course: course,
          ));
        } else {
          return routeBuilder(const ErrorPage());
        }

      case AppRouteConst.schedule:
        return routeBuilder(const ScheduleHomePage());
      case AppRouteConst.assignments:
        if (settings.arguments != null) {
          Map arg = settings.arguments as Map;

          CourseEntity courseEntity = arg[AppArguments.courseEntity];
          ProfesorType isTeacher = arg[AppArguments.isTeacher];
          return routeBuilder(AssigmentsHomePage(
            courseEntity: courseEntity,
            isTeacher: isTeacher,
          ));
        } else {
          return routeBuilder(const ErrorPage());
        }
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
      case AppRouteConst.coursesPage:
        return routeBuilder(const SelectCoursePage());

      case AppRouteConst.addChat:
        if (settings.arguments != null) {
          final List<String> contact = settings.arguments! as List<String>;
          return routeBuilder(AddChatPage(
            contact: contact,
          ));
        } else {
          return routeBuilder(const ErrorPage());
        }
      case AppRouteConst.viewSubmissions:
        if (settings.arguments != null) {
          final Map arg = settings.arguments! as Map;
          return routeBuilder(ViewSubmissionPage(
            assigmentId: arg[AppArguments.assigmentId],
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
    return const Scaffold(
      body: Center(
        child: Text(AppErrorMessages.noCoursesFound),
      ),
    );
  }
}
