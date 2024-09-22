import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/attendance/presentation/widgets/custom_search_field.dart';

class AssigmentsHomePage extends StatefulWidget {
  const AssigmentsHomePage({super.key});

  @override
  State<AssigmentsHomePage> createState() => _AssigmentsHomePageState();
}

class _AssigmentsHomePageState extends State<AssigmentsHomePage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignments'),
      ),
      body: Background(
        child: Center(
          child: Column(
            children: [
              CustomSearchField(searchController: searchController),
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Courses',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return AssigmentsWidget(index: index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AssigmentsWidget extends StatelessWidget {
  const AssigmentsWidget({
    required this.index,
    super.key,
  });

  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.h),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRouteConst.assigmentInfoPage);
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
                    borderRadius: BorderRadius.all(
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("title"),
                    Text(index.toString()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
