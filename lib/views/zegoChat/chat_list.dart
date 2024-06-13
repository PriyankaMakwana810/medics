import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../../config/app_assets.dart';
import '../../styles/color_constants.dart';
import '../../styles/text_style.dart';
import 'chat_list_controller.dart';

class ChatListView extends GetView<ChatListController> {
  const ChatListView({super.key});

  // final String userName;

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
        body: Container(
          color: whiteColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            child: TabBarView(
              children: [
                ZIMKitConversationListView(
                  emptyBuilder: (context, defaultWidget) {
                    return _emptyView();
                  },
                  theme: ThemeData(),
                  itemBuilder: (context, conversation, defaultWidget) {
                    return _buildMessageCard(context, conversation);
                  },
                ),
                ZIMKitConversationListView(
                  filter: (context, conversationList) {
                    // Only include peer-to-peer conversations (individual chats)
                    return conversationList.where((conversation) {
                      return conversation.value.type ==
                          ZIMConversationType.group;
                    }).toList();
                  },
                  emptyBuilder: (context, defaultWidget) {
                    return _emptyView();
                  },
                  itemBuilder: (context, conversation, defaultWidget) {
                    return _buildMessageCard(context, conversation);
                  },
                ),
                ZIMKitConversationListView(
                  filter: (context, conversationList) {
                    // Only include peer-to-peer conversations (individual chats)
                    return conversationList.where((conversation) {
                      return conversation.value.type ==
                          ZIMConversationType.peer;
                    }).toList();
                  },
                  emptyBuilder: (context, defaultWidget) {
                    return _emptyView();
                  },
                  itemBuilder: (context, conversation, defaultWidget) {
                    return _buildMessageCard(context, conversation);
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            // controller.showNewChatDialog(context);
            // ZIMKit().showDefaultNewGroupChatDialog(context);
            // ZIMKit().createGroup();
          },
          backgroundColor: colorPrimary,
          child: SvgPicture.asset(SVGAssets.icon_chat_filled),
        ),
      ),
    );
  }

  Widget _buildMessageCard(
      BuildContext context, ZIMKitConversation conversation) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () {
          // ZIMKit().deleteConversation(conversation.id, conversation.type);
          controller.openChat(context, conversation);
        },
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(conversation.avatarUrl),
              radius: 25,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    conversation.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    conversation.lastMessage?.toStringValue() ??
                        'no last message ',
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
                defaultLastMessageTimeBuilder(
                    DateTime.fromMillisecondsSinceEpoch(
                  conversation.lastMessage!.info.timestamp,
                )),
                if (conversation.unreadMessageCount != 0)
                  const Icon(
                    Icons.circle,
                    size: 10,
                    color: colorPrimary,
                  ),
                if (conversation.unreadMessageCount == 0)
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

  Widget _emptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssets.emptyCart, width: 150, height: 150),
          const SizedBox(height: 20),
          const Text(
            'No messages yet',
            style: TextStyle(
                fontSize: 18, color: textColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget defaultLastMessageTimeBuilder(DateTime? messageTime) {
    if (messageTime == null) {
      return const SizedBox.shrink();
    }

    final now = DateTime.now();
    final duration = DateTime.now().difference(messageTime);

    late String timeStr;

    if (duration.inMinutes < 1) {
      timeStr = 'just now';
    } else if (duration.inHours < 1) {
      timeStr = '${duration.inMinutes} mins ago';
    } else if (duration.inDays < 1) {
      timeStr = '${duration.inHours} hrs ago';
    } else if (now.year == messageTime.year) {
      timeStr =
          '${messageTime.month}/${messageTime.day} ${messageTime.hour}:${messageTime.minute}';
    } else {
      timeStr =
          ' ${messageTime.year}/${messageTime.month}/${messageTime.day} ${messageTime.hour}:${messageTime.minute}';
    }

    return Opacity(
      opacity: 0.64,
      child: Text(timeStr, maxLines: 1, overflow: TextOverflow.clip),
    );
  }
}
