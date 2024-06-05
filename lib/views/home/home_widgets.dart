import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medics/styles/color_constants.dart';

import '../../models/article.dart';
import '../../models/doctor.dart';
import '../../styles/text_style.dart';

Widget buildDoctorCard(Doctor doctor, {required VoidCallback onTap}) {
  return Padding(
    padding: const EdgeInsets.only(right: 16),
    child: InkWell(
      onTap: () => onTap(),
      child: Container(
        width: 130,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colorSecondary, width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
                radius: 40, // Image radius
                backgroundImage: AssetImage(doctor.image)),
            // Image.network(imageUrl, width: 150, height: 100, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doctor.name,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  Text(doctor.designation,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: colorGray)),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 4, right: 4, top: 1, bottom: 1),
                        decoration: BoxDecoration(
                            color: colorSecondary,
                            borderRadius: BorderRadius.circular(6),
                            border:
                                Border.all(color: colorSecondary, width: 1)),
                        child: Row(
                          children: [
                            const Icon(Icons.star_outlined,
                                color: colorPrimary, size: 10),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              doctor.rate,
                              style: const TextStyle(
                                  color: colorPrimary, fontSize: 8),
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.location_on, color: colorGray, size: 10),
                      Text(doctor.distance,
                          style:
                              const TextStyle(color: colorGray, fontSize: 8)),
                    ],
                  ),
                  // SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildArticleCard(Article article, {VoidCallback? onTap}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: InkWell(
      onTap: () => onTap,
      child: Container(
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: colorSecondary, width: 1)),
        // margin: EdgeInsets.only(bottom: 10),
        child: ListTile(
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(article.imageUrl,
                    width: 60, height: 60, fit: BoxFit.fill)),
            title: Text(article.title,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    article.time,
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: colorGray),
                  ),
                  const Text(
                    " • ",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: colorGray),
                  ),
                  Text(
                    article.timeToRead,
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: colorPrimary),
                  ),
                ],
              ),
            ),
            trailing: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.bookmark,
                  color: colorPrimary,
                ),
              ],
            )
            /*Text(
              description,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w500, color: colorGray),
            ),*/
            ),
      ),
    ),
  );
}

Widget buildSectionHeader(String title, {VoidCallback? onTap}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: AppTextStyles.mediumTextStyle,
      ),
      TextButton(
        onPressed: onTap,
        child: const Text(
          'See all',
          style: AppTextStyles.textButtonStyle,
        ),
      ),
    ],
  );
}

Widget buildCategoryIcon(String icon, String label,
    {required Function() onTap}) {
  return InkWell(
    onTap: () => onTap(),
    // controller.onCategoryTap(label),
    child: Column(children: [
      Container(
        height: 66,
        width: 64,
        decoration: BoxDecoration(
            color: headerBackground, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: SvgPicture.asset(icon),
        ),
      ),
      const SizedBox(height: 10.0),
      Text(label, style: AppTextStyles.bodyHome),
    ]),
  );
}

Widget buildBannerAd(String title, String btnText, String imgPath) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
        color: colorSecondary, borderRadius: BorderRadius.circular(10)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: textColor)),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {},
                  style:
                      ElevatedButton.styleFrom(backgroundColor: colorPrimary),
                  child: Text(
                    btnText,
                    style: TextStyle(color: whiteColor),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
            constraints: BoxConstraints(maxWidth: 130),
            child: Image.asset(imgPath)),
      ],
    ),

  );
}
