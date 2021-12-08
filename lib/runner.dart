import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

var a = '''
[
    {
        "name": "Test Chat 1",
        "unreadMessagesAmount": 2,
        "lastMessage": {
            "message": "test message",
            "author": "Ivan Ivanov",
            "messageDate": 16234891948,
            "isRead": false
        }
    },
    {
        "name": "Test Chat 2",
        "unreadMessagesAmount": 0,
        "lastMessage": {
            "message": "test message 2",
            "author": "Ivan Ivanov",
            "messageDate": 16234891234,
            "isRead": false
        }
    }
]
''';

main() async {
  var channel = IOWebSocketChannel.connect(Uri.parse(
      'ws://192.168.200.8:6001/ws/app/app-key/events/?session=session'));

  channel.stream.listen(
    (message) {
      print('Go');
      print(message);
      // channel.sink.close(status.goingAway);
    },
    onError: (error) => print(error),
    onDone: () {},
  );
}
