// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geofencing/Widgets/loading_widget.dart';
import 'package:geolocator/geolocator.dart';

class LocationServices extends ChangeNotifier {
  late bool serviceEnabled;
  late LocationPermission permission;
  Position? currentLocation;
  List<Placemark> placeMarks = [];
  Placemark? placeMark;

  Future<void> requestLocationPermission(BuildContext context) async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  Future<void> getCurrentLocation(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingWidget(),
    );
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      currentLocation = await Geolocator.getCurrentPosition();
      placeMarks = await placemarkFromCoordinates(
        currentLocation!.latitude,
        currentLocation!.latitude,
        localeIdentifier: 'en',
      );
      placeMark = placeMarks[0];
    } else {
      requestLocationPermission(context);
    }
    notifyListeners();
    Navigator.of(context).pop();
  }

  Future<void> listenCurrentLocation(BuildContext context) async {
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 50,
      );
      Geolocator.getPositionStream(locationSettings: locationSettings).listen(
        (Position? position) async {
          currentLocation = position;
          placeMarks = await placemarkFromCoordinates(
            currentLocation!.latitude,
            currentLocation!.longitude,
            localeIdentifier: 'en',
          );
          placeMark = placeMarks[0];
          notifyListeners();
        },
      );
    } else {
      requestLocationPermission(context);
    }
    notifyListeners();
  }
}
