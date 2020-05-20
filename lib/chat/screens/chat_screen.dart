import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterexample/chat/widgets/chat_messages_view.dart';
import 'package:flutterexample/chat/widgets/new_chat_message_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChatScreen extends StatefulWidget {
  static const ROUTE_NAME = "/chat";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {
    super.initState();
    final fm = FirebaseMessaging();
    fm.requestNotificationPermissions();
    fm.configure(
      onMessage: (messsage){

      },
      onLaunch: (message) {

      },
      onResume: (message) {

      }
    );
    fm.subscribeToTopic("chat");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(Icons.more_vert, color: Theme.of(context).primaryIconTheme.color,),
            onChanged: (id) {
              if(id == "logout") {
                FirebaseAuth.instance.signOut();
              }
            },
            items:[
              DropdownMenuItem(
                value: "logout",
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 8,),
                    Text("Log out")
                  ],
                ),
              )
            ]
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: ChatMessagesView(),),
            NewChatMessageView()
          ],
        ),
      ),
    );
  }
}
