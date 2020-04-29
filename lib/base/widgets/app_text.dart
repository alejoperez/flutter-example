import "package:flutter/material.dart";

class AppText extends StatelessWidget {
  final String text;

  AppText(this.text);

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        child: Text(text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center
        ),
      );
}
