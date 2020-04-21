import "package:flutter/material.dart";

class AppButton extends StatelessWidget {
  final String text;
  final Function onClickFunction;

  AppButton({this.text, this.onClickFunction});

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        margin: EdgeInsets.all(5),
        child: RaisedButton(
          color: Colors.green,
          child: Text(text, style: TextStyle(color: Colors.white)),
          onPressed: onClickFunction,
        ),
      );
}
