import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/single_child_widget.dart';
import 'package:youtube_baonh/common/constants/api_constant.dart';
import 'package:youtube_baonh/common/constants/variable_constant.dart';

void showMessage(
    [BuildContext? context,
    String? title,
    String? message,
    List<Widget>? actionsAlert]) {
  if (context == null) return;
  var actionAlignment = (actionsAlert?.length == 1) ? MainAxisAlignment.end : MainAxisAlignment.center;
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: (title == null || title.isEmpty) ? null : Text(title),
        content: (message == null || message.isEmpty) ? null : Text(message),
        actions: actionsAlert,
        actionsAlignment: actionAlignment,
      );
    },
  );
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

bool isNotEmpty(List<String> data) {
  for (int i = 0; i < data.length; i++){
    if (data[i].isEmpty) {
      return false;
    }
  }
  return true;
}

String convertToMoney(int value){
  String result  =  NumberFormat.currency(locale: 'eu',symbol: 'VND',decimalDigits : 0).format(value);
  return result;
}

String greeting() {
  var now = DateTime.now();
  var hour = now.hour;

  if (hour >= 5 && hour < 12) {
    return "Buổi sáng năng lượng !";
  } else if (hour >= 12 && hour < 14) {
   return "Buổi trưa vui vẻ!!";
  } else if (hour >= 14 && hour < 18) {
    return "Buổi chiều nhẹ nhàng ...";
  } else {
    return "Chào buổi tối !";
  }

}

String getRandomApiKeys(List<String> list){
  final random = Random();
  final index = random.nextInt(list.length);
  print("api key list[${index}] = ${list[index]}");
  return list[index];
}