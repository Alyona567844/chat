import 'package:chat/app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final textCtrl = TextEditingController();

  void signIn() {
    String username = textCtrl.text;
    // print(username);
    UserService.to.setUsernameAndConnect(username);
  }
}