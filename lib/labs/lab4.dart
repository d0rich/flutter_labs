import 'package:flutter/material.dart';
import 'dart:math';

class Lab4 extends StatefulWidget {
  Lab4({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _Lab4State createState() => _Lab4State();
}

class _Lab4State extends State<Lab4> {
  late List<String> _textBoxes = [];
  late Random rand = Random();

  void _addText() {
    setState(() {
      this._textBoxes.add(rand.nextInt(100).toString());
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
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                OutlinedButton(
                    onPressed: this._addText,
                    child: Text('Add Number')
                )
              ],
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: this._textBoxes.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                      height: 50,
                      color: Colors.amber[300],
                      child: Center(child: Text(this._textBoxes[index]))
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
