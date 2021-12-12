import 'dart:convert';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:http/http.dart' as http;

import 'data/models/chat_preview_model.dart';

var a = '''
[
    {
        "name": "Test Chat 1",
        "id": 1,
        "unreadMessagesAmount": 3,
        "lastMessage": {
            "message": "test message",
            "author": "Ivan Ivanov",
            "messageDate": 16234891948,
            "isRead": false,
           "isMine": false
        }
    },
    {
        "name": "Test Chat 2",
        "unreadMessagesAmount": 0,
        "lastMessage": {
            "message": "test message 2",
            "id": 2,
            "author": "Ivan Ivanov",
            "messageDate": 16234891234,
            "isRead": false,
           "isMine": true
        }
    }
]
''';

main() async {
  final url = Uri.https('chatdemo.free.beeceptor.com', 'chats');
  // final url = Uri.https('f946359e-5644-4bbf-bb27-2208a6561e3b.mock.pstmn.io', 'chats');
  final response = await http.Client().get(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    var chatsJson = json.decode(response.body);
    print(chatsJson);
    final List<ChatPreviewModel> chatsList = List<ChatPreviewModel>.from(
        chatsJson.map((model) => ChatPreviewModel.fromJson(model)));
    print(chatsList);
  }
}

// main() async {
//   var channel = IOWebSocketChannel.connect(Uri.parse(
//       'ws://192.168.200.8:6001/ws/app/app-key/events/?session=session'));
//
//   channel.stream.listen(
//     (message) {
//       print('Go');
//       print(message);
//       // channel.sink.close(status.goingAway);
//     },
//     onError: (error) => print(error),
//     onDone: () {},
//   );
// }
