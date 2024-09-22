import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/core/utils/test.dart';
import 'package:usv_hub/features/chat/presentation/pages/chat_home_page.dart';
import 'package:usv_hub/features/events/presentation/pages/events_home_page.dart';
import 'package:usv_hub/features/home/presentation/cubit/nav_bar_cubit/nav_bar_cubit.dart';
import 'package:usv_hub/features/home/presentation/pages/home_page.dart';

class MainWrapper extends StatelessWidget {
  const MainWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const Center(
        child: HomePage(),
      ),
      const Center(
        child: ChatHomePage(),
      ),
      const Center(
        child: EventsHomePage(),
      ),
      Test(),
    ];
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
                icon: Icons.school,
                text: 'Grade',
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
          body: screens[state.index],
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
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20.h),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundImage: const AssetImage('assets/images/usv.png'),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Name',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20.sp,
                      ),
                    ),
                    Text(
                      'User email',
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
          const DrawerItem(
            text: AppTextConst.personalData,
            icon: Icons.person,
          ),
          const DrawerItem(
            text: AppTextConst.addresses,
            icon: Icons.location_on,
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
          const DrawerItem(
            text: AppTextConst.logout,
            icon: Icons.logout,
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.text,
    required this.icon,
  });
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
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
    );
  }
}
