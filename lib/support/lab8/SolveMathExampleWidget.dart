import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'math_train.dart';

class SolveMathExampleWidget extends StatelessWidget {
  final Function(int answerIndex) onAnswer;
  final MathSample mathSample;
  final List<int> answers;

  SolveMathExampleWidget({Key? key,
    required this.mathSample,
    required this.answers,
    required this.onAnswer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.all(30),
              child: Text(
                mathSample.sample,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
              )
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: onAnswer(0),
                  child: Text(
                      answers[0].toString(),
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      )
                  ),

                ),
                OutlinedButton(
                    onPressed: onAnswer(1),
                    child: Text(
                        answers[1].toString(),
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        )
                    )
                ),
                OutlinedButton(
                    onPressed: onAnswer(2),
                    child: Text(
                        answers[2].toString(),
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        )
                    )
                )
              ]
          )
        ]
    );
  }



}
