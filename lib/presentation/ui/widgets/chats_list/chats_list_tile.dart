import 'package:chat_app/domain/entities/chat_preview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatsListTile extends StatefulWidget {
  final ChatPreview chatPreview;
  const ChatsListTile(this.chatPreview, {Key? key}) : super(key: key);

  @override
  _ChatsListTileState createState() => _ChatsListTileState();
}

class _ChatsListTileState extends State<ChatsListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.chatPreview.name),
      subtitle: Text("${widget.chatPreview.lastMessage.author}: ${widget.chatPreview.lastMessage.message}"),
      trailing: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.chatPreview.unreadMessagesAmount > 0)
              Text("${widget.chatPreview.unreadMessagesAmount} сообщения"),
            Text(DateFormat('Hm').format(widget.chatPreview.lastMessage.messageDate)),
          ],
        ),
      ),
      dense: false,
    );
  }
}
