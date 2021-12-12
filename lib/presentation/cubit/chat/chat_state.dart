part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatLoading extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatLoaded extends ChatState {
  final Chat chat;
  const ChatLoaded({required this.chat});
  @override
  List<Object> get props => [chat];
}

class ChatUpdating extends ChatState{
  @override
  List<Object> get props => [];
}

class ChatUpdated extends ChatState {
  final Chat chat;
  const ChatUpdated({required this.chat});
  @override
  List<Object> get props => [chat];
}

class ChatError extends ChatState {
  final String message;
  const ChatError({required this.message});
  @override
  List<Object> get props => [message];
}

class ChatClosed extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatMessageSending extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatMessageSent extends ChatState {
  @override
  List<Object> get props => [];
}