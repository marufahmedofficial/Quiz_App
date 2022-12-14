import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_app/customwidget/quiz_item.dart';
import 'package:quiz_app/pages/result_page.dart';
import 'package:quiz_app/temp_db.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool hasQuizStarted = false;
  Timer? timer;
  int count = 10;

  _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if(count > 0) {
        setState(() {
          count--;
        });
      } else {
        _stopTimer();
        navigate();
      }
    });
  }

  _stopTimer() {
    if(timer != null) {
      timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Remaining Time: $count sec'),
          actions: [
            if(!hasQuizStarted) TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white
              ),
              onPressed: () {
                setState(() {
                  hasQuizStarted = true;
                  quizList = generateQuizList;
                });
                _startTimer();
              },
              child: const Text('START'),
            ),
            if(hasQuizStarted) TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white
              ),
              onPressed: () {
                _stopTimer();
                navigate();
              },
              child: const Text('FINISH'),
            ),
          ],
        ),
        body: hasQuizStarted ? ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: quizList.length,
          itemBuilder: (context, index) {
            return QuizItem(
              serial: index + 1,
              quiz: quizList[index],
              onAnswer: (answer) {
                quizList[index].givenAnswer = answer;
              },
            );
          },
        ) : const Center(child: Text('Press the start button above to begin your Quiz'),)
    );
  }

  void navigate() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ResultPage()));
  }
}
