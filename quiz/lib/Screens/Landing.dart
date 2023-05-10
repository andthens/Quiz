import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz/Screens/scoreBoard.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
   int correctAnswersCount = 0;
    bool isAnswered = false;
     late int selectedOptionIndex;
  List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the capital of Australia?',
      'options': ['Sydney', 'Melbourne', 'Canberra', 'Perth'],
      'answer': 'Canberra'
    },
    {
      'question': 'Which planet is known as the Red Planet?',
      'options': ['Mars', 'Venus', 'Mercury', 'Jupiter'],
      'answer': 'Mars'
    },
    {
      'question': 'What is the smallest country in the world?',
      'options': ['Vatican City', 'Monaco', 'San Marino', 'Nauru'],
      'answer': 'Vatican City'
    },
  ];

  late Timer _timer;
  int _secondsRemaining = 20;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
          onNextQuestion();
        }
      });
    });
  }

  void resetTimer() {
    _timer.cancel();
    setState(() {
      _secondsRemaining = 20;
    });
    startTimer();
  }

  void onNextQuestion() {
    _timer.cancel();
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        selectedOptionIndex = 0;
        resetTimer();
      } else {
        showResult();
      }
    });
  }
   void onOptionSelected(String option) {
    if (option == questions[currentQuestionIndex]['answer']) {
      setState(() {
        correctAnswersCount++;
      });
    }
    onNextQuestion();
  }

 void showResult() {
    int totalQuestions = questions.length;
    double marksPerQuestion = 10 / totalQuestions;
    int obtainedMarks = correctAnswersCount;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Result'),
          content: Container(
            height: 200.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You scored ${obtainedMarks} out of ${totalQuestions}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                 Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ScoreboardScreen()),
    );
                
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Question ${currentQuestionIndex + 1}:',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    questions[currentQuestionIndex]['question'],
                    style: TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.0),
                  ...List.generate(
              questions[currentQuestionIndex]['options'].length ~/ 2 + 1,
              (rowIndex) {
                int startIndex = rowIndex * 2;
                return Row(
                  children: [
                    ...List.generate(
                      2,
                      (columnIndex) {
                        int optionIndex = startIndex + columnIndex;
                        if (optionIndex >=
                            questions[currentQuestionIndex]['options']
                                .length) {
                          return SizedBox(width: 16.0);
                        }
                        String option =
                            questions[currentQuestionIndex]['options']
                                [optionIndex];
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isAnswered = true;
                                  if (option ==
                                      questions[currentQuestionIndex]
                                          ['answer']) {
                                    correctAnswersCount++;
                                  }
                                });
                                Future.delayed(Duration(milliseconds: 500),
                                    onNextQuestion);
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: 
                                  
                                      option ==
                                              questions[currentQuestionIndex]['options']
                                              
                                          ? Colors.blue
                                          : Colors.white,
                                    
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 2.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(0.0, 1.0),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    option,
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                            ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          SizedBox(height: 16.0),
          Center(
            child: Text(
              '$_secondsRemaining seconds left',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
  );
}
}
