import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/core/utils/custom_snackbar.dart';
import 'package:usv_hub/features/assigments/presentation/providers/add_assigment_provider.dart';
import 'package:usv_hub/injection.dart';

class AddAssigmentPage extends StatefulWidget {
  const AddAssigmentPage({
    required this.courseId,
    super.key,
  });

  final String courseId;
  @override
  State<AddAssigmentPage> createState() => _AddAssigmentPageState();
}

class _AddAssigmentPageState extends State<AddAssigmentPage> {
  final String title = AppTextConst.addGradePage;
  final TextEditingController labController = TextEditingController();
  final TextEditingController courseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTextConst.addAssigment),
        centerTitle: true,
      ),
      body: Background(
        child: ChangeNotifierProvider(
          create: (context) => getIt<AddAssigmentProvider>(),
          builder: (context, child) => Formular(
            courseId: widget.courseId,
          ),
        ),
      ),
    );
  }
}

class Formular extends StatefulWidget {
  @override
  _FormularState createState() => _FormularState();

  const Formular({super.key, required this.courseId});
  final String courseId;
}

class _FormularState extends State<Formular> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titluController = TextEditingController();
  final TextEditingController _descriereController = TextEditingController();

  Future<void> _selectDate(BuildContext context, bool isStartDate,
      AddAssigmentProvider provider) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              surface: AppColors.secondary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      if (isStartDate) {
        provider.setStartDate(picked);
      } else {
        provider.setEndDate(picked);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Consumer<AddAssigmentProvider>(
                    builder: (_, provider, child) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _titluController,
                          decoration: const InputDecoration(
                            labelText: AppTextConst.title,
                            labelStyle: TextStyle(
                              color: AppColors.white,
                            ),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? AppTextConst.titleError
                              : null,
                        ),
                        TextFormField(
                          controller: _descriereController,
                          decoration: const InputDecoration(
                            labelText: AppTextConst.description,
                            labelStyle: TextStyle(
                              color: AppColors.white,
                            ),
                          ),
                          maxLines: 3,
                          minLines: 1,
                          validator: (value) => value == null || value.isEmpty
                              ? AppTextConst.descriptionError
                              : null,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text(provider.startDate == null
                                  ? AppTextConst.startTime
                                  : 'Start: ${provider.startDate!.toLocal().toString().split(' ')[0]}'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                              onPressed: () =>
                                  _selectDate(context, true, provider),
                              child: const Text(AppTextConst.startTime),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Text(provider.endDate == null
                                  ? AppTextConst.endTime
                                  : 'Finish: ${provider.endDate!.toLocal().toString().split(' ')[0]}'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                              onPressed: () =>
                                  _selectDate(context, false, provider),
                              child: const Text(AppTextConst.endTime),
                            ),
                          ],
                        ),
                        const Spacer(), // 👈 Push button to bottom
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                provider.setTitle(_titluController.text);
                                provider
                                    .setDescription(_descriereController.text);
                                await provider.postAssigment(
                                  widget.courseId,
                                );
                                if (provider.errorMessage == null) {
                                  if (context.mounted) {
                                    CustomSnackbar.show(
                                      context,
                                      AppTextConst.formSubmitted,
                                    );
                                    provider.clearFields();
                                    Navigator.pop(context);
                                  }
                                } else {
                                  if (context.mounted) {
                                    CustomSnackbar.show(
                                      context,
                                      provider.errorMessage!,
                                    );
                                  }
                                }
                              }
                            },
                            child: const Text(AppTextConst.add),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
