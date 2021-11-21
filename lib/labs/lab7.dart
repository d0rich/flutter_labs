import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:tpu_mobile_labs/support/lab7/location_point.dart';

class Lab7 extends StatefulWidget {
  Lab7({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _Lab7State createState() => _Lab7State();
}

class _Lab7State extends State<Lab7> {
  late TextEditingController _latController = TextEditingController();
  late TextEditingController _longController = TextEditingController();
  late TextEditingController _nameController = TextEditingController();
  late List<LocationPoint> _points = [];

  late Location _locationService = new Location();
  late LocationPoint _locationData = new LocationPoint(lat: 0, long: 0, name: "name");

  // Проверка на разрешение геолокации
  Future<bool> _checkLocationServiceStatus() async{
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationService.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationService.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }

    _permissionGranted = await _locationService.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationService.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }

    return _serviceEnabled && (_permissionGranted == PermissionStatus.granted);

  }

  void _getLocation() async{
    if (! await _checkLocationServiceStatus()) return;
    LocationData newLok = await _locationService.getLocation();

    setState(() {
      _locationData = new LocationPoint(lat: newLok.latitude!, long: newLok.longitude!, name: "name");
    });
  }

  void _checkNearObjects() async{
    if (! await _checkLocationServiceStatus()) return;

  }

  void _addPoint() {
    setState(() {
      this._points.add(new LocationPoint(
          lat: double.parse(_latController.text),
          long: double.parse(_longController.text),
          name: _nameController.text
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("lat: " + _locationData.lat.toString() + ", long: " + _locationData.long.toString()),
            TextField(
              controller: this._latController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Latitude',
              ),
              keyboardType: TextInputType.number
            ),
            TextField(
              controller: this._longController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Longitude'
              ),
              keyboardType: TextInputType.number
            ),
            TextField(
              controller: this._nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name'
              ),
              keyboardType: TextInputType.text
            ),
            Center(
              child: Row(
                children: [
                    OutlinedButton(
                    onPressed: this._addPoint,
                    child: Icon(Icons.add)
                    ),
                ]
              )
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: this._points.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                      height: 50,
                      color: Colors.amber[300],
                      child: Center(child: Text(this._points[index].toString()))
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
              ),
            )
          ]
        ),
      ),
    );
  }
}
