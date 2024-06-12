import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medics/custom_widgets/button.dart';

import '../styles/color_constants.dart';
import '../styles/text_style.dart';
import 'map_controller.dart';

class MapAmbulanceView extends StatelessWidget {
  final MapController mapController = Get.put(MapController());

  MapAmbulanceView({Key? key}) : super(key: key);

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
      body: Stack(
        children: [
          Obx(
            () => GoogleMap(
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: mapController.currentPosition.value,
                zoom: 16,
              ),
              onMapCreated: (GoogleMapController controller) {
                mapController.mapController.complete(controller);
              },
              onTap: (LatLng position) {
                mapController.onMapTap(position);
              },
              markers: mapController.markers.toSet(),
              circles: mapController.circles.toSet(),
              polylines: mapController.polylines.toSet(),
            ),
          ),
          Positioned(
            top: 20,
            left: 15,
            right: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search location, ZIP code...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 15,
            right: 15,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Confirm your address',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() => Text(
                        mapController.address.value,
                        style: const TextStyle(fontSize: 14),
                      )),
                  const SizedBox(height: 10),
                  CustomFilledButton(onPressed: () {}, label: 'Confirm Location')
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Handle confirm location action
                  //   },
                  //   child: Text('Confirm Location'),
                  //   style: ElevatedButton.styleFrom(
                  //     primary: colorPrimary,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     minimumSize: Size(double.infinity, 50),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
