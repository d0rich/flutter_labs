import 'dart:math';
import 'package:flutter/cupertino.dart';

Random rand = Random();

enum Operation{
  add,
  subtract,
  multiply,
  divide
}

class OperationNotification extends Notification{
  final Operation operation;

  const OperationNotification({required this.operation});
}


class MathSample{
  late String _sample;
  late int _rightAnswer;
  int? _factAnswer;

  String get sample{
    return this._sample;
  }

  int get rightAnswer{
    return this._rightAnswer;
  }

  int? get answer{
    return this._factAnswer;
  }

  bool get isCorrectAnswer{
    return this._factAnswer == this._rightAnswer;
  }

  MathSample(Operation operation){
    switch (operation){
      case Operation.add: // +
        int firstNum = rand.nextInt(50) + 1;
        int secondNum = rand.nextInt(50) + 1;
        this._rightAnswer = firstNum + secondNum;
        this._sample = "$firstNum + $secondNum";
        break;
      case Operation.subtract: // -
        int firstNum = rand.nextInt(100) + 1;
        int secondNum = rand.nextInt(100) + 1;
        if (firstNum > secondNum){
          this._rightAnswer = firstNum - secondNum;
          this._sample = "$firstNum - $secondNum";
        }
        else {
          this._rightAnswer = secondNum - firstNum;
          this._sample = "$secondNum - $firstNum";
        }
        break;
      case Operation.multiply: // *
        int firstNum = rand.nextInt(20) + 1;
        int secondNum = rand.nextInt(20) + 1;
        this._rightAnswer = firstNum * secondNum;
        this._sample = "$firstNum * $secondNum";
        break;
      case Operation.divide: // /
        this._rightAnswer = rand.nextInt(20) + 1;
        int secondNum = rand.nextInt(20) + 1;
        int firstNum = this._rightAnswer * secondNum;
        this._sample = "$firstNum / $secondNum";
        break;
    }
  }

  bool checkAnswer(int answer){
    this._factAnswer = answer;
    return this.isCorrectAnswer;
  }
}