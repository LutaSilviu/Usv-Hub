import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/attendance/presentation/widgets/custom_course_widget.dart';
import 'package:usv_hub/features/chat/domain/entities/contact_entity.dart';
import 'package:usv_hub/features/chat/presentation/cubit/potential_contacts/potential_contacts_cubit.dart';

class AddChatPage extends StatefulWidget {
  const AddChatPage({super.key, required this.contact});
  final List<String> contact;

  @override
  State<AddChatPage> createState() => _AddChatPageState();
}

class _AddChatPageState extends State<AddChatPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context
            .read<PotentialContactsCubit>()
            .getPotentialContacts(widget.contact);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendance',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // CustomSearchField(searchController: searchController),
            SizedBox(
              height: 40.h,
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Potential contacts',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            BlocBuilder<PotentialContactsCubit, PotentialContactsState>(
              builder: (context, state) {
                if (state is PotentialContactsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is PotentialContactsError) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                if (state is PotentialContactsLoaded) {
                  if (state.contacts.isEmpty) {
                    return const Center(
                      child: Text('No contacts'),
                    );
                  }
                  return Expanded(
                    child: GridView.builder(
                      itemCount: state.contacts.length,
                      itemBuilder: (context, index) {
                        return CustomCourseWidget(
                          image:
                              index % 2 == 0 ? AppImages.man : AppImages.woman,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialog(
                                  title: "Confirm Action",
                                  content: "Are you sure you want to proceed?",
                                  onConfirm: () {
                                    ContactEntity contact = ContactEntity(
                                      id: '',
                                      status: ContactsStatus.active,
                                      person1: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      person2: state.contacts[index].id,
                                      contactName: state.contacts[index].name,
                                    );
                                    context
                                        .read<PotentialContactsCubit>()
                                        .createContact(
                                          contact,
                                          state,
                                        );

                                    Navigator.of(context).pop();
                                  },
                                  onCancel: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                            );
                          },
                          title: state.contacts[index].name,
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.9,
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20.0,
        bottom: 16.0,
        left: 16.0,
        right: 16.0,
      ),
      margin: const EdgeInsets.only(top: 40.0),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the dialog compact
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: AppColors.black),
          ),
          const SizedBox(height: 16.0),
          Text(
            content,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColors.black),
          ),
          const SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: onCancel,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.error),
                ),
                child: const Text(
                  "Cancel",
                ),
              ),
              ElevatedButton(
                onPressed: onConfirm,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.onTertiaryContainer),
                ),
                child: const Text("Confirm"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
