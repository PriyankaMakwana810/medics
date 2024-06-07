import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medics/controller/base_controller.dart';
import 'package:medics/styles/color_constants.dart';

class MapController extends BaseController {
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  var currentPosition = LatLng(23.0225, 72.5714).obs;
  var address = 'Fetching address...'.obs;
  var markers = <Marker>[].obs;
  var circles = <Circle>[].obs;
  var polylines = <Polyline>[].obs;

  @override
  void onInit() {
    super.onInit();
    _getUserCurrentLocation();
  }

  Future<void> _getUserCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition.value = LatLng(position.latitude, position.longitude);
    _updateMarkerAndCircle(currentPosition.value);
    // _updateMarker(currentPosition.value);
    await _getAddressFromLatLng(currentPosition.value);
    // Optionally, you can fetch the address from coordinates here
    // address.value = 'Your current address'; // Update with actual address
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: currentPosition.value, zoom: 16),
    ));
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      address.value =
          "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
    } catch (e) {
      address.value = "Address not found";
    }
  }

  void _updateMarkerAndCircle(LatLng position) {
    markers.clear();
    circles.clear();
    polylines.clear();

    markers.add(Marker(
      markerId: MarkerId('currentLocation'),
      position: position,
      icon: BitmapDescriptor.defaultMarkerWithHue(160.0),
      // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(title: 'Current Location'),
    ));
    circles.add(Circle(
      circleId: CircleId('radius'),
      center: position,
      radius: 500,
      fillColor: Colors.transparent,
      strokeColor: colorPrimary,
      strokeWidth: 2,
    ));
    polylines.add(Polyline(
      polylineId: PolylineId('radiusLine'),
      points: _createCirclePoints(position, 500),
      color: colorPrimary,
      width: 2,
    ));
  }

  List<LatLng> _createCirclePoints(LatLng center, double radius) {
    final List<LatLng> circlePoints = [];
    const int degrees = 360;
    const int numberOfPoints = 100;
    for (int i = 0; i <= degrees; i += degrees ~/ numberOfPoints) {
      final double theta = (i * 3.141592653589793 / 180.0);
      final double dx = radius * math.cos(theta);
      final double dy = radius * math.sin(theta);
      circlePoints.add(LatLng(
          center.latitude + dx / 111320,
          center.longitude +
              dy /
                  (111320 *
                      math.cos(center.latitude * 3.141592653589793 / 180.0))));
    }
    return circlePoints;
  }

  void onMapTap(LatLng position) async {
    currentPosition.value = position;
    _updateMarkerAndCircle(position);
    await _getAddressFromLatLng(position);
  }
}
