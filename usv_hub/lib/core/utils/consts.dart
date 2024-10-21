import 'package:flutter/material.dart';
import 'package:usv_hub/features/assigments/domain/entities/assigment_entity.dart';

class AppTextSize {
  static const double small = 12.0;
  static const double medium = 16.0;
  static const double large = 20.0;
  static const double kTextSizeUnit = 10.0;
}

class AppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color.fromARGB(255, 167, 167, 167);
  static const Color red = Colors.red;

  static const Color primary = Color(0xFF13182E);
  static const Color onPrimary = Color(0xFF2C386A);
  static const Color primaryFixed = Color(0xFF6E7079);
  static const Color secondary = Color(0xFF131C3B);
  static const Color onSecondary = Color(0xFF716EF6);
  static const Color error = Color(0xFFFB6F6F);
  static const Color onError = Color(0xFFD32F2F);
  static const Color surface = Color(0xFFD9D9D9);
  static const Color onSurface = Color(0xFFF7C417);
  static const Color onTertiaryContainer = Color(0xFF5AAC76);
  static const Color tertiaryContainer = Color(0xFFFF7753);
  static const Color primaryContainer = Color(0xFF26315E);
  static const Color secondaryContainer = Color.fromARGB(78, 255, 255, 255);
  static const Color onPrimaryContainer = Color(0xFF817DF6);

  static const Color attendancePresent = Color(0xFF5AAC76);
  static const Color attendanceAbsent = Color(0xFFFB6F6F);
  static const Color attendanceEmpty = Color(0xFFD9D9D9);
}

class AppTextConst {
  static const login = 'Login';
  static const email = 'Email';
  static const password = 'Password';
  static const forgotPassword = 'Forgot Password?';

  //main menu
  static const grade = 'Grade';
  static const attendance = 'Attendance';
  static const schedule = 'Schedule';
  static const assigments = 'Assigments';

  //pages names
  static const home = 'Home Page';

  //drawer items
  static const personalData = 'Personal Data';
  static const addresses = 'Addresses';
  static const emailAdress = 'Email Adress';
  static const phoneNumber = 'Phone Number';
  static const languages = 'Languages';
  static const licenses = 'Licenses';
  static const publications = 'Publications';
  static const emergencyContacts = 'Emergency Contacts';
  static const appSettings = 'App Settings';
  static const logout = 'Logout';
  static const settings = 'Settings';

  static const search = 'Search';

  static const chat = 'Chat';
  static const chatInfoPage = 'Chat Info Page';
  static const message = 'Message';
  static const selectCourse = 'Select Course';
  static const courses = 'Courses';
  static const gradeDetailPage = 'Grade Detail Page';
}

class AppStringFailuresMessages {
  static const String networkError = 'Network error occurred.';
  static const String serverError = 'Server error occurred.';
  static const String invalidCredentials = 'Invalid credentials.';
  static const String emailAlreadyExists = 'Email already exists.';
  static const String emailNotFound = 'Email not found.';
  static const String passwordTooShort =
      'Password should be at least 6 characters long.';
  static const String passwordMismatch = 'Passwords do not match.';
  static const String unknownError = 'An unknown error occurred.';
  static const String userNotFound = 'User not found.';
  static const String wrongPassword = 'Wrong password.';
}

//route const
class AppRouteConst {
  static const String login = '/';
  static const String home = '/home';
  static const String splash = '/splash';
  static const String register = '/register';
  static const String forgotPassword = '/forgotPassword';

  static const String grades = '/grades';
  static const String gradeDetailPage = '/gradeDetailPage';

  static const String attendance = '/attendance';
  static const String attendanceDetailPage = '/attendanceDetailPage';

  static const String schedule = '/schedule';

  static const String assignments = '/assignments';
  static const String assigmentInfoPage = '/AssigmentInfoPage';

  static const String chat = '/chat';
  static const String chatInfoPage = '/chatInfoPage';
  static const String addChat = '/addChat';

  static const String eventsHomePage = '/eventsHomePage';
}

class AppImages {
  static const String image1 = 'assets/images/1.png';
  static const String man = 'assets/images/man.png';
  static const String woman = 'assets/images/woman.png';
  static const String usv = 'assets/images/usv.png';
  static const String hartaCampus = 'assets/images/Harta Campus.png';
}

class AppErrorMessages {
  static const String noCoursesFound = "No courses found";

  static const String ups = "Ups, something went wrong";
}

class AppFields {
  //grade

  static const String id = 'id';
  static const String studentId = 'StudentId';
  static const String courseGrade = 'CourseGrade';
  static const String labGrade = 'LabGrade';
  static const String courseId = 'CourseId';
  static const String semesterId = 'SemesterId';
  static const String name = "Name";
  static const String isActive = 'IsActive';

  static const String classType = "ClassType";
  static const String dayOfWeek = "DayOfWeek";
  static const String startingHour = "StartingHour";
  static const String endingHour = "EndingHour";
  static const String numberOfCourses = "NumberOfCourses";
  static const String teacher = "Teacher";
  static const String teacherId = "TeacherId";
  static const String assistentId = "AssistentId";
  static const String courseFrequency = "CourseFreq";
  static const String semester = "Semester";
  static const String courseCredits = "CourseCredits";
  static const String schedule = "Schedule";

  //messaje
  static const String text = 'Text';
  static const String senderId = 'SenderId';
  static const String reciverId = 'ReciverId';
  static const String timeWhenSent = 'TimeWhenSent';

  //contacts
  static const String status = 'Status';
  static const String senderName = 'SenderName';
  static const String reciverName = 'ReciverName';
  static const String person1 = 'Person1';
  static const String person2 = 'Person2';

  //events
  static const String departamentId = 'DepartamentId';
  static const String title = 'Title';
  static const String startTime = 'StartTime';
  static const String endTime = 'EndTime';
  static const String classWhereHeld = 'ClassWhereHeld';
  static const String supporterName = 'SupporterName';

  static const String courseAttendance = 'CourseAttendance';
  static const String labortoryAttendance = 'LaboratoryAttendance';

  static const String description = 'Description';

  static const String contactId = 'ContactId';
}

class AppArguments {
  static const gradeEntity = "GradeEntity";
  static const courseEntity = "CourseEntity";
  static const attendanceEntity = "AttendanceEntity";
  static const contactEntity = "ContactEntity";
  static const assigmentEntity = "AssigmentEntity";
}

class AppCollections {
  static const gradeCollection = 'Grade';
  static const attendanceCollection = 'Attendance';
  static const assignmentCollection = 'Assignment';
  static const courseCollection = 'Course';
  static const semesterCollection = 'Semester';
  static const semesterXStudentCollection = 'SemesterXStudent';

  static const String teacher = 'Teacher';
  static const String student = 'Student';
  static const String message = 'Message';
  static const String contacts = 'Contacts';
  static const String events = 'Events';
}

enum ContactsStatus { active, pending, inactive }

extension ContactsStatusToString on ContactsStatus {
  String get stringValue {
    switch (this) {
      case ContactsStatus.active:
        return 'Active';
      case ContactsStatus.pending:
        return 'Pending';
      case ContactsStatus.inactive:
        return 'Inactive';

      default:
        return '';
    }
  }
}

extension StringToContactsStatus on String {
  ContactsStatus? toContactsStatus() {
    switch (toLowerCase()) {
      case 'active':
        return ContactsStatus.active;
      case 'pending':
        return ContactsStatus.pending;
      case 'inactive':
        return ContactsStatus.inactive;
      default:
        return null;
    }
  }
}

class DaysOfWeek {
  static const String luni = 'Luni';
  static const String marti = 'Marti';
  static const String miercuri = 'Miercuri';
  static const String joi = 'Joi';
  static const String vineri = 'Vineri';
  static const String sambata = 'Sambata';
  static const String duminica = 'Duminica';
}
