import 'package:chat_app/core/constants/example_data.dart';
import 'package:chat_app/domain/entities/chat_message.dart';
import "package:flutter/material.dart";
import 'dart:ui' as ui;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.arrow_back_sharp),
          title: const Text("Важный чат"),
          elevation: 0,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    reverse: true,
                    itemCount: exampleData.length,
                    itemBuilder: (context, index) {
                      final message = exampleData[index];
                      return MessageBubble(
                        message: message,
                        child: Text(message.message),
                      );
                    },
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(child: InputMessage()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
                    painter: ChatBubble(
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

class InputMessage extends StatefulWidget {
  const InputMessage({Key? key}) : super(key: key);

  @override
  _InputMessageState createState() => _InputMessageState();
}

class _InputMessageState extends State<InputMessage> {
  final _inputFocusNode = FocusNode();
  final _textController = TextEditingController();

  @override
  void dispose() {
    _inputFocusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _query = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () => _inputFocusNode.requestFocus(),
        child: TextField(
          controller: _textController,
          // focusNode: _inputFocusNode,
          // autofocus: true,
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          minLines: 1,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFD6E5FA), width: 1.0)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFD6E5FA), width: 1.0)),
            hintText: 'Enter message',
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.send,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChatBubble extends CustomPainter {
  final Color color;
  final Alignment alignment;

  ChatBubble({
    required this.color,
    required this.alignment,
  });

  var _radius = 8.0;
  var _x = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (alignment == Alignment.topRight) {
      canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            0,
            0,
            size.width - 8,
            size.height,
            bottomLeft: Radius.circular(_radius),
            topRight: Radius.circular(_radius),
            topLeft: Radius.circular(_radius),
          ),
          Paint()
            ..color = this.color
            ..style = PaintingStyle.fill);
      var path = new Path();
      path.moveTo(size.width - _x, size.height - 10);
      path.lineTo(size.width - _x, size.height);
      path.lineTo(size.width, size.height);
      canvas.clipPath(path);
      canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            size.width - _x,
            0.0,
            size.width,
            size.height,
            topRight: Radius.circular(_radius),
          ),
          Paint()
            ..color = this.color
            ..style = PaintingStyle.fill);
    } else {
      canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            _x,
            0,
            size.width,
            size.height,
            bottomRight: Radius.circular(_radius),
            topRight: Radius.circular(_radius),
            topLeft: Radius.circular(_radius),
          ),
          Paint()
            ..color = color
            ..style = PaintingStyle.fill);
      var path = Path();
      path.moveTo(0, size.height);
      path.lineTo(_x, size.height);
      path.lineTo(_x, size.height - 10);
      canvas.clipPath(path);
      canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            0,
            0.0,
            _x,
            size.height,
            topRight: Radius.circular(_radius),
          ),
          Paint()
            ..color = color
            ..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
