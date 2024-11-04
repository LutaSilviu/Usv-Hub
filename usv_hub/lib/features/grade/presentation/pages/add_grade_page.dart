import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/chat/domain/entities/user.dart';
import 'package:usv_hub/features/grade/presentation/cubit/add_grade/add_grade_cubit.dart';

import 'package:usv_hub/features/grade/presentation/pages/grade_detail_page.dart';
import 'package:usv_hub/features/login/presentation/widgets/custom_elevated_button.dart';
import 'package:usv_hub/features/login/presentation/widgets/custom_text_field.dart';

class AddGradePage extends StatefulWidget {
  const AddGradePage({
    required this.student,
    required this.isTeacher,
    required this.courseId,
    super.key,
  });

  final UserEntity student;
  final bool isTeacher;
  final String courseId;

  @override
  State<AddGradePage> createState() => _AddGradePageState();
}

class _AddGradePageState extends State<AddGradePage> {
  final String title = AppTextConst.addGradePage;
  final TextEditingController labController = TextEditingController();
  final TextEditingController courseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: FutureBuilder(
          future: Provider.of<AddGradeCubit>(context, listen: false)
              .getGrade(widget.student.id, widget.courseId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 40.h,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                ),
                SizedBox(height: 68.h),
                DetailWidget(
                    title: "Student name: ${widget.student.name}",
                    height: 30.h),
                DetailWidget(
                    title: "Student email: ${widget.student.email}",
                    height: 30.h),
                DetailWidget(
                    title:
                        "Student phone number: ${widget.student.phoneNumber}",
                    height: 30.h),
                BlocConsumer<AddGradeCubit, AddGradeState>(
                    listener: (context, state) {
                  if (state is ErrorState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  }
                }, builder: (context, state) {
                  if (state is LoadingState) {
                    return const CircularProgressIndicator();
                  }
                  if (state is GradeLoaded) {
                    if (state.grade != null && state.grade!.labGrade != null) {
                      labController.text = state.grade!.labGrade.toString();
                    }
                    if (state.grade != null &&
                        state.grade!.courseGrade != null) {
                      courseController.text =
                          state.grade!.courseGrade.toString();
                    }

                    return Column(
                      children: [
                        if (!widget.isTeacher)
                          EnterGradeWidget(
                            labController: labController,
                            title: AppTextConst.labGrade,
                          ),
                        if (widget.isTeacher)
                          EnterGradeWidget(
                            labController: courseController,
                            title: AppTextConst.courseGrade,
                          ),
                        Center(
                            child: CustomElevatedButton(
                                onPressed: () {
                                  String gradeId;
                                  if (state.grade == null) {
                                    gradeId = "";
                                  } else {
                                    gradeId = state.grade!.id;
                                  }
                                  Provider.of<AddGradeCubit>(context,
                                          listen: false)
                                      .addGrade(
                                    widget.student.id,
                                    widget.courseId,
                                    double.tryParse(labController.text),
                                    double.tryParse(courseController.text),
                                    context,
                                    gradeId,
                                  );
                                },
                                text: AppTextConst.add)),
                      ],
                    );
                  }
                  return const SizedBox();
                }),
                SizedBox(
                  height: 30.h,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class EnterGradeWidget extends StatelessWidget {
  const EnterGradeWidget({
    super.key,
    required this.labController,
    required this.title,
  });

  final TextEditingController labController;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.surface,
                ),
          ),
          CustomTextField(
            hintText: "Course grade",
            controller: labController,
            keyboardType: TextInputType.number,
          )
        ],
      ),
    );
  }
}
