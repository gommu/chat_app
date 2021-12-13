import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/core/constants/example_data.dart';
import 'package:chat_app/core/errors/failures.dart';
import 'package:chat_app/data/models/chat_message_model.dart';
import 'package:chat_app/domain/entities/chat.dart';
import 'package:chat_app/domain/usecases/get_chat.dart';
import 'package:chat_app/domain/usecases/get_chat_channel.dart';
import 'package:equatable/equatable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GetChat getChat;
  final GetChatChannel getChatChannel;

  ChatCubit({required this.getChat, required this.getChatChannel})
      : super(ChatInitial());

  late WebSocketChannel chatChannel;
  late Chat chat;

  Future<void> sendMessage(String message) async {
    emit(ChatMessageSending());
    ChatMessageModel cm = ChatMessageModel(
        message: message,
        author: 'You',
        messageDate: DateTime.now(),
        isRead: true,
        isMine: true);
    chat.messageHistory.insert(0, cm.toModel());
    String additionalData = '{"options":{"session":"reciver","delivery":"multicast"},"channel":"chat","event":"stats", "data": {"message": "$message" }}';
    chatChannel.sink.add(additionalData);

    emit(ChatUpdated(chat: chat));
  }

  Future<void> fetchChat(int chatId) async {
    emit(ChatLoading());
    _getChat(chatId);
  }

  Future<void> updateChat(Chat chat) async {
    final message = exampleData[0];
    chat.messageHistory.insert(0, message);
    emit(ChatUpdated(chat: chat));
  }

  Future<void> _getChat(int chatId) async {
    final items = await getChat(Params(chatId));
    items.fold((failure) {
      emit(ChatError(message: _mapFailureToMessage(failure)));
    }, (success) {
      chat = success;
      getChatChannel(ChannelParams(success.channelUrl)).then((value) {
        value.fold((fail) {}, (succ) {
          chatChannel = succ.channel;
          chatChannel.stream.listen((event) {
            emit(ChatUpdating());
            chat.messageHistory.insert(0, exampleData[0]);
            emit(ChatUpdated(chat: chat));
          });
        });
      });

      emit(ChatLoaded(chat: success));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure.runtimeType is ServerFailure) {
      return 'Server error';
    } else if (failure.runtimeType is CacheFailure) {
      return 'Cache error';
    } else {
      return 'Unknown error';
    }
  }
}
