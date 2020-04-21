import "package:flutter/material.dart";

import 'package:flutterexample/questions/quiz_finished_view.dart';
import 'package:flutterexample/questions/question_view.dart';

class QuestionsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var _questionIndex = 0;
  var _totalScore = 0;
  final _questionsList = const [
    {
      "questionText": "What's your favorite color?",
      "options": [
        {"text": "Red", "score": 10},
        {"text": "Green", "score": 20},
        {"text": "Blue", "score": 15},
        {"text": "Yellow", "score": 5},
      ]
    },
    {
      "questionText": "What's your favorite animal?",
      "options": [
        {"text": "Cat", "score": 5},
        {"text": "Dog", "score": 10},
      ]
    },
    {
      "questionText": "What's your favorite car?",
      "options": [
        {"text": "BMW", "score": 1},
        {"text": "Fiat", "score": 3},
        {"text": "Ferrari", "score": 5},
        {"text": "Mazda", "score": 7},
      ]
    }
  ];

  void _onAnswerClicked(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("App Bar Title")),
        body: _questionIndex < _questionsList.length
            ? QuestionView(
                questionIndex: _questionIndex,
                questionsList: _questionsList,
                onAnswerClicked: _onAnswerClicked)
            : QuizFinishedView(_totalScore, _resetQuiz),
      );
}
