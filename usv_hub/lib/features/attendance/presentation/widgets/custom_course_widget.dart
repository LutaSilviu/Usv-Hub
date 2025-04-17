import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCourseWidget extends StatelessWidget {
  const CustomCourseWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.image,
  });
  final void Function()? onTap;
  final String title;
  final String image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        child: Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      width: double.infinity,
                      height: constraints.maxHeight * 0.55,
                      child: Image.asset(
                        image,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
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
