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
          style: TextStyle(color: Color.fromARGB(186, 255, 255, 255)),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/sky.jpg')),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Введите имя',
              style: TextStyle(color: Color.fromARGB(186, 255, 255, 255), fontSize: 25),
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
                    borderSide: const BorderSide(
                      color: Color.fromARGB(186, 255, 255, 255),
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(186, 255, 255, 255),
                    )
                  ),
                ),
                cursorColor: const Color.fromARGB(186, 255, 255, 255),
                controller: controller.textCtrl,
                onSubmitted: (value) => controller.signIn(),
                style: const TextStyle(color: Color.fromARGB(186, 255, 255, 255)),
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
      ),
      // backgroundColor: const Color.fromARGB(186, 255, 255, 255),
    );
  }
}
