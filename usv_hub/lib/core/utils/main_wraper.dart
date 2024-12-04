import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/core/utils/test.dart';
import 'package:usv_hub/features/chat/presentation/pages/chat_home_page.dart';
import 'package:usv_hub/features/events/presentation/pages/events_home_page.dart';
import 'package:usv_hub/features/home/presentation/cubit/nav_bar_cubit/nav_bar_cubit.dart';
import 'package:usv_hub/features/login/presentation/cubit/login_cubit.dart';
import 'package:usv_hub/features/login/presentation/providers/user_provider.dart';
import 'package:usv_hub/features/select_course/presentation/pages/select_course_page.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        if (mounted) context.read<UserProvider>().fetchUserEntity();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, NavBarState>(
      builder: (context, state) {
        return Scaffold(
          drawer: const CustomDrawer(),
          bottomNavigationBar: GNav(
            selectedIndex: state.index,
            padding: const EdgeInsets.all(20),
            activeColor: Theme.of(context).colorScheme.onSecondary,
            backgroundColor: Theme.of(context).colorScheme.primary,
            gap: 8,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.chat,
                text: 'Chat',
              ),
              GButton(
                icon: Icons.calendar_month,
                text: 'Events',
              ),
              GButton(
                icon: Icons.map_outlined,
                text: 'Campus Map',
              ),
            ],
            onTabChange: (index) {
              context.read<NavBarCubit>().changeIndex(index);
            },
          ),
          body: switch (state.index) {
            0 => const Center(
                child: SelectCoursePage(),
              ),
            1 => const Center(
                child: ChatHomePage(),
              ),
            2 => const Center(
                child: EventsHomePage(),
              ),
            3 => const CampusImage(),
            _ => Container(),
          },
        );
      },
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Consumer<UserProvider>(
        builder: (BuildContext context, UserProvider provider, Widget? child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (provider.user == null) {
            return Column(
              children: [
                const Center(
                  child: Text('No user found'),
                ),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return DrawerItem(
                      text: AppTextConst.logout,
                      icon: Icons.logout,
                      onTap: () {
                        context.read<LoginCubit>().logout();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRouteConst.login,
                          (route) => false,
                        );
                      },
                    );
                  },
                ),
              ],
            );
          }
          return ListView(
            children: [
              Container(
                padding: EdgeInsets.all(20.h),
                child: Row(
                  children: [
                    // CircleAvatar(
                    //   radius: 30.r,
                    //   backgroundImage:
                    //       const AssetImage('assets/images/usv.png'),
                    // ),
                    Icon(
                      Icons.person,
                      size: 50.sp,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.user!.name,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20.sp,
                          ),
                        ),
                        Text(
                          provider.user!.email,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.primaryFixed,
                endIndent: 10.w,
                indent: 10.w,
              ),
              DrawerItem(
                text: AppTextConst.personalData,
                icon: Icons.person,
                onTap: () {
                  Navigator.pushNamed(context, AppRouteConst.personalData);
                },
              ),
              DrawerItem(
                text: AppTextConst.addresses,
                icon: Icons.location_on,
                onTap: () {
                  Navigator.pushNamed(context, AppRouteConst.adresses);
                },
              ),
              const DrawerItem(
                text: AppTextConst.emailAdress,
                icon: Icons.email,
              ),
              const DrawerItem(
                text: AppTextConst.phoneNumber,
                icon: Icons.phone,
              ),
              const DrawerItem(
                text: AppTextConst.languages,
                icon: Icons.language,
              ),
              const DrawerItem(
                text: AppTextConst.licenses,
                icon: FontAwesomeIcons.file,
              ),
              const DrawerItem(
                text: AppTextConst.publications,
                icon: Icons.library_books,
              ),
              const DrawerItem(
                text: AppTextConst.emergencyContacts,
                icon: Icons.contact_phone,
              ),
              const DrawerItem(
                text: AppTextConst.appSettings,
                icon: Icons.settings,
              ),
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return DrawerItem(
                    text: AppTextConst.logout,
                    icon: Icons.logout,
                    onTap: () {
                      context.read<LoginCubit>().logout();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRouteConst.login,
                        (route) => false,
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });
  final String text;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              icon,
            ),
            SizedBox(
              width: 25.w,
            ),
            Text(
              text,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
