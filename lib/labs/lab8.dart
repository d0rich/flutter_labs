import 'package:flutter/material.dart';
import 'package:tpu_mobile_labs/support/lab8/math_train.dart';
import 'dart:math';

Random rand = Random();


class Lab8 extends StatefulWidget {
  Lab8({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _Lab8State createState() => _Lab8State();
}

class _Lab8State extends State<Lab8> {
  late Operation _operation = Operation.add;
  late MathSample _sampleNow = MathSample(_operation);
  late List<MathSample> _answersHistory = [];
  late List<int> _answers = [0, 0, 0];
  late int _rightCounter = 0;
  late int _wrongCounter = 0;

  void _setAnswers(){
    setState(() {
      _answers = [];
      _answers.add(this._sampleNow.rightAnswer);
      _answers.add(this._sampleNow.rightAnswer + rand.nextInt(21) - 10);
      _answers.add(this._sampleNow.rightAnswer + rand.nextInt(21) - 10);
      _answers.sort();
    });
  }

  _checkAnswer(int answerIndex){
    return () => setState(() {
      if (_sampleNow.checkAnswer(this._answers[answerIndex])){
        _rightCounter += 1;
      }
      else {
        _wrongCounter += 1;
      }
      _answersHistory.insert(0, _sampleNow);
      if (_answersHistory.length > 10)
        _answersHistory = _answersHistory.sublist(0, 10);
      _sampleNow = MathSample(_operation);
      _setAnswers();
    });
  }

  @override
  Widget build(BuildContext context) {
    this._setAnswers();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: const EdgeInsets.all(30),
                child: Text(
                  this._sampleNow.sample,
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
                  onPressed: this._checkAnswer(0),
                  child: Text(
                      this._answers[0].toString(),
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      )
                  ),

                ),
                OutlinedButton(
                    onPressed: this._checkAnswer(1),
                    child: Text(
                        this._answers[1].toString(),
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        )
                    )
                ),
                OutlinedButton(
                    onPressed: this._checkAnswer(2),
                    child: Text(
                        this._answers[2].toString(),
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        )
                    )
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Text("Right: $_rightCounter"),
                ),
                Container(
                  child: Text("Wrong: $_wrongCounter"),
                )
              ],
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: this._answersHistory.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                      height: 50,
                      color: _answersHistory[index].isCorrectAnswer ? Colors.greenAccent : Colors.redAccent,
                      child: Center(child: Text("${_answersHistory[index].sample} = ${_answersHistory[index].rightAnswer} | ${_answersHistory[index].answer}"))
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
