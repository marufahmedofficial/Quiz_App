import 'package:flutter/material.dart';
import 'package:quiz_app/temp_db.dart';

import '../custom_text_style.dart';

class QuizItem extends StatefulWidget {
  final int serial;
  final Quiz quiz;
  final Function(String) onAnswer;
  const QuizItem({
    Key? key,
    required this.serial,
    required this.quiz,
    required this.onAnswer}) : super(key: key);

  @override
  State<QuizItem> createState() => _QuizItemState();
}

class _QuizItemState extends State<QuizItem> {
  String? radioGroupValue;

  @override
  void initState() {
    radioGroupValue = widget.quiz.givenAnswer;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${widget.serial}. '),
            Flexible(child: Text('${widget.quiz.question}. ', style: qsStyle,)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: widget.quiz.answers.map((answer) => Row(
              children: [
                Radio<String>(
                  value: answer,
                  groupValue: radioGroupValue,
                  onChanged: (value) {
                    setState(() {
                      radioGroupValue = value;
                    });
                    widget.onAnswer(radioGroupValue!);
                  },
                ),
                Text(answer),
              ],
            )).toList(),
          ),
        ),
      ],
    );
  }
}
