import 'package:flutter/material.dart';
import 'package:tpu_mobile_labs/support/lab6/createItemWidget.dart';
import 'package:tpu_mobile_labs/support/lab6/item.dart';
import 'package:tpu_mobile_labs/support/math_train.dart';
import 'dart:math';

Random rand = Random();


class Lab6 extends StatefulWidget {
  Lab6({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _Lab6State createState() => _Lab6State();
}

class _Lab6State extends State<Lab6> {

  late List<Item> _items = [];

  void _createItem(BuildContext context) async {
    final Item newItem = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateItemWidget(title: "+ Item | Nikolay Dorofeev"))
    );
    setState(() {
      _items.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createItem(context);
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: const EdgeInsets.all(30),
                child: Text(
                  "Grocery list",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                )
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: this._items.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                      height: 50,
                      child: Center(child: Text(_items[index].info))
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
