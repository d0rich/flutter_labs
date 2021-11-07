import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tpu_mobile_labs/support/lab6/item.dart';
import 'package:tpu_mobile_labs/support/lab6/takePictureScreen.dart';

class CreateItemWidget extends StatefulWidget {
  CreateItemWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CreateItemWidgetState createState() => _CreateItemWidgetState();
}

class _CreateItemWidgetState extends State<CreateItemWidget> {
  late TextEditingController _kindController = TextEditingController();
  late TextEditingController _titleController = TextEditingController();
  late TextEditingController _priceController = TextEditingController();
  late TextEditingController _weightController = TextEditingController();
  late String _photoPath = '';

  void _returnItem(){
    if (_kindController.text == ""
        || _titleController.text == ""
        || _priceController.text == ""
        || _weightController.text == "") {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text("Not enough info."),
            content: Text("Please fill all fields"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Confirm"))
            ],
          )
      );
      return;
    }
    Navigator.pop(context,
        new Item(
          _kindController.text,
          _titleController.text,
          double.parse(_priceController.text),
          double.parse(_weightController.text),
          _photoPath
        )
    );
  }

  Future<void> _takePhoto() async {
    // Ensure that plugin services are initialized so that `availableCameras()`
    // can be called before `runApp()`
    WidgetsFlutterBinding.ensureInitialized();

    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;
    final String photoPath = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TakePictureScreen(camera: firstCamera,))
    );
    setState(() {
      _photoPath = photoPath;
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
      floatingActionButton: FloatingActionButton(
        onPressed: _returnItem,
        child: Icon(Icons.check),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.file(
                File(_photoPath),
              height: 200,
            ),
            TextField(
              controller: this._kindController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Kind'
              )
            ),
            TextField(
              controller: this._titleController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title'
              )
            ),
            TextField(
              controller: this._priceController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Price',
                suffixIcon: Text('₽')
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            TextField(
              controller: this._weightController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Weight',
                  suffixIcon: Text('g')
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            OutlinedButton(onPressed: _takePhoto, child: Icon(Icons.photo_camera))
          ],
        ),
      ),
    );
  }
}
