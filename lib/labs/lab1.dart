import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Lab2 extends StatefulWidget {
  Lab2({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _Lab2State createState() => _Lab2State();
}

class _Lab2State extends State<Lab2> {
  late TextEditingController _num1Controller = TextEditingController();
  late TextEditingController _num2Controller = TextEditingController();
  double _result = 0;

  void _calcAdd() {
    setState(() {
      this._result = double.parse(this._num1Controller.text) +
          double.parse(this._num2Controller.text);
    });
  }

  void _calcSubtract() {
    setState(() {
      this._result = double.parse(this._num1Controller.text) -
          double.parse(this._num2Controller.text);
    });
  }

  void _calcMultiply() {
    setState(() {
      this._result = double.parse(this._num1Controller.text) *
          double.parse(this._num2Controller.text);
    });
  }

  void _calcDivision() {
    setState(() {
      this._result = double.parse(this._num1Controller.text) /
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
                  ),
                  OutlinedButton(
                      onPressed: this._calcSubtract,
                      child: Text('---')
                  ),
                  OutlinedButton(
                      onPressed: this._calcMultiply,
                      child: Text('x')
                  ),
                  OutlinedButton(
                      onPressed: this._calcDivision,
                      child: Text('/')
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
