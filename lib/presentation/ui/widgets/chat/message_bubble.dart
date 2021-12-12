import 'package:chat_app/domain/entities/chat_message.dart';
import 'package:flutter/material.dart';

import 'message_bubble_painter.dart';

@immutable
class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.message,
    required this.child,
  }) : super(key: key);

  final ChatMessage message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final messageAlignment =
    message.isMine ? Alignment.topLeft : Alignment.topRight;

    return FractionallySizedBox(
      alignment: messageAlignment,
      widthFactor: 0.8,
      child: Align(
        alignment: messageAlignment,
        child: Column(
          crossAxisAlignment: message.isMine
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 6.0,
                left: 17.0,
                right: 17.0,
              ),
              child: Text(
                '${message.author}, ${message.messageDate.hour}:${message.messageDate.minute} ${message.messageDate.day}.${message.messageDate.month}',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 6.0,
                left: 10.0,
                right: 10.0,
              ),
              child: Column(
                children: [
                  CustomPaint(
                    painter: MessageBubblePainter(
                      color: message.isMine
                          ? const Color(0xFFE8F0FC)
                          : const Color(0xFFF2F2F3),
                      alignment: messageAlignment,
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(left: 8, right: 8),
                      decoration: BoxDecoration(
                        color: message.isMine
                            ? const Color(0xFFE8F0FC)
                            : const Color(0xFFF2F2F3),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: child,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
