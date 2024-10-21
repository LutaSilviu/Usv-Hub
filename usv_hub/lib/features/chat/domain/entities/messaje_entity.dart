import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String id;
  final String text;
  final String senderId;
  final String contactId;
  final DateTime timeWhenSent;

  const MessageEntity({
    required this.id,
    required this.text,
    required this.senderId,
    required this.contactId,
    required this.timeWhenSent,
  });

  @override
  List<Object?> get props => [
        id,
        text,
        senderId,
        contactId,
        timeWhenSent,
      ];
}
