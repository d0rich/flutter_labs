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

  @override
  void initState() {

    super.initState();
  }

  startService() async {
  }

  stopService() async {
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
            OutlinedButton(
                onPressed: startService,
                child: Text('Start Service')
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
