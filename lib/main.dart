import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Coordinates',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String address = '283, Jawaharalal Nehru Road,Sivakasi-626123';
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Coordinates'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Address: $address',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Latitude: $latitude',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Longitude: $longitude',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                getLocationCoordinates();
              },
              child: Text('Get Coordinates'),
            ),
          ],
        ),
      ),
    );
  }

  void getLocationCoordinates() async {
    try {
      List<geocoding.Location> locations =
          await geocoding.locationFromAddress(address);
      if (locations.isNotEmpty) {
        setState(() {
          latitude = locations.first.latitude;
          longitude = locations.first.longitude;
        });
      } else {
        setState(() {
          latitude = 0.0;
          longitude = 0.0;
        });
        print('No location found for the provided address');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
