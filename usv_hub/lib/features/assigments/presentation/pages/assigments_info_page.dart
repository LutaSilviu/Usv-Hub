import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/features/assigments/domain/entities/assigment_entity.dart';
import 'package:usv_hub/features/assigments/presentation/info_provider.dart';
import 'package:usv_hub/features/assigments/presentation/providers/picked_files_provider.dart';
import 'package:usv_hub/features/grade/presentation/pages/grade_detail_page.dart';
import 'package:usv_hub/features/login/presentation/widgets/custom_elevated_button.dart';
import 'package:usv_hub/injection.dart';

class AssigmentInfoPage extends StatelessWidget {
  const AssigmentInfoPage({super.key, required this.assigmentEntity});
  final String title = 'Assigment Info Page';
  final AssigmentEntity assigmentEntity;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          getIt<InfoProvider>()..getHasSubbmision(assigmentEntity.id),
      child: Scaffold(
        body: Background(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
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
              SizedBox(height: 40.h),
              Expanded(
                child: SingleChildScrollView(
                  child: DetailWidget(
                    title: assigmentEntity.description,
                  ),
                ),
              ),
              Consumer<PickedFilesProvider>(
                builder: (BuildContext context, PickedFilesProvider value,
                    Widget? child) {
                  if (value.loading) {
                    return const CircularProgressIndicator();
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 900.w,
                          height: 50.h,
                          child: ListView.builder(
                            itemCount: value.pickedFiles.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 150.w,
                                height: 50.h,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                ),
                                margin: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    value.removeFile(value.pickedFiles[index]);
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          value.pickedFiles[index].names.first!,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.close,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Consumer<InfoProvider>(builder: (BuildContext context,
                            InfoProvider provider, Widget? child) {
                          if (provider.isLoading) {
                            return const CircularProgressIndicator();
                          }
                          if (!provider.hasSubbmision) {
                            return Column(
                              children: [
                                CustomElevatedButton(
                                  onPressed: () {
                                    value.pickFile(context);
                                  },
                                  text: 'Add Homework',
                                  color: Theme.of(context)
                                      .colorScheme
                                      .tertiaryContainer,
                                ),
                                CustomElevatedButton(
                                  onPressed: () async {
                                    await value.uploadFiles(
                                        context, assigmentEntity.id);
                                  },
                                  text: 'Submit',
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                ),
                              ],
                            );
                          } else {
                            return const SizedBox();
                          }
                        }),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
