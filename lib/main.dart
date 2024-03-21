import 'package:chat/app/routes/app_pages.dart';
import 'package:chat/app/services/socket_service.dart';
import 'package:chat/app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  await initialServices();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.HOME,
    getPages: AppPages.routes,
  ));
}
Future<void> initialServices() async {
  await Get.putAsync(() => SocketService().init());
  await Get.putAsync(() => UserService().init());
}