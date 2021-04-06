import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/src/services/authentication.dart';
import 'package:flutter_chat/src/services/message_service.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = "/chat";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final auth = FirebaseAuth.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  TextEditingController _messageController = TextEditingController();
  InputDecoration _messageTextFieldDecoration = InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      hintText: "Type a message here",
      border: InputBorder.none);
  BoxDecoration _messageContainerDecoration = BoxDecoration(
      border: Border(top: BorderSide(color: Colors.lightBlueAccent, width: 2)));
  TextStyle _sendButtonStyle = TextStyle(
    color: Colors.lightBlueAccent,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    var user = Authentication().getCurrentUser();
    if (user != null) {
      firebaseUser = user;
    }
  }

  void _getMessages() async {
    await for (var snapshot in MessageService().getMessageStream()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Chat Screen"),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Authentication().logOutUser();
                Navigator.pop(context);
              })
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder(
              stream: MessageService().getMessageStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var messages = snapshot.data.docs;
                  return Flexible(
                    child: ListView(
                      children: _getChatItems(messages),
                    ),
                  );
                }
                return Expanded(
                  child: Container(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            Container(
              decoration: _messageContainerDecoration,
              child: Row(children: [
                Expanded(
                  child: TextField(
                    decoration: _messageTextFieldDecoration,
                    controller: _messageController,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      MessageService()
                          .save(collectionName: "messages", collectionValues: {
                        "sender": auth.currentUser.email,
                        "value": _messageController.text,
                      });
                      _messageController.clear();
                    },
                    child: Text(
                      "Send",
                      style: _sendButtonStyle,
                    ))
              ]),
            ),
          ],
        ),
      ),
    );
  }

  List<ChatItem> _getChatItems(dynamic messages) {
    List<ChatItem> chatItems = [];
    for (var message in messages) {
      final messageValue = message.data()["value"];
      final messageSender = message.data()["sender"];
      bool isLoggedInUser = false;
      if (auth.currentUser.email == message.data()["sender"]) {
        isLoggedInUser = true;
      }
      chatItems.add(ChatItem(
        message: messageValue,
        sender: messageSender,
        isLoggedInUser: isLoggedInUser,
      ));
    }
    return chatItems;
  }
}

class ChatItem extends StatelessWidget {
  final String sender;
  final String message;
  final bool isLoggedInUser;
  ChatItem({
    @required this.sender,
    @required this.message,
    @required this.isLoggedInUser,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment:
            isLoggedInUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
          Material(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                message,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            borderRadius: BorderRadius.only(
              topLeft:
                  isLoggedInUser ? Radius.circular(30) : Radius.circular(0),
              topRight:
                  isLoggedInUser ? Radius.circular(0) : Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            color: isLoggedInUser ? Colors.lightBlueAccent : Colors.black45,
          )
        ],
      ),
    );
  }
}
