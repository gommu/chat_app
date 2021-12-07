import "package:flutter/material.dart";

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      currentIndex: 3,
      onTap: (index) {
        if (index == 0) {
          // BlocProvider.of<ChatsListCubit>(context).fetchChatsList();
          // print(sl<ChatsListCubit>().updateChatsList());
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble),
          label: "",
        ),
      ],
    );
  }
}
