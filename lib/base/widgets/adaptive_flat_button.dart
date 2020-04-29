import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function onPressedFunction;

  const AdaptiveFlatButton({@required this.text, @required this.onPressedFunction});

  bool _isiOS() => Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    return _isiOS()
        ? CupertinoButton(
            child: Text(text,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold)),
            onPressed: onPressedFunction)
        : FlatButton(
            child: Text("Select date",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold)),
            onPressed: onPressedFunction);
  }
}
