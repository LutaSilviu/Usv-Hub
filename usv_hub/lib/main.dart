import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:usv_hub/core/utils/main_wraper.dart';
import 'package:usv_hub/core/utils/on_generate_route.dart';
import 'package:usv_hub/core/utils/theme.dart';
import 'package:usv_hub/features/adresses/presentation/cubit/adresses_cubit.dart';
import 'package:usv_hub/features/assigments/presentation/providers/picked_files_provider.dart';

import 'package:usv_hub/features/chat/presentation/cubit/messages/messages_cubit.dart';
import 'package:usv_hub/features/chat/presentation/cubit/potential_contacts/potential_contacts_cubit.dart';
import 'package:usv_hub/features/grade/presentation/cubit/add_grade/add_grade_cubit.dart';
import 'package:usv_hub/features/grade/presentation/cubit/grade_courses/grade_cubit.dart';
import 'package:usv_hub/features/grade/presentation/cubit/grade_students/grade_students_cubit.dart';
import 'package:usv_hub/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:usv_hub/features/home/presentation/cubit/nav_bar_cubit/nav_bar_cubit.dart';
import 'package:usv_hub/features/login/presentation/cubit/login_cubit.dart';
import 'package:usv_hub/features/login/presentation/pages/login_page.dart';
import 'package:usv_hub/features/login/presentation/providers/user_provider.dart';
import 'package:usv_hub/features/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:usv_hub/global_bloc_observer.dart';
import 'package:usv_hub/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureDependencies();
  Bloc.observer = GlobalBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginCubit>(
            lazy: false,
            create: (context) => getIt<LoginCubit>()..checkLogin(context),
          ),
          BlocProvider<NavBarCubit>(
            lazy: false,
            create: (context) => getIt<NavBarCubit>(),
          ),
          BlocProvider<HomeCubit>(
            lazy: false,
            create: (context) => getIt<HomeCubit>(),
          ),
          BlocProvider<GradeCubit>(
            create: (context) => getIt<GradeCubit>(),
          ),
          BlocProvider<ScheduleCubit>(
            create: (context) => getIt<ScheduleCubit>(),
          ),
          BlocProvider<MessagesCubit>(
            create: (context) => getIt<MessagesCubit>(),
          ),
          BlocProvider<PotentialContactsCubit>(
            create: (context) => getIt<PotentialContactsCubit>(),
          ),
          BlocProvider<AddressesCubit>(
            create: (context) => getIt<AddressesCubit>(),
          ),
          BlocProvider<GradeStudentsCubit>(
            create: (context) => getIt<GradeStudentsCubit>(),
          ),
          ChangeNotifierProvider(
            create: (context) => getIt<UserProvider>(),
          ),
          BlocProvider<AddGradeCubit>(
            create: (context) => getIt<AddGradeCubit>(),
          ),
          ChangeNotifierProvider(
            create: (context) => getIt<PickedFilesProvider>(),
          ),
        ],
        child: SafeArea(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            onGenerateRoute: OnGenerateRoute.route,
            title: 'Flutter Demo',
            theme: darkTheme(),
            routes: {
              '/': (context) {
                return BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is LoginInitial) {
                      return const LoginPage();
                    } else if (state is LoginSuccess) {
                      return const MainWrapper();
                    } else {
                      return const LoginPage();
                    }
                  },
                );
              },
            },
          ),
        ),
      ),
    );
  }
}

//flutter pub get
//flutter pub run build_runner watch --delete-conflicting-outputs
