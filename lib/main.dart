import 'package:chat_app/core/constants/themes.dart';
import 'package:chat_app/injection_container.dart' as di;
import 'package:chat_app/presentation/ui/screens/chats_list_screen.dart';
import 'package:chat_app/presentation/ui/screens/chat_screen.dart';
import 'package:flutter/material.dart';

import 'presentation/ui/screens/test_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Demo',
      theme: lightTheme,
      routes: {
        // '/': (context) => const ChatListScreen(),
        '/': (context) => const ChatScreen(),
        // '/': (context) => const MyCustomForm(),
        // '/details': (context) => const ChatScreen(),
      },
    );
  }
}
