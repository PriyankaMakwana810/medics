import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medics/utils/utility.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../../custom_widgets/button.dart';
import '../../styles/color_constants.dart';
import '../home/home_controller.dart';

void showDefaultAddUserToGroupDialog(BuildContext context, String groupID) {
  final HomeController controller = Get.find();
  showDialog<bool>(
    useRootNavigator: false,
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                    'Add User to Group',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Select Doctor you want to Add to Group:',
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
                            final isSelected =
                                controller.isDoctorSelectedForAddGroup(index);
                            return GestureDetector(
                              onTap: () {
                                controller
                                    .toggleDoctorSelectionForAddGroup(index);
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
                          // Get.back();
                          ZIMKit()
                              .addUersToGroup(groupID, controller.groupMembers)
                              .then((int? errorCode) {
                            if (errorCode != 0) {
                              Utility.snackBar(
                                  "$errorCode Something Went Wrong", context);
                              debugPrint('addUersToGroup faild');
                            } else {
                              Utility.snackBar("Added Successfully", context);
                            }
                            Navigator.of(context).pop(true);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
    },
  );
}

void showDefaultRemoveUserFromGroupDialog(
    BuildContext context, String groupID) {
  final HomeController controller = Get.find();
  final groupUsersController = TextEditingController();
  Timer.run(() {
    showDialog<bool>(
      useRootNavigator: false,
      context: context,
      builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                      'Remove User',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Select Doctor you want to remove from Group:',
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
                              final isSelected =
                                  controller.isDoctorSelectedForAddGroup(index);
                              return GestureDetector(
                                onTap: () {
                                  controller
                                      .toggleDoctorSelectionForAddGroup(index);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        isSelected ? colorPrimary : whiteColor,
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
                                      color:
                                          isSelected ? whiteColor : textColor,
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
                            // Get.back();
                            ZIMKit()
                                .removeUesrsFromGroup(
                                    groupID, controller.groupMembers)
                                .then((int? errorCode) {
                              if (errorCode != 0) {
                                Utility.snackBar(
                                    "$errorCode Something Went Wrong", context);
                                debugPrint('remove User failed faild');
                              } else {
                                Utility.snackBar(
                                    "Removed Successfully", context);
                              }
                              Navigator.of(context).pop(true);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
      },
    );
  });
}

Future<dynamic> showDefaultGroupMemberListDialog(
  BuildContext context,
  String groupID,
) {
  final title = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const SizedBox.shrink(),
      const SizedBox.shrink(),
      Text(
        'Member List',
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ],
  );

  Widget memberAvatar(
    ZIMGroupMemberInfo memberItem,
    String memberItemName,
  ) {
    return CircleAvatar(
      backgroundImage: AssetImage(memberItem.memberAvatarUrl),
      radius: 20,
    );
  }

  Widget memberInfo(
    ZIMGroupMemberInfo memberItem,
    String memberItemName,
  ) {
    final memberItemIsMe =
        memberItem.userID == ZIMKit().currentUser()!.baseInfo.userID;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(memberItemName, maxLines: 1, overflow: TextOverflow.clip),
            Text(memberItem.memberRole == ZIMGroupMemberRole.owner
                ? '(Owner)'
                : ''),
            Text(memberItem.memberRole == 2 ? '(Manager)' : ''),
            Text(memberItemIsMe ? '(Me)' : ''),
          ],
        ),
        Text('ID:${memberItem.userID}'),
      ],
    );
  }

  Widget memberMenu(
    ZIMGroupMemberInfo memberItem,
  ) {
    final memberItemIsMe =
        memberItem.userID == ZIMKit().currentUser()!.baseInfo.userID;

    return FutureBuilder(
      future: ZIMKit().queryGroupMemberInfo(
        groupID,
        ZIMKit().currentUser()?.baseInfo.userID ?? '',
      ),
      builder: (_, AsyncSnapshot<ZIMGroupMemberInfo?> snapshot) {
        final imGroupManager =
            snapshot.hasData && (snapshot.data?.memberRole == 2);

        return ValueListenableBuilder(
          valueListenable: ZIMKit().queryGroupOwner(groupID),
          builder: (context, ZIMGroupMemberInfo? owner, _) {
            if (memberItemIsMe) {
              return const SizedBox.shrink();
            }

            final imGroupOwner =
                owner?.userID == ZIMKit().currentUser()?.baseInfo.userID;
            return PopupMenuButton(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              position: PopupMenuPosition.under,
              icon: const Icon(Icons.more_horiz),
              itemBuilder: (context) {
                return [
                  if (imGroupOwner || imGroupManager) ...[
                    PopupMenuItem(
                      child: const ListTile(
                          leading: Icon(Icons.group_remove),
                          title: Text('Remove User')),
                      onTap: () => ZIMKit().removeUesrsFromGroup(
                        groupID,
                        [memberItem.userID],
                      ),
                    ),
                  ],
                  if (imGroupOwner) ...[
                    PopupMenuItem(
                      child: const ListTile(
                          leading: Icon(Icons.handshake),
                          title: Text('Transfer Group Owner')),
                      onTap: () => ZIMKit().transferGroupOwner(
                        groupID,
                        memberItem.userID,
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        leading: const Icon(Icons.diversity_3),
                        title: (memberItem.memberRole == 3)
                            ? const Text('Set Group Manager')
                            : const Text('Unset Group Manager'),
                      ),
                      onTap: () => ZIMKit().setGroupMemberRole(
                        conversationID: groupID,
                        userID: memberItem.userID,
                        role: (memberItem.memberRole == 3) ? 2 : 3,
                      ),
                    ),
                  ],
/*                  PopupMenuItem(
                    child: const ListTile(
                      leading: Icon(Icons.chat),
                      title: Text('Private Chat'),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return ChatScreenView(
                            conversationID: memberItem.userID,
                            conversationType: ZIMConversationType.peer,
                          );
                        }),
                      );
                    },
                  ),*/
                ];
              },
            );
          },
        );
      },
    );
  }

  final memberList = ValueListenableBuilder(
    valueListenable: ZIMKit().queryGroupMemberList(groupID),
    builder: (
      BuildContext context,
      List<ZIMGroupMemberInfo> memberList,
      Widget? child,
    ) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.transparent,
            ),
            scrollDirection: Axis.vertical,
            itemCount: memberList.length,
            itemBuilder: (context, index) {
              final memberItem = memberList[index];
              final memberItemName = memberItem.memberNickname.isNotEmpty
                  ? memberItem.memberNickname
                  : memberItem.userName;

              return GestureDetector(
                onTap: () async {
                  debugPrint(
                    'click member: ${memberItem.userID}',
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      memberAvatar(memberItem, memberItemName),
                      const SizedBox(width: 10),
                      memberInfo(memberItem, memberItemName),
                    ]),
                    Row(children: [memberMenu(memberItem)]),
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );

  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title,
            memberList,
          ],
        ),
      );
    },
  );
}
