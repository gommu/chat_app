import 'package:chat_app/domain/entities/chat_preview.dart';
import 'package:chat_app/presentation/ui/helpers/chat_arguments.dart';
import 'package:chat_app/presentation/ui/screens/chat_screen.dart';
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
    final unreadMessagesAmount = widget.chatPreview.unreadMessagesAmount;
    final isUnread = unreadMessagesAmount > 0;
    return ListTile(
      onTap: () {
        Navigator.pushNamed(
          context,
          ChatScreen.routeName,
          arguments: ChatArguments(
            widget.chatPreview.id,
            widget.chatPreview.name,
          ),
        );
      },
      title: Row(
        children: [
          if (isUnread) _buildUnreadMessageCircle(),
          Text(widget.chatPreview.name),
        ],
      ),
      subtitle: Text(
          "${widget.chatPreview.lastMessage.author}: ${widget.chatPreview.lastMessage.message}"),
      trailing: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment:
              isUnread ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
          children: [
            if (isUnread)
              Text(
                "$unreadMessagesAmount сообщения",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.blue),
              ),
            Text(DateFormat('Hm')
                .format(widget.chatPreview.lastMessage.messageDate)),
          ],
        ),
      ),
      dense: false,
    );
  }

  Widget _buildUnreadMessageCircle() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 6.0,
        height: 6.0,
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
