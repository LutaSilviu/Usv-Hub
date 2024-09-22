import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';

class ChatHomePage extends StatelessWidget {
  const ChatHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTextConst.chat),
        leading: IconButton(
          style: Theme.of(context).iconButtonTheme.style!.copyWith(
                backgroundColor: WidgetStateProperty.all<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
        actions: [
          IconButton(
            style: Theme.of(context).iconButtonTheme.style!.copyWith(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            style: Theme.of(context).iconButtonTheme.style!.copyWith(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRouteConst.addChat);
        },
        child: const Icon(Icons.add),
      ),
      body: Background(
        child: ListView.builder(
            padding: EdgeInsets.all(8.h),
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                titleTextStyle: Theme.of(context).textTheme.bodyLarge,
                subtitleTextStyle:
                    Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.grey,
                        ),
                leading: const CircleAvatar(
                  child: Icon(
                    Icons.person,
                    color: AppColors.white,
                  ),
                ),
                title: Text('Chat $index'),
                subtitle: Text('Last message'),
                trailing: Text(
                  '12:00',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRouteConst.chat);
                },
              );
            }),
      ),
    );
  }
}
