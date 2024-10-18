import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:usv_hub/core/utils/background.dart';
import 'package:usv_hub/core/utils/consts.dart';
import 'package:usv_hub/features/chat/domain/entities/contact_entity.dart';
import 'package:usv_hub/features/chat/domain/entities/messaje_entity.dart';
import 'package:usv_hub/features/chat/domain/usecases/get_all_messages.dart';
import 'package:usv_hub/features/chat/presentation/cubit/messages/messages_cubit.dart';
import 'package:usv_hub/features/login/presentation/widgets/custom_text_field.dart';
import 'package:usv_hub/injection.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map arg = ModalRoute.of(context)!.settings.arguments as Map;
    final ContactEntity contact = arg[AppArguments.contactEntity];
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          contact.contactName,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Background(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                    stream: getIt<GetAllMessages>().call(
                        params: contact.person1 == userId
                            ? contact.person2
                            : contact.person1),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('No messages'),
                        );
                      }

                      snapshot.data!.sort(
                          (a, b) => a.timeWhenSent.compareTo(b.timeWhenSent));
                      List<MessageEntity> messages = snapshot.data!;

                      return ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment:
                                messages[index].senderId == userId
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
                                      ? Theme.of(context)
                                          .colorScheme
                                          .primaryContainer
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
                                  messages[index].messaje,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }),
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
                      onPressed: () {
                        MessageEntity messageEntity = MessageEntity(
                            id: '',
                            messaje: controller.text,
                            senderId: userId,
                            reciverId: contact.person1 == userId
                                ? contact.person2
                                : contact.person1,
                            timeWhenSent: DateTime.now());
                        context
                            .read<MessagesCubit>()
                            .sendMessaje(messageEntity);
                      },
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
