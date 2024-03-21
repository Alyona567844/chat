import 'package:chat/app/modules/chat/chat_binding.dart';
import 'package:chat/app/modules/chat/chat_view.dart';
import 'package:chat/app/modules/home/home_binding.dart';
import 'package:chat/app/modules/home/home_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: Routes.CHAT,
      page: () => ChatPage(),
      binding: ChatBinding(),
    ),
  ];
}
