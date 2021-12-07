import 'package:bloc/bloc.dart';
import 'package:chat_app/core/errors/failures.dart';
import 'package:chat_app/domain/entities/chat_preview.dart';
import 'package:chat_app/domain/usecases/get_chats_list.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'chats_list_state.dart';

class ChatsListCubit extends Cubit<ChatsListState> {
  final GetChatsList getChatsList;

  ChatsListCubit({required this.getChatsList}) : super(ChatsListInitial());

  Future<void> fetchChatsList() async {
    emit(ChatsListLoading());
    _getChatsList();
  }

  Future<void> updateChatsList() async {
    _getChatsList();
  }

  Future<void> _getChatsList() async {
    final items = await getChatsList();
    items.fold((failure) {
      emit(ChatsListError(message: _mapFailureToMessage(failure)));
    }, (success) {
      emit(ChatsListLoaded(chatsList: success));
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
