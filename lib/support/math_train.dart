import 'dart:math';

Random rand = Random();

class MathSample{
  late String _sample;
  late int _rightAnswer;
  int? _factAnswer;

  String get sample{
    return this._sample;
  }

  int? get answer{
    return this._factAnswer;
  }

  bool get isCorrectAnswer{
    return this._factAnswer == this._rightAnswer;
  }

  MathSample(){
    switch (rand.nextInt(4)){
      case 0: // +
        int firstNum = rand.nextInt(50) + 1;
        int secondNum = rand.nextInt(50) + 1;
        this._rightAnswer = firstNum + secondNum;
        this._sample = "$firstNum + $secondNum";
        break;
      case 1: // -
        int firstNum = rand.nextInt(100) + 1;
        int secondNum = rand.nextInt(100) + 1;
        if (firstNum > secondNum){
          this._rightAnswer = firstNum - secondNum;
          this._sample = "$firstNum - $secondNum";
        }
        else {
          this._rightAnswer = secondNum - firstNum;
          this._sample = "$firstNum - $secondNum";
        }
        break;
      case 2: // *
        int firstNum = rand.nextInt(20) + 1;
        int secondNum = rand.nextInt(20) + 1;
        this._rightAnswer = firstNum * secondNum;
        this._sample = "$firstNum * $secondNum";
        break;
      default: // /
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