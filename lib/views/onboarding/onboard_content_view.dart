import 'package:flutter/cupertino.dart';
import 'package:medics/styles/color_constants.dart';


class OnBoardContent extends StatelessWidget {
  final String image;
  final String heading;

  const OnBoardContent({
    super.key,
    required this.image,
    required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const Spacer(),
        Image.asset(image),
        const SizedBox(height: 30),
        Text(
          heading,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: blackColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        // const Spacer(),
        const Spacer(),
      ],
    );
  }
}
