import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_map_getx_demo/view_model/location_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/location_model.dart';
import 'location_point_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LocationController controller = Get.put(LocationController());

  Set<Marker> markers = HashSet<Marker>();
  GoogleMapController? googleMapController;
  Position? position;

  myLocation() async {
    position = await _getPosition();
    googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                position?.latitude as double, position?.longitude as double),
            zoom: 14)));
    markers.clear();
    markers.add(Marker(
        markerId: const MarkerId("currentLocation"),
        draggable: true,
        infoWindow: const InfoWindow(title: "divyang", snippet: 'test'),
        position: LatLng(
            position?.latitude as double, position?.longitude as double)));
    setState(() {});
  }

  Future<Position> _getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Please unable location permission");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Please unable location permission");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Please unable location permission");
    }
    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  _onMapCreated(GoogleMapController controller) {
    googleMapController = controller;

    setState(() {
      markers.add(
          const Marker(markerId: MarkerId('0'), position: LatLng(37, -122)));
    });
  }

  @override
  void initState() {
    super.initState();
    myLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.save),
          onPressed: () => controller.addData(
              location: LocationData(
                  latitude: position?.latitude as double,
                  longitude: position?.longitude as double)),
        ),
        actions: [
          IconButton(
              onPressed: () =>
                  // Get.toNamed("/second"),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LocationList()),
                  ),
              icon: const Icon(Icons.list))
        ],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: markers,
        initialCameraPosition:
            const CameraPosition(target: LatLng(37, -122), zoom: 12),
      ),
    );
  }
}
