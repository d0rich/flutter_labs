import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tpu_mobile_labs/support/lab11/SolarSystem.dart';
import 'package:tpu_mobile_labs/support/lab9/GithubRepository.dart';

class Lab11 extends StatefulWidget {
  Lab11({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _Lab11State createState() => _Lab11State();
}

class _Lab11State extends State<Lab11> {
  double t = 0;
  double distCoef = 50;
  double timeCoef = 1;
  late Timer timer;

  @override
  void initState() {
    setState(() {
      timer = Timer.periodic(Duration(milliseconds: (1000 / 60).round()), (timer) {
        setState(() {
          t += 1.0 / 60;
        });
      });
    });

    super.initState();
  }

  @override
  void deactivate() {
    timer.cancel();
    super.deactivate();
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
            FittedBox(
                child: SizedBox(
                  width: 10 * distCoef,
                  height: 10 * distCoef,
                  child: CustomPaint(
                    painter: SolarSystemPainter(timeCoef, t),
                  ),
                )
            ),
            Slider(
                value: distCoef,
                label: 'Distance Coefficient',
                max: 100,
                min: 10,
                onChanged: (newDistCoef) => setState(() => distCoef = newDistCoef),
            ),
            Slider(
              value: timeCoef,
              label: 'Time Coefficient',
              max: 10,
              min: 0.1,
              onChanged: (newTimeCoef) => setState(() => timeCoef = newTimeCoef),
            )
          ],
        )
      ),
    );
  }
}
