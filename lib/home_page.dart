import 'package:flutter/material.dart';
import 'labs/lab5.dart';
import 'labs/lab1.dart';
import 'labs/lab2.dart';
import 'labs/lab4.dart';
import 'labs/lab6.dart';
import 'labs/lab7.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page | Nikolay Dorofeev'),
      ),
      body: Container(
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Lab2(title: 'Lab 2 | Nikolay Dorofeev'))
                  );
                },
                child: Text('Lab 2')
            ),
            OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Lab3(title: 'Lab 3 | Nikolay Dorofeev'))
                  );
                },
                child: Text('Lab 3')
            ),
            OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Lab4(title: 'Lab 4 | Nikolay Dorofeev'))
                  );
                },
                child: Text('Lab 4')
            ),
            OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Lab5(title: 'Lab 5 | Nikolay Dorofeev'))
                  );
                },
                child: Text('Lab 5')
            ),
            OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Lab6(title: 'Lab 6 | Nikolay Dorofeev'))
                  );
                },
                child: Text('Lab 6')
            ),
            OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Lab7(title: 'Lab 7 | Nikolay Dorofeev'))
                  );
                },
                child: Text('Lab 7')
            ),
          ],
        ),
      ),
    );
  }
}

