import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/adresses/presentation/cubit/adresses_cubit.dart';
import 'package:usv_hub/features/login/presentation/widgets/custom_text_field.dart';

class AdressesPage extends StatefulWidget {
  const AdressesPage({super.key});

  @override
  State<AdressesPage> createState() => _AdressesPageState();
}

class _AdressesPageState extends State<AdressesPage> {
  @override
  void initState() {
    Future.microtask(() {
      if (mounted) {
        context.read<AddressesCubit>().getAddresses();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTextConst.addresses),
      ),
      body: Background(
          child: Center(
        child: Padding(
          padding: EdgeInsets.all(10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppTextConst.addressesDescriprion,
              ),
              SizedBox(
                height: 50.h,
              ),
              const Text("Current Addresses:"),
              BlocBuilder<AddressesCubit, AddressesState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return const CircularProgressIndicator();
                  }
                  if (state is ErrorState) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  if (state is SuccessState) {
                    if (state.addresses.isEmpty) {
                      return Center(
                        child: Text(AppTextConst.noAddressesFound),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: state.addresses.length,
                          itemBuilder: (ctx, index) {
                            return ListTile(
                              onLongPress: () {
                                context.read<AddressesCubit>().editAddresses(
                                    state.addresses[index][AppFields.id]!,
                                    state.addresses[index][AppFields.address]!);
                              },
                              title: Text(
                                style: Theme.of(context).textTheme.bodyMedium,
                                state.addresses[index][AppFields.address]!,
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
                  return Container();
                },
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150.w, 50.h),
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return AddDialog(
                            onConfirm: (String address) {
                              context.read<AddressesCubit>().postAddresses(
                                    address,
                                  );
                              Navigator.of(context).pop();
                            },
                            onCancel: () {
                              Navigator.of(context).pop();
                            },
                          );
                        });
                  },
                  child: Text(AppTextConst.add),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class AddDialog extends StatefulWidget {
  final Function(String) onConfirm;
  final VoidCallback onCancel;

  const AddDialog({
    super.key,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            AppTextConst.addAddresses,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: AppColors.black),
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            hintText: AppTextConst.newAddress,
            controller: _controller,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: widget.onCancel,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.error),
                ),
                child: const Text(
                  "Cancel",
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              ElevatedButton(
                onPressed: () {
                  widget.onConfirm(_controller.text);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.onTertiaryContainer),
                ),
                child: const Text("Add"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
