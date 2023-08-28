import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UI {
  static GetSnackBar successSnackBar({String title = 'Success', String? message}) {
    Get.log("[$title] $message");
    return GetSnackBar(
      titleText: Text(title.tr, style: Get.textTheme.titleLarge?.merge(TextStyle(color: Get.theme.primaryColorLight))),
      messageText: Text(message.toString(), style: Get.textTheme.bodySmall?.merge(TextStyle(color: Get.theme.primaryColorLight))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor:  Colors.deepPurple,
      icon: Icon(Icons.check_circle_outline, size: 32, color: Get.theme.primaryColorLight),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 2),
    );
  }



  static GetSnackBar errorSnackBar({String title = 'Delete', String? message, TextStyle? textStyle, TextStyle? titleStyle}) {
    Get.log("[$title] $message", isError: true);
    return GetSnackBar(
      titleText: Text(title.tr, style: textStyle ?? Get.textTheme.titleLarge?.merge(TextStyle(color: Get.theme.primaryColorLight))),
      messageText: Text(message.toString(), style: titleStyle ?? Get.textTheme.bodySmall?.merge(TextStyle(color: Get.theme.primaryColorLight))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.red,
      icon: Icon(Icons.remove_circle_outline, size: 32, color: Get.theme.primaryColor),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 2),
    );
  }

  static GetSnackBar warningSnackBar({String title = 'warning', String? message}) {
    Get.log("[$title] $message", isError: true);
    return GetSnackBar(
      titleText: Text(title.tr, style: Get.textTheme.titleLarge!.merge(TextStyle(color: Get.theme.primaryColorLight))),
      messageText: Text(message!, style: Get.textTheme.bodySmall!.merge(TextStyle(color: Get.theme.primaryColorLight))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.orange,
      icon: Icon(Icons.remove_circle_outline, size: 32, color: Get.theme.primaryColor),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 2),
    );
  }
}