import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medics/utils/utility.dart';
import 'package:medics/views/zegoChat/audio_call_view.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../../config/app_assets.dart';
import '../../config/app_dimention.dart';
import '../../custom_widgets/button.dart';
import '../../styles/color_constants.dart';
import '../../styles/text_style.dart';
import 'call_view.dart';

class ChatScreenView extends StatelessWidget {
  const ChatScreenView(
      {super.key,
      required this.conversationID,
      this.conversationType = ZIMConversationType.peer});

  /// this page's conversationID
  final String conversationID;

  /// this page's conversationType
  final ZIMConversationType conversationType;

  // final String userName;
  @override
  Widget build(BuildContext context) {
    var conversation =
        ZIMKit().getConversation(conversationID, conversationType).value;
    return ZIMKitMessageListPage(
        appBarBuilder: (context, defaultAppBar) {
          return AppBar(
            backgroundColor: whiteColor,
            title: Text(
                conversation.name.isEmpty ? conversationID : conversation.name,
                style: AppTextStyles.appBarStyle),
            actions: [
              IconButton(
                icon: SvgPicture.asset(SVGAssets.icon_phone),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AudioCallView(
                      callID: 'one2oneAudio',
                    );
                  }));
                },
              ),
              IconButton(
                icon: SvgPicture.asset(SVGAssets.icon_video),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CallPage(
                      callID: 'one2one',
                    );
                  }));
                },
              ),
              /* IconButton(
                icon: SvgPicture.asset(SVGAssets.icon_more),
                onPressed: () {},
              ),*/
            ],
          );
        },
        messageItemBuilder: (context, message, defaultWidget) {
          if (message.type == ZIMMessageType.text) {
            return InkWell(
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: whiteColor,
                      title: const Text(
                        'Confirm',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: const Text('Do you want to delete this Message?',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16, color: textColorDisable)),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Cancel',
                            style: AppTextStyles.subTitle,
                          ),
                        ),
                        CustomButton(
                          label: 'Ok',
                          onPressed: () {
                            ZIMKit().deleteMessage([message]);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Theme(
                data: ThemeData(primaryColor: colorPrimary),
                child: Container(
                  alignment: message.isMine
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: message.isMine
                      ? localMessage(context, message)
                      : remoteMessage(context, message, conversation),
                ),
              ),
            );
          } else {
            return defaultWidget;
          }
        },
        /*sendButtonWidget: Text("send",style: TextStyle(
          fontSize: 14,
          color: textColor,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.2,
        ),),*/
        onMessageItemLongPress: _onMessageItemLongPress,
        messageInputContainerPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        messageListBackgroundBuilder: (context, defaultWidget) {
          return const ColoredBox(color: Colors.white);
        },
        inputDecoration: const InputDecoration(
          hintText: 'Type message..',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding: EdgeInsetsDirectional.only(start: 10.0),
        ),
        // showPickFileButton: true,
        // showPickMediaButton: true,
        showMoreButton: false,
        showRecordButton: false,
        conversationID: conversation.id,
        conversationType: conversation.type,
        // inputBackgroundDecoration: BoxDecoration(color: Colors.white),
        messageInputContainerDecoration: const BoxDecoration(color: whiteColor),
        messageInputKeyboardType: TextInputType.text,
        messageInputMaxLines: 1,
        messageInputMinLines: 1,
        messageInputTextInputAction: TextInputAction.done);
  }

  Widget localMessage(BuildContext context, ZIMKitMessage message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          padding: const EdgeInsets.all(10),
          // width: Dimensions.screenWidth/1.5,
          constraints: BoxConstraints(maxWidth: Dimensions.screenWidth / 1.4),
          decoration: const BoxDecoration(
            color: colorPrimary,
            borderRadius: BorderRadius.only(
                topRight: Radius.zero,
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // if (!message.isSentByMe) const SizedBox(height: 5),
              Text(
                message.textContent!.text,
                style: const TextStyle(
                  color: whiteColor,
                ),
              ),
              SvgPicture.asset(SVGAssets.icon_read)
              // Icon(Icons.check, size: 14, color: whiteColor)
            ],
          ),
        ),
      ],
    );
  }

  Widget remoteMessage(BuildContext context, ZIMKitMessage message,
      ZIMKitConversation conversation) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(conversation.avatarUrl),
                    radius: 20,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        conversation.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        Utility.readTimestamp(message.info.timestamp),
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
              constraints:
                  BoxConstraints(maxWidth: Dimensions.screenWidth / 1.4),
              decoration: const BoxDecoration(
                color: colorSecondary,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.zero,
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // if (!message.isSentByMe) const SizedBox(height: 5),
                  Text(
                    message.textContent!.text,
                    style: const TextStyle(
                      color: color5555,
                    ),
                  ),
                  // if (message.isSentByMe) SvgPicture.asset(SVGAssets.icon_read)
                  // Icon(Icons.check, size: 14, color: whiteColor)
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Future<void> _onMessageItemLongPress(
    BuildContext context,
    LongPressStartDetails details,
    ZIMKitMessage message,
    Function defaultAction,
  ) async {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Confirme'),
          content: const Text('Delete or recall this message?'),
          actions: [
            CupertinoDialogAction(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                ZIMKit().deleteMessage([message]);
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                ZIMKit().recallMessage(message).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error.toString())),
                  );
                });
                Navigator.pop(context);
              },
              child: const Text('Recall'),
            ),
          ],
        );
      },
    );
  }
}
