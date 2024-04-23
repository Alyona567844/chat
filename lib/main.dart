import 'package:chat/app/routes/app_pages.dart';
import 'package:chat/app/services/socket_service.dart';
import 'package:chat/app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  initialServices();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.HOME,
    getPages: AppPages.routes,
  ));
}
void initialServices() {
  Get.put(SocketService().init());
  Get.put(UserService());
}