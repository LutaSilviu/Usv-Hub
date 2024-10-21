import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/assigments/domain/entities/assigment_entity.dart';
import 'package:usv_hub/features/assigments/presentation/cubit/assigments_cubit.dart';
import 'package:usv_hub/features/attendance/presentation/widgets/custom_search_field.dart';
import 'package:usv_hub/features/grade/domain/entities/course_entity.dart';
import 'package:usv_hub/injection.dart';

class AssigmentsHomePage extends StatefulWidget {
  const AssigmentsHomePage({super.key});

  @override
  State<AssigmentsHomePage> createState() => _AssigmentsHomePageState();
}

class _AssigmentsHomePageState extends State<AssigmentsHomePage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AssigmentsCubit>()..getAssigments(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Assignments'),
        ),
        body: Background(
          child: Center(
            child: BlocBuilder<AssigmentsCubit, AssigmentsState>(
              builder: (context, state) {
                if (state is AssigmentsLoading) {
                  return CircularProgressIndicator();
                }
                if (state is AssigmentsError) {
                  return Text(state.message);
                }
                if (state is AssigmentsLoaded) {
                  return Column(
                    children: [
                      CustomSearchField(searchController: searchController),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.assigments.length,
                          itemBuilder: (context, index) {
                            return AssigmentsWidget(
                              assigmentEntity:
                                  state.assigments.keys.elementAt(index),
                              course: state.assigments.values.elementAt(index),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class AssigmentsWidget extends StatelessWidget {
  const AssigmentsWidget({
    required this.assigmentEntity,
    required this.course,
    super.key,
  });
  final AssigmentEntity assigmentEntity;
  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.h),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRouteConst.assigmentInfoPage,
            arguments: assigmentEntity,
          );
        },
        child: Container(
          height: 100.h,
          width: 400.w,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) => Row(
              children: [
                Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth * 0.35,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Image.asset(
                    AppImages.image1,
                    scale: 1.25.w,
                  ),
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.05,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        assigmentEntity.title,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        course.title,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
