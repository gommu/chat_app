import 'package:chat_app/injection_container.dart';
import 'package:chat_app/presentation/cubit/chats_list_cubit.dart';
import 'package:chat_app/presentation/ui/widgets/chats_list/chats_list_tile.dart';
import 'package:chat_app/presentation/ui/widgets/common/bottom_navigation_bar_widget.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_sharp),
        title: const Text("Чат"),
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => sl<ChatsListCubit>()..fetchChatsList(),
        child: BlocBuilder<ChatsListCubit, ChatsListState>(
          builder: (context, state) {
            print(state.runtimeType);

            if (state is ChatsListInitial) {
              return const SizedBox(
                child: Text('Searching'),
              );
            } else if (state is ChatsListError) {
              return SizedBox(
                child: Text(state.message),
              );
            } else if (state is ChatsListLoaded) {
              return ListView.separated(
                itemCount: state.chatsList.length,
                itemBuilder: (context, index) {
                  return ChatsListTile(state.chatsList[index]);
                },
                separatorBuilder: (_, __) => const Divider(
                  height: 0,
                  indent: 15,
                  endIndent: 15,
                ),
              );
            } else if (state is ChatsListLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
