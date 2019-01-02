import 'package:flutter/material.dart';
import '../constrant.dart' show AppColors;


class Conversion {

  const Conversion({
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


const List<Conversion> mockConversions = [
  const Conversion(
    avatar: 'assets/images/leave.png',
    title: 'Fuck',
    des: '',
    createAt: '19.1111',
  ),
]