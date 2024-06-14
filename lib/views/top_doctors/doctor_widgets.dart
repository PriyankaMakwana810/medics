import 'package:flutter/material.dart';

import '../../models/doctor.dart';
import '../../styles/color_constants.dart';

Widget buildDoctorListCard(Doctor doctor, {required Function() onTap}) {
  return InkWell(
    onTap: () => onTap(),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorSecondary, width: 1)),
      // padding: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(doctor.image,
                  width: 100, height: 100, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doctor.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(doctor.designation,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: colorGray)),
                  const SizedBox(height: 8),
                  Container(
                    // width: Dimensions.screenWidth/10,
                    padding: const EdgeInsets.only(
                        left: 4, right: 4, top: 1, bottom: 1),
                    decoration: BoxDecoration(
                        color: colorSecondary,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: colorSecondary, width: 1)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_outlined,
                            color: colorPrimary, size: 10),
                        const SizedBox(width: 2),
                        Text(
                          doctor.rate,
                          style: const TextStyle(
                              color: colorPrimary, fontSize: 10),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: colorGray, size: 10),
                      Text(doctor.distance,
                          style:
                              const TextStyle(color: colorGray, fontSize: 10)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildDoctorHeaderCard(Doctor doctor, {required Function() onTap}) {
  return InkWell(
    onTap: () => onTap(),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorSecondary, width: 1)),
      // padding: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(doctor.image,
                  width: 50, height: 50, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doctor.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(doctor.designation,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: colorGray)),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
