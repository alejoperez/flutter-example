import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterexample/chat/widgets/message_bubble_view.dart';

class ChatMessagesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, userData) {
          if (userData.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return StreamBuilder(
            stream: Firestore.instance.collection("chats").orderBy(
                "createdAt", descending: true).snapshots(),
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              final documents = dataSnapshot.data.documents;
              return ListView.builder(
                reverse: true,
                itemBuilder: (ctx, index) {
                  if (userData.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Container(
                    padding: const EdgeInsets.all(8),
                    child: MessageBubbleView(
                        userName: documents[index]["username"],
                        message: documents[index]["text"],
                        isMe: documents[index]["userId"] == userData.data.uid,
                        key: ValueKey(documents[index].documentID),
                    ),
                  );
                },
                itemCount: documents.length,
              );
            },
          );
        }


    );
  }
}
