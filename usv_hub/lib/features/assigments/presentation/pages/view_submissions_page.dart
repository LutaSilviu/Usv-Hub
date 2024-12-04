import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/features/assigments/presentation/cubits/subbmision_cubit/submission_cubit.dart';
import 'package:usv_hub/features/assigments/presentation/providers/picked_files_provider.dart';
import 'package:usv_hub/features/attendance/presentation/widgets/custom_search_field.dart';
import 'package:usv_hub/injection.dart';

class ViewSubmissionPage extends StatefulWidget {
  const ViewSubmissionPage({super.key, required this.assigmentId});

  final String assigmentId;

  @override
  State<ViewSubmissionPage> createState() => _ViewSubmissionPageState();
}

class _ViewSubmissionPageState extends State<ViewSubmissionPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Submission'),
      ),
      body: Background(
        child: BlocProvider(
          create: (context) =>
              getIt<SubmissionCubit>()..getSubmisions(widget.assigmentId),
          child: Column(
            children: [
              CustomSearchField(searchController: searchController),
              BlocBuilder<SubmissionCubit, SubmissionState>(
                builder: (context, state) {
                  if (state is SubmissionLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state is SubmissionError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is SubmissionLoaded) {
                    if (state.submissions.isEmpty) {
                      return const Center(
                        child: Text('No submissions found'),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.submissions.length,
                        itemBuilder: (_, index) {
                          final submission =
                              state.submissions.keys.elementAt(index);
                          final student =
                              state.submissions.values.elementAt(index);
                          return ListTile(
                            title: Text(
                              student,
                            ),
                            subtitle: Text(submission.postDate.toString()),
                            titleTextStyle:
                                Theme.of(context).textTheme.bodyLarge,
                            subtitleTextStyle:
                                Theme.of(context).textTheme.bodySmall,
                            onTap: () {
                              Provider.of<PickedFilesProvider>(context,
                                      listen: false)
                                  .downloadFile(submission.downloadUrl,
                                      "$student ${submission.postDate}");
                            },
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
