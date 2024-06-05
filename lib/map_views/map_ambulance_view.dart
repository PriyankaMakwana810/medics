import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../styles/color_constants.dart';
import '../styles/text_style.dart';

class MapAmbulanceView extends StatelessWidget {
  MapAmbulanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text(
          "Ambulance",
          style: AppTextStyles.appBarStyle,
        ),
        centerTitle: true,
      ),
      // backgroundColor: whiteColor,
      body: GoogleMap(
          initialCameraPosition:
              CameraPosition(target: LatLng(23.0225, 72.5714),
                zoom: 12,)),
    );
  }
}

