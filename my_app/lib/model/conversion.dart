import 'package:flutter/material.dart';
import '../constrant.dart' show AppColors;


class Conversion {

  const Conversion(this.unreadMsgCount, this.displayDot, {
    @required this.title,
    @required this.avatar,
    
    this.titleColor : AppColors.ConversationTitleColor,
    this.des,
    @required this.createAt,
    this.isMute : false,
  }) : assert(avatar != null),
       assert(title != null),
       assert(createAt != null);
       

  final String avatar;
  final String title;
  final String des;
  final String createAt;
  final bool isMute;
  final int titleColor;
  final int unreadMsgCount;
  final bool displayDot;
}

