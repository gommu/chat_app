import 'dart:convert';

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


void main() {
  var chatsJson = json.decode(a);
  chatsJson.forEach(print);
}