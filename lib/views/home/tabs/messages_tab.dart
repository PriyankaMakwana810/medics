import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medics/styles/color_constants.dart';

class MessagesView extends StatelessWidget{
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Text('Messages'),
      ),
    );
  }

}