import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medics/styles/color_constants.dart';
import 'package:medics/styles/text_style.dart';

import '../../config/app_assets.dart';
import '../../config/app_dimention.dart';
import '../../models/chat_message.dart';
import '../../models/doctor.dart';
import 'chat_controller.dart';

class ChatView extends StatelessWidget {
  final ChatController _chatController = Get.put(ChatController());
  final Doctor doctor = Get.arguments as Doctor;

  ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(doctor.name, style: AppTextStyles.appBarStyle),
        actions: [
          IconButton(
            icon: SvgPicture.asset(SVGAssets.icon_phone),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset(SVGAssets.icon_video),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset(SVGAssets.icon_more),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: whiteColor,
      body: Column(
        children: [
          buildConsultationStartView(),
          Expanded(
            child: Obx(
              () => ListView.builder(
                reverse: true,
                itemCount: _chatController.messages.length,
                itemBuilder: (context, index) {
                  final message =
                      _chatController.messages.reversed.toList()[index];
                  return _buildMessageItem(message);
                },
              ),
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }



  Widget _buildMessageItem(ChatMessage message) {
    return Align(
      alignment:
          message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isSentByMe)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(doctor.image),
                    radius: 20,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        message.timestamp,
                        style: const TextStyle(
                          fontSize: 12,
                          color: textColorDisable,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            padding: const EdgeInsets.all(10),
            // width: Dimensions.screenWidth/1.5,
            constraints: BoxConstraints(maxWidth: Dimensions.screenWidth / 1.4),
            decoration: BoxDecoration(
              color: message.isSentByMe ? colorPrimary : colorSecondary,
              borderRadius: message.isSentByMe
                  ? const BorderRadius.only(
                      topRight: Radius.zero,
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))
                  : const BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.zero,
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: message.isSentByMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                // if (!message.isSentByMe) const SizedBox(height: 5),
                Text(
                  message.message,
                  style: TextStyle(
                    color: message.isSentByMe ? whiteColor : color5555,
                  ),
                ),
                if (message.isSentByMe) SvgPicture.asset(SVGAssets.icon_read)
                // Icon(Icons.check, size: 14, color: whiteColor)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    final TextEditingController messageController = TextEditingController();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: messageController,
              cursorColor: colorPrimary,
              style: const TextStyle(
                  fontSize: Dimensions.fontSizeDefault,
                  color: textColor,
                  fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                hintText: "Type message...",
                suffixIcon: const Icon(Icons.attach_file_rounded,
                    color: textColorDisable),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: Dimensions.kPaddingSizeDefault,
                    horizontal: Dimensions.kPaddingSizeLarge),
                hintStyle: const TextStyle(
                    fontSize: Dimensions.fontSizeDefault,
                    color: textColorDisable),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: colorSecondary),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: colorPrimary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: colorSecondary),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          InkWell(
            onTap: () {
              if (messageController.text.trim().isNotEmpty) {
                _chatController.sendMessage(messageController.text.trim());
                messageController.clear();
              }
            },
            child: Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                color: colorPrimary,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: Text(
                  'Send',
                  style: TextStyle(
                    fontSize: 14,
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
    );
  }
}
Widget buildConsultationStartView() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorSecondary, width: 1)),
      padding: const EdgeInsets.all(16),
      child: const Column(
        children: [
          Text(
            'Consultation Start',
            style: TextStyle(
              color: colorPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'You can consult your problem to the doctor',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: colorGray),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}