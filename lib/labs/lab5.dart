import 'package:flutter/material.dart';
import 'package:tpu_mobile_labs/support/math_train.dart';
import 'dart:math';

Random rand = Random();


class Lab5 extends StatefulWidget {
  Lab5({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _Lab5State createState() => _Lab5State();
}

class _Lab5State extends State<Lab5> {

  @override
  Widget build(BuildContext context) {
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
                  "Grocery list",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                )
            ),
            // Expanded(
            //   child: ListView.separated(
            //     padding: const EdgeInsets.all(8),
            //     itemCount: this._answersHistory.length,
            //     itemBuilder: (BuildContext context, int index){
            //       return Container(
            //           height: 50,
            //           color: _answersHistory[index].isCorrectAnswer ? Colors.greenAccent : Colors.redAccent,
            //           child: Center(child: Text("${_answersHistory[index].sample} = ${_answersHistory[index].rightAnswer} | ${_answersHistory[index].answer}"))
            //       );
            //     },
            //     separatorBuilder: (BuildContext context, int index) => const Divider(),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
