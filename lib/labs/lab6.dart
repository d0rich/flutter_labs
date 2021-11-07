import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tpu_mobile_labs/support/lab6/createItemWidget.dart';
import 'package:tpu_mobile_labs/support/lab6/item.dart';
import 'dart:math';

import 'package:tpu_mobile_labs/support/lab6/itemModel.dart';

Random rand = Random();

class Lab6 extends StatefulWidget {
  Lab6({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _Lab6State createState() => _Lab6State();
}

class _Lab6State extends State<Lab6> {

  late List<Item> _items = [];

  Future<Database> _db() async{
    return await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
        join(await getDatabasesPath(), 'items_database.db'),
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
      'CREATE TABLE items( '
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'kind TEXT, '
      'title TEXT, '
      'price REAL, '
      'weight REAL, '
      'photo TEXT '
      ')',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
    );
  }
  void fetchItems() async{
    final db = await _db();
    final List<Map<String, dynamic>> maps = await db.query('items');
    setState(() {
      _items = List.generate(maps.length, (index) => Item.fromMap(maps[index]));
    });
  }

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  void _createItem(BuildContext context) async {
    final Item newItem = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateItemWidget(title: "+ Item | Nikolay Dorofeev"))
    );
    final db = await _db();
    await db.insert('items', ItemModel.fromItem(newItem).toMap());
    fetchItems();
  }

  void Function()? _deleteItem(BuildContext context, int id){
    return () => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Confirm action"),
          content: Text("Are you sure to delete item?"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel")
            ),
            TextButton(
                onPressed: () async {
                  final db = await _db();
                  await db.delete(
                      'items',
                      where: 'id = ?',
                    whereArgs: [id]
                  );
                  fetchItems();
                  Navigator.pop(context);
                },
                child: Text("Confirm")
            ),

          ],
        )
    );
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
                      child: Row(
                        children: [
                          Image.file(File(_items[index].photo)),
                          Center(child: Text(_items[index].info)),
                          OutlinedButton(
                              onPressed: _deleteItem(context, _items[index].id),
                              child: Icon(Icons.cancel)
                          )
                        ],
                      )

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
