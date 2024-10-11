import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String id;
  final String messaje;
  final String senderId;
  final String reciverId;
  final DateTime timeWhenSent;

  const MessageEntity({
    required this.id,
    required this.messaje,
    required this.senderId,
    required this.reciverId,
    required this.timeWhenSent,
  });

  @override
  List<Object?> get props => [
        id,
        messaje,
        senderId,
        reciverId,
        timeWhenSent,
      ];
}
