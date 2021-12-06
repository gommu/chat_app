part of 'chats_list_cubit.dart';

abstract class ChatsListState extends Equatable {
  const ChatsListState();
}

class ChatsListInitial extends ChatsListState {
  @override
  List<Object> get props => [];
}


class ChatsListLoading extends ChatsListState {
  @override
  List<Object> get props => [];
}

class ChatsListLoaded extends ChatsListState {
  final List<ChatPreview> chatsList;
  const ChatsListLoaded({required this.chatsList});
  @override
  List<Object> get props => [chatsList];
}

class ChatsListError extends ChatsListState {
  final String message;
  const ChatsListError({required this.message});
  @override
  List<Object> get props => [message];
}
