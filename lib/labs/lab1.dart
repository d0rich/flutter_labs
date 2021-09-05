import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Lab1 extends StatefulWidget {
  Lab1({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _Lab1State createState() => _Lab1State();
}

class _Lab1State extends State<Lab1> {
  late TextEditingController _num1Controller = TextEditingController();
  late TextEditingController _num2Controller = TextEditingController();
  double _result = 0;

  void _calcAdd() {
    setState(() {
      this._result = double.parse(this._num1Controller.text) +
          double.parse(this._num2Controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: this._num1Controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Number 1',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            TextField(
              controller: this._num2Controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Number 2'
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            Text(
              'Result: $_result',
            ),
            Center(
              child: Row(
                children: [
                  OutlinedButton(
                      onPressed: this._calcAdd,
                      child: Icon(Icons.add)
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
