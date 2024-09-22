import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/login/presentation/widgets/custom_text_field.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Andronache Filipache',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Background(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: index % 2 == 0
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: 300.w,
                          ),
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: index % 2 == 0
                                ? Theme.of(context).colorScheme.primaryContainer
                                : Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                            borderRadius: BorderRadius.only(
                              topLeft: index % 2 == 0
                                  ? const Radius.circular(8)
                                  : Radius.zero,
                              topRight: index % 2 != 0
                                  ? const Radius.circular(8)
                                  : Radius.zero,
                              bottomLeft: const Radius.circular(8),
                              bottomRight: const Radius.circular(8),
                            ),
                          ),
                          child: Text(
                            softWrap: true,
                            'HellddddHellddddasddddddddddddddddddddddsaddddddddddddddddd',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                        hintText: AppTextConst.message, controller: controller),
                  ),
                  IconButton(
                      style: Theme.of(context).iconButtonTheme.style!.copyWith(
                            backgroundColor: WidgetStateProperty.all<Color>(
                              Colors.transparent,
                            ),
                          ),
                      onPressed: () {},
                      icon: Icon(Icons.send)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
