import "package:flutter/material.dart";

import "package:flutterexample/base/widgets/app_text.dart";

class QuizFinishedView extends StatelessWidget {
  final int totalScore;
  final Function resetQuizFunction;

  QuizFinishedView(this.totalScore, this.resetQuizFunction);

  String get resultPhrase {
    if (totalScore < 20) {
      return "BAD Result! :( \n Total Score: $totalScore";
    } else {
      return "Good Result! :) \n Total Score: $totalScore";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        AppText(resultPhrase),
        FlatButton(
          child: Text(
            "Restart Quiz!",
            style: TextStyle(fontSize: 20),
          ),
          onPressed: resetQuizFunction,
          textColor: Colors.blue,
        )
      ], mainAxisAlignment: MainAxisAlignment.center),
    );
  }
}
