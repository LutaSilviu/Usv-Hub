import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/core/utils/custom_snackbar.dart';
import 'package:usv_hub/features/login/presentation/cubit/login_cubit.dart';

import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              CustomSnackbar.show(context, state.error);
            }
          },
          builder: (context, state) {
            if (state is LoginLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                SizedBox(
                  height: 141.h,
                ),
                Center(
                  child: Text(
                    AppTextConst.login,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SizedBox(
                  height: 210.h,
                ),
                Column(
                  children: [
                    CustomTextField(
                      hintText: AppTextConst.email,
                      controller: emailController,
                    ),
                    CustomTextField(
                      hintText: AppTextConst.password,
                      controller: passwordController,
                      isPassword: true,
                    ),
                    // TextButton(
                    //   onPressed: () {
                    //     //TODO: add onPressed from bloc
                    //   },
                    //   child: Text(
                    //     AppTextConst.forgotPassword,
                    //     style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    //           color: AppColors.grey,
                    //         ),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: 100.h),
                CustomElevatedButton(
                    onPressed: () {
                      context.read<LoginCubit>().login(
                          email: emailController.text,
                          password: passwordController.text,
                          context: context);
                    },
                    text: AppTextConst.login),
              ],
            );
          },
        ),
      ),
    );
  }
}
