import 'package:flutter/material.dart';
import 'package:flutterexample/chat/screens/chat_screen.dart';
import 'package:flutterexample/chat/screens/chat_auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat App",
      theme: ThemeData(
          primarySwatch: Colors.teal,
          backgroundColor: Colors.teal,
          accentColor: Colors.yellow,
          accentColorBrightness: Brightness.dark,
          buttonTheme: Theme.of(context).buttonTheme.copyWith(
            buttonColor: Colors.teal,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            )
          ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, dataSnapshot) {
          if(dataSnapshot.hasData) {
            return ChatScreen();
          }
          return ChatAuthScreen();
        } ,
      ),
    );
  }
}
