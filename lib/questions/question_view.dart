import "package:flutter/material.dart";

import "package:flutterexample/base/widgets/app_button.dart";
import "package:flutterexample/base/widgets/app_text.dart";

class QuestionView extends StatelessWidget {
  final int questionIndex;
  final List<Map<String, Object>> questionsList;
  final Function onAnswerClicked;

  QuestionView(
      {@required this.questionIndex,
      @required this.questionsList,
      @required this.onAnswerClicked});

  String _getQuestionText() => questionsList[questionIndex]["questionText"];

  List<Map<String, Object>> _getQuestionOptions() =>
      questionsList[questionIndex]["options"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppText(_getQuestionText()),
        ..._getQuestionOptions()
            .map((option) => AppButton(
                text: option["text"],
                onClickFunction: () => onAnswerClicked(option["score"])))
            .toList()
      ],
    );
  }
}
