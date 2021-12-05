import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:flutter/material.dart';

class SolarSystemPainter extends CustomPainter{
  final distCoef = 50;
  final timeCoef;
  final t;

  SolarSystemPainter(this.timeCoef, this.t);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromPoints(Offset(0,0), Offset(size.width, size.height)), Paint()..color = Colors.blueGrey);
    //Ставим центр системы в центр окна
    final center = Offset(size.width / 2, size.height / 2);

    //Ставим планету на позицию в зависимости от времени
    void drawPlanet(double radius, Paint atmosphere, double distance){
      //Поправка на период обращения планет по упрощённому 3 закону Кепплера
      double velocity = 0;
      if (distance > 0) velocity = 1.0/sqrt(pow(distance, 3));
      final planetCenter = Offset(
          center.dx + distance * cos(t * timeCoef * velocity) * distCoef,
          center.dy - distance * sin(t * timeCoef * velocity) * distCoef
      );

      canvas.drawCircle(planetCenter, radius, atmosphere);
    }

    // Sun
    drawPlanet(15, Paint()..color = Colors.yellow, 0);
    // Mercury
    drawPlanet(2.5, Paint()..color = Colors.brown, 0.4);
    // Venus
    drawPlanet(3.5, Paint()..color = Colors.orangeAccent, 0.7);
    // Earth
    drawPlanet(5, Paint()..color = Colors.lightBlue, 1);
    // Mars
    drawPlanet(4, Paint()..color = Colors.red, 1.6);
    // Jupiter
    drawPlanet(7.5, Paint()..color = Colors.brown, 5.2);
    // Saturn
    drawPlanet(6.5, Paint()..color = Colors.orangeAccent, 10);
    // Uranus
    drawPlanet(6.5, Paint()..color = Colors.white38, 19.6);
    // Neptune
    drawPlanet(7, Paint()..color = Colors.lightBlueAccent, 30);

  }

  // Перерисовывем всегда
  @override
  bool shouldRepaint(covariant SolarSystemPainter old) => old.t != t;


  @override
  bool shouldRebuildSemantics(SolarSystemPainter oldDelegate) => false;
  
}