import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medics/styles/color_constants.dart';

import '../controller/toggle_controller.dart';

class AnimatedToggle extends StatelessWidget {
  final List<String> values;
  final ValueChanged<int> onToggleCallback;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;

  AnimatedToggle({
    Key? key,
    required this.values,
    required this.onToggleCallback,
    this.backgroundColor = const Color(0xFFe7e7e8),
    this.buttonColor = const Color(0xFFFFFFFF),
    this.textColor = const Color(0xFF000000),
  }) : super(key: key);

  final ToggleController toggleController = Get.put(ToggleController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ToggleController>(
      builder: (_) {
        return Container(
          width: double.infinity,
          height: Get.width * 0.13,
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  toggleController.toggle();
                  var index = toggleController.initialPosition ? 0 : 1;
                  onToggleCallback(index);
                },
                child: Container(
                  width: double.infinity,
                  height: Get.width * 0.13,
                  decoration: ShapeDecoration(
                    color: backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Get.width * 0.1),
                      side: const BorderSide(color: textColorDisable),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      values.length,
                          (index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                        child: Text(
                          values[index],
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: Get.width * 0.045,
                            fontWeight: FontWeight.bold,
                            color: textColorDisable,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                curve: Curves.decelerate,
                alignment: toggleController.initialPosition
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(4),
                  width: Get.width * 0.45,
                  height: Get.width * 0.12,
                  decoration: ShapeDecoration(
                    color: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Get.width * 0.1),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    toggleController.initialPosition
                        ? values[0]
                        : values[1],
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: Get.width * 0.045,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
