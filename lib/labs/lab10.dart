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
          ],
        )
      ),
    );
  }
}
