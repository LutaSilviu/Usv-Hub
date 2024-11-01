import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/chat/domain/entities/user.dart';
import 'package:usv_hub/features/login/presentation/providers/user_provider.dart';

class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage({super.key});

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Data'),
      ),
      body: Background(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Consumer<UserProvider>(
              builder: (BuildContext context, value, Widget? child) {
                UserEntity user = value.getUser;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      AppTextConst.personalDataDescriprion,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "${AppTextConst.userName}:",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          user.name,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "${AppTextConst.fatherName}:",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          user.fatherName,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "${AppTextConst.motherName}:",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          user.motherName,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "${AppTextConst.phoneNumber}:",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          user.phoneNumber.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "${AppTextConst.emailAdress}:",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          user.email,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
