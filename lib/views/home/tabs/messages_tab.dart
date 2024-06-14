import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medics/styles/color_constants.dart';
import 'package:medics/styles/text_style.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../../../config/app_assets.dart';
import '../../../models/message.dart';
import '../../../routes/app_pages.dart';
import '../home_controller.dart';
import 'messages_controller.dart';

class MessagesView extends StatelessWidget {
  final MessageController _messageController = Get.put(MessageController());
  final HomeController controller = Get.find();

  MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          title: Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Messages', style: AppTextStyles.heading1),
                SvgPicture.asset(SVGAssets.icon_search_large),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              // padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: colorSecondary),
              child: const TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                indicatorColor: Colors.transparent,
                unselectedLabelColor: color5555,
                labelColor: whiteColor,
                indicator: BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                tabs: [
                  Tab(text: 'All'),
                  Tab(text: 'Group'),
                  Tab(text: 'Private'),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: whiteColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: TabBarView(
            children: [
              _buildMessageList(_messageController.getAllMessages()),
              _buildMessageList(_messageController.getGroupMessages()),
              _buildMessageList(_messageController.getPrivateMessages()),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            // ZIMKit().connectUser(id: '987654321', name: 'priyanka', avatarUrl: AppAssets.profileImage);
            // ZIMKit().connectUser(id: '91',name: 'Dr. Alysa Hana ',avatarUrl: AppAssets.drDiandra);
            // ZIMKit().connectUser(id: '3456789',name: 'Dr. Maria Elena',avatarUrl: AppAssets.drMaria);
            // ZIMKit().connectUser(id: '456789',name: 'Dr. Marcus Horizon',avatarUrl: AppAssets.drMarcus);
            // ZIMKit().connectUser(id: '92',name: 'Dr. Stefi Jessi',avatarUrl: AppAssets.drStefi);
            // ZIMKit().connectUser(id: '789',name: 'Dr. Gerty Cori',avatarUrl: AppAssets.drGerty);
            ZIMKit().connectUser(id: '56789',name: 'Priyanka Makwana',avatarUrl: AppAssets.profileImage);

            Get.toNamed(Routes.chat_list);
          },
          backgroundColor: colorPrimary,
          child: SvgPicture.asset(SVGAssets.icon_chat_filled),
        ),
      ),
    );
  }

  Widget _buildMessageList(List<Message> messages) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return _buildMessageCard(
          message,
          onTap: () {
            print(message.doctorName);
            Get.toNamed(Routes.chat_doctor,
                arguments: controller.getDoctorData(message.doctorName));
          },
        );
      },
    );
  }

  Widget _buildMessageCard(Message message, {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () => onTap(),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(message.doctorImage),
              radius: 25,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.doctorName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    message.lastMessage,
                    style: const TextStyle(
                      fontSize: 14,
                      color: colorGray,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message.time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: colorGray,
                  ),
                ),
                if (!message.isRead)
                  const Icon(
                    Icons.circle,
                    size: 10,
                    color: colorPrimary,
                  ),
                if (message.isRead)
                  const Icon(
                    Icons.done_all,
                    size: 14,
                    color: colorGray,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
