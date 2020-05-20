import 'package:flutter/material.dart';
import 'package:flutterexample/chat/widgets/user_image_picker_view.dart';
import 'dart:io';
class ChatAuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(File userImageFile,String email, String password, String userName, bool isLogin, BuildContext ctx) submitAuthFormFunction;
  ChatAuthForm(this.submitAuthFormFunction,this.isLoading);

  @override
  _ChatAuthFormState createState() => _ChatAuthFormState();
}

class _ChatAuthFormState extends State<ChatAuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail = "";
  String _userName = "";
  String _userPassword = "";
  File _userImageFile;

  void _setUserImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isFormValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if(_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Image not selected"), backgroundColor: Colors.red,));
      return;
    }

    if(isFormValid) {
      _formKey.currentState.save();
      widget.submitAuthFormFunction(_userImageFile,_userEmail.trim(),_userPassword.trim(), _userName.trim(), _isLogin,context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(!_isLogin)
                  UserImagePickerView(_setUserImage),
                  TextFormField(
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    key: ValueKey("email"),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return "Invalid email";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: "Email Address"),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if(!_isLogin)
                  TextFormField(
                    autocorrect: true,
                    textCapitalization: TextCapitalization.words,
                    enableSuggestions: false,
                    key: ValueKey("username"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Invalid userName";
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: "User name"),
                    onSaved: (value) {
                      _userName = value;
                    },
                  ),
                  TextFormField(
                    key: ValueKey("password"),
                    obscureText: true,
                    decoration: InputDecoration(labelText: "Password"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Invalid password";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userPassword = value;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  widget.isLoading ? Center(child: CircularProgressIndicator()) :
                  RaisedButton(
                    child: Text(_isLogin ? "Login": "Register"),
                    onPressed: _trySubmit,
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(!_isLogin ? "Login" : "Create new account"),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
