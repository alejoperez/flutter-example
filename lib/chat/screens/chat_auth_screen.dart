import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterexample/chat/widgets/chat_auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatAuthScreen extends StatefulWidget {
  @override
  _ChatAuthScreenState createState() => _ChatAuthScreenState();
}

class _ChatAuthScreenState extends State<ChatAuthScreen> {
  bool _isLoading = false;
  final auth = FirebaseAuth.instance;

  Future<void> _submitAuthForm(File userImageFile, String email, String password, String userName, bool isLogin, BuildContext ctx) async {
    try {
      setState(() {
        _isLoading = true;
      });
      AuthResult authResult;
      if(isLogin) {
        authResult = await auth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        authResult = await auth.createUserWithEmailAndPassword(email: email, password: password);

        final ref = FirebaseStorage.instance.ref().child("user_images").child(authResult.user.uid+".jpg");
        await ref.putFile(userImageFile).onComplete;

        final userImageUrl = await ref.getDownloadURL();

        await Firestore.instance.collection("users").document(authResult.user.uid).setData({
          "username": userName,
          "email": email,
          "image_url" : userImageUrl
        });
      }

    } on PlatformException catch(err) {
      var errorMessage = "An errorMessage ocurred";
      if(err != null) {
        errorMessage = err.message;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(content: Text(errorMessage),backgroundColor: Colors.red,));
    } catch(err) {
      print(err);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ChatAuthForm(_submitAuthForm,_isLoading),
    );
  }
}
