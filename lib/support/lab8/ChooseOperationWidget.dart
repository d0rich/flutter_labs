import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tpu_mobile_labs/support/lab8/math_train.dart';

class ChooseOperationWidget extends StatelessWidget {

  ChooseOperationWidget({Key? key, required this.switchOperation}) : super(key: key);

  final Function(Operation operation) switchOperation;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 30, bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
                onPressed: switchOperation(Operation.add),
                child: Text('+', style: TextStyle(fontSize: 40),)
            ),
            OutlinedButton(
                onPressed: switchOperation(Operation.subtract),
                child: Text('-', style: TextStyle(fontSize: 40),)
            ),
            OutlinedButton(
                onPressed: switchOperation(Operation.multiply),
                child: Text('*', style: TextStyle(fontSize: 40),)
            ),
            OutlinedButton(
                onPressed: switchOperation(Operation.divide),
                child: Text('/', style: TextStyle(fontSize: 40),)
            ),
          ],
        )
    );
  }
}