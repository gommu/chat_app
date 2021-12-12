import 'package:chat_app/presentation/cubit/chat/chat_cubit.dart';
import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  final ChatCubit cubit;

  MessageInput(this.cubit, {Key? key}) : super(key: key);

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
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
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  widget.cubit.sendMessage(_textController.value.text);
                  _textController.clear();
                  _inputFocusNode.unfocus();
                  FocusScope.of(context).unfocus();
                }
              },
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
