import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewChatMessageView extends StatefulWidget {
  @override
  _NewChatMessageViewState createState() => _NewChatMessageViewState();
}

class _NewChatMessageViewState extends State<NewChatMessageView> {
  String _enteredMessage = "";
  final _controller = TextEditingController();

  void _sendMessage() async {
    FocusScope.of(context).unfocus();

    final currentUser = await FirebaseAuth.instance.currentUser();
    final userData = await Firestore.instance.collection("users").document(currentUser.uid).get();

    Firestore.instance.collection("chats").add({
      "text": _enteredMessage,
      "createdAt" : Timestamp.now(),
      "userId":currentUser.uid,
      "username": userData["username"]
    });
    _controller.clear();
    setState(() {
      _enteredMessage = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Send Message"),
              onChanged: (message) {
                setState(() {
                  _enteredMessage = message;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}
