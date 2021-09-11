import 'package:flutter/material.dart';
import 'labs/lab1.dart';
import 'labs/lab2.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page | Nikolay Dorofeev'),
      ),
      body: Container(
        child: Row(
          children: [
            OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Lab1(title: 'Lab1 Nikolay Dorofeev'))
                  );
                },
                child: Text('Lab 1')
            ),
            OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Lab2(title: 'Lab2 Nikolay Dorofeev'))
                  );
                },
                child: Text('Lab 2')
            )
          ],
        ),
      ),
    );
  }
}

