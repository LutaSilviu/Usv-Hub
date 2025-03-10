// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:usv_hub/core/utils/consts.dart';

// class CustomSearchField extends StatelessWidget {
//   const CustomSearchField({
//     super.key,
//     required this.searchController,
//   });

//   final TextEditingController searchController;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
//       child: TextField(
//         controller: searchController,
//         decoration: InputDecoration(
//           filled: true,
//           prefixIconColor: Theme.of(context).colorScheme.primaryFixed,
//           fillColor: Theme.of(context).colorScheme.primaryContainer,
//           hintText: AppTextConst.search,
//           prefixIcon: const Icon(Icons.search),
//           hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                 color: Theme.of(context).colorScheme.primaryFixed,
//               ),
//           border: OutlineInputBorder(
//             borderSide: BorderSide.none,
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       ),
//     );
//   }
// }
