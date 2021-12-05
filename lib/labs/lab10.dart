import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tpu_mobile_labs/support/lab11/SolarSystem.dart';
import 'package:tpu_mobile_labs/support/lab9/GithubRepository.dart';

class Lab10 extends StatefulWidget {
  Lab10({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _Lab10State createState() => _Lab10State();
}

class _Lab10State extends State<Lab10> {
  static const _methodChannel = MethodChannel('tpu_labs/methods');
  static const _eventChannel = EventChannel('tpu_labs/stream');
  late int _counter = 0;
  late TextEditingController _delayController = TextEditingController();
  late TextEditingController _startValueController = TextEditingController();

  @override
  void initState() {
    _eventChannel.receiveBroadcastStream()..listen((event) {
      setState(() {
        _counter = event;
      });
    });
    super.initState();
  }

  startService() async {
    await _methodChannel.invokeMethod('startService');
  }

  getCounter() async {
    final int result = await _methodChannel.invokeMethod('getCounter');
    setState(() {
      _counter = result;
    });
  }

  stopService() async {
    await _methodChannel.invokeMethod('stopService');
  }

  setDelay() async {
    await _methodChannel.invokeMethod('setDelay', int.parse(_delayController.text));
  }

  restart() async {
    await _methodChannel.invokeMethod('restart');
  }

  setStartValue() async {
    await _methodChannel.invokeMethod('setStartValue', int.parse(_startValueController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: [
            Text('Counter: $_counter'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                    onPressed: startService,
                    child: Text('Start Service')
                ),
                OutlinedButton(
                    onPressed: getCounter,
                    child: Text('Get Counter')
                ),
                OutlinedButton(
                    onPressed: stopService,
                    child: Text('Stop Service')
                )
              ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 200,
                    child: TextField(
                      controller: this._delayController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Interval',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    )
                  ),
                  OutlinedButton(
                      onPressed: setDelay,
                      child: Text('Set Interval')
                  )
                ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 200,
                    child: TextField(
                      controller: this._startValueController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Start Value',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  OutlinedButton(
                      onPressed: setStartValue,
                      child: Text('Set Start Value')
                  )
                ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                    onPressed: restart,
                    child: Text('Restart')
                )
              ],
            )
          ],
        )
      ),
    );
  }
}
