import 'package:chat/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Добро пожаловать в чат',
          style: TextStyle(color: Colors.pink),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Введите имя',
            style: TextStyle(color: Colors.pink, fontSize: 25),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              controller: controller.textCtrl,
              onSubmitted: (value) => controller.signIn(),
              style: const TextStyle(color: Colors.pink),
            ),
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          // ElevatedButton(
          //   style: const ButtonStyle(
          //       backgroundColor: MaterialStatePropertyAll<Color>(
          //           Colors.pink)),
          //   onPressed: () {},
          //   child: const Text(
          //     'Войти',
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontSize: 20,
          //     ),
          //   ),
          // ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 29, 100, 154),
    );
  }
}
