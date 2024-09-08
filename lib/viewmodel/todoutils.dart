import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
class Todoutils{

  
  snackBarShow(snackBarMessage) {
    Get.snackbar(
      "오류",
      snackBarMessage,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
      colorText: Colors.amber,
    );
  }
}