import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:usv_hub/core/utils/consts.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  final String title;
  final IconData? icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(160.w, 160.h),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
      onPressed: onPressed,
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.white,
            size: 50.sp,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16.sp,
              color: Theme.of(context).textTheme.titleSmall!.color,
            ),
          ),
        ],
      ),
    );
  }
}
