import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medics/custom_widgets/button.dart';
import 'package:medics/styles/color_constants.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../config/app_dimention.dart';
import '../styles/text_style.dart';
import '../views/home/home_controller.dart';
import '../views/top_doctors/doctor_details_view.dart';
import '../views/zegoChat/chat_screen_view.dart';

class SuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onPressed;

  const SuccessDialog({
    super.key,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  Widget _buildChild(BuildContext context) => Container(
        height: 400,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                  color: headerBackground, shape: BoxShape.circle),
              child: const Icon(
                Icons.check,
                color: colorPrimary,
                size: 50,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: textColorDisable),
            ),
            const SizedBox(height: 24),
            CustomButton(label: buttonText, onPressed: onPressed),
          ],
        ),
      );
}

class LogoutDialog extends StatelessWidget {
  final VoidCallback onPressed;

  const LogoutDialog({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  Widget _buildChild(BuildContext context) => Container(
        height: 400,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                  color: headerBackground, shape: BoxShape.circle),
              child: const Icon(
                Icons.logout_outlined,
                color: colorPrimary,
                size: 50,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Are you sure to log out of your Account?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(label: 'Log Out', onPressed: onPressed),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
                Get.back(closeOverlays: true);
              },
              child: const Text(
                'Cancle',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: colorPrimary,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      );
}

class DeleteCustomDialog extends StatelessWidget {
  final VoidCallback onPressed;
  final String description;

  const DeleteCustomDialog({
    super.key,
    required this.onPressed,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: whiteColor,
      title: const Text(
        'Confirm Delete',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(description,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, color: textColorDisable)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
            style: AppTextStyles.subTitle,
          ),
        ),
        CustomButton(
          label: 'Delete',
          onPressed: onPressed,
          // onPressed: () {
          //   ZIMKit().deleteMessage([message]);
          //   Navigator.pop(context);
          // },
        ),
      ],
    );
  }
}

class DateTimeSelectionDialog extends StatelessWidget {
  const DateTimeSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Date and Time',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            buildDateSelector(),
            // const DateSelector(),
            const SizedBox(height: 20),
            const Text('Time', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            buildTimeSelector(),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  label: 'Confirm',
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChangeReasonDialog extends StatelessWidget {
  const ChangeReasonDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Provide a Valid Reason',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text('Reason', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: controller.reasonOfVisit.value,
              onChanged: (value) {
                controller.reasonOfVisit.value =
                    value; // Update the reason text as the user types
              },
              cursorColor: colorPrimary,
              style: const TextStyle(
                  fontSize: Dimensions.fontSizeDefault,
                  color: textColor,
                  fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                filled: true,
                fillColor: textFieldFilled,
                hintText: 'Enter reason',
                hintStyle: const TextStyle(
                    fontSize: Dimensions.fontSizeDefault,
                    color: textColorDisable),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: Dimensions.kPaddingSizeDefault,
                    horizontal: Dimensions.kPaddingSizeLarge),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: textColorDisable),
                ),
                // focusColor: colorOnPrimary,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: textColorDisable),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: textColorDisable),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          fontSize: 16,
                          color: whiteColor,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NewChatDialog extends StatelessWidget {
  const NewChatDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Doctor you want to chat with:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(controller.doctors.length, (index) {
                    final doctor = controller.doctors[index];
                    return GestureDetector(
                      onTap: () {
                        controller.selectedDrChat(index);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        width: MediaQuery.of(context).size.width / 1.5,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: controller.selectedDrChat == index
                                    ? colorPrimary
                                    : colorSecondary,
                                width: 1)),
                        // padding: EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(doctor.image,
                                    width: 50, height: 50, fit: BoxFit.cover),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(doctor.name,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Text(doctor.designation,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: colorGray)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  label: 'Confirm',
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return ChatScreenView(
                          conversationID: controller
                              .doctors[controller.selectedDrChat.value].userId);
                    }));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ShowNewGroupChatDialog extends StatelessWidget {
  final HomeController controller = Get.find();
  final groupIDController = TextEditingController();
  final groupNameController = TextEditingController();
  final groupUsersController = TextEditingController();

  ShowNewGroupChatDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: whiteColor,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create Group:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text('Group Name:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextFormField(
                controller: groupNameController,
                cursorColor: colorPrimary,
                style: const TextStyle(
                    fontSize: Dimensions.fontSizeDefault,
                    color: textColor,
                    fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: textFieldFilled,
                  hintText: 'Enter group name',
                  hintStyle: const TextStyle(
                      fontSize: Dimensions.fontSizeDefault,
                      color: textColorDisable),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: Dimensions.kPaddingSizeDefault,
                      horizontal: Dimensions.kPaddingSizeLarge),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: textColorDisable),
                  ),
                  // focusColor: colorOnPrimary,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: textColorDisable),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: textColorDisable),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Group Id(optional):',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextFormField(
                controller: groupIDController,
                cursorColor: colorPrimary,
                style: const TextStyle(
                    fontSize: Dimensions.fontSizeDefault,
                    color: textColor,
                    fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: textFieldFilled,
                  hintText: 'Enter group Id',
                  hintStyle: const TextStyle(
                      fontSize: Dimensions.fontSizeDefault,
                      color: textColorDisable),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: Dimensions.kPaddingSizeDefault,
                      horizontal: Dimensions.kPaddingSizeLarge),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: textColorDisable),
                  ),
                  // focusColor: colorOnPrimary,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: textColorDisable),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: textColorDisable),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Select Doctors you want to Add to Group:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () {
                  return Wrap(
                    alignment: WrapAlignment.start,
                    runSpacing: 8,
                    spacing: 8,
                    children: List.generate(
                      controller.doctors.length,
                      (index) {
                        final doctor = controller.doctors[index];
                        final isSelected = controller.isDoctorSelected(index);
                        return GestureDetector(
                          onTap: () {
                            controller.toggleDoctorSelection(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected ? colorPrimary : whiteColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.transparent
                                    : chipBorder,
                              ),
                            ),
                            // margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Text(
                              doctor.name,
                              style: TextStyle(
                                color: isSelected ? whiteColor : textColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    label: 'Confirm',
                    onPressed: () {
                      if (groupNameController.text.isNotEmpty &&
                          controller.groupMembers.isNotEmpty) {
                        ZIMKit()
                            .createGroup(
                          groupNameController.text,
                          controller.groupMembers,
                          id: groupIDController.text,
                        )
                            .then((String? conversationID) {
                          if (conversationID != null) {
                            Navigator.of(context).pop(true);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ChatScreenView(
                                conversationID: conversationID,
                                conversationType: ZIMConversationType.group,
                              );
                            }));
                          }
                        });
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
