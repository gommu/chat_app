import 'package:chat_app/domain/entities/chat.dart';
import 'package:chat_app/presentation/cubit/chat/chat_cubit.dart';
import 'package:chat_app/presentation/ui/helpers/chat_arguments.dart';
import 'package:chat_app/presentation/ui/widgets/chat/message_bubble.dart';
import 'package:chat_app/presentation/ui/widgets/chat/message_input.dart';
import "package:flutter/material.dart";

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  static const routeName = '/chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final cubit = sl<ChatCubit>();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ChatArguments;

    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back_sharp),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          title: Text(args.chatName),
          elevation: 0,
        ),
        body: BlocProvider.value(
          value: cubit..fetchChat(args.chatId),
          child: Stack(
            children: [
              Column(
                children: [
                  Flexible(
                    child: BlocConsumer<ChatCubit, ChatState>(
                      listener: (context, state) {
                        print(state.runtimeType);
                        print(cubit.hashCode);
                      },
                      builder: (context, state) {
                        if (state is ChatError) {
                          return SizedBox(
                            child: Text(state.message),
                          );
                        } else if (state is ChatLoading) {
                          return const Center(
                            child:
                                CircularProgressIndicator(color: Colors.blue),
                          );
                        } else if (state is ChatLoaded) {
                          return _buildChat(state.chat);
                        } else if (state is ChatUpdated) {
                          return _buildChat(state.chat);
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SafeArea(child: MessageInput(cubit)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChat(Chat chat) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      reverse: true,
      itemCount: chat.messageHistory.length,
      itemBuilder: (context, index) {
        final message = chat.messageHistory[index];
        return MessageBubble(
          message: message,
          child: Text(message.message),
        );
      },
    );
  }
}
