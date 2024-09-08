import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'tabbar.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController idController;
  late TextEditingController pwdController;
  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    pwdController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Text(''),
        title: const Text('로그인 하세요.'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/login.png'),
                  radius: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
                child: TextField(
                  controller: idController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '사용자 ID를 입력 하세요.',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: pwdController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '패스워드를 입력하세요.',
                  ),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.surfaceBright),
                  onPressed: () => dataCheck(context),
                  child: const Text('Log In')),
            ],
          ),
        ),
      ),
    );
  }

  dataCheck(context) {
    // id와 비번 다르다고 다르게 출력하지 말자
    if (idController.text.trim().isEmpty && pwdController.text.trim().isEmpty) {
      snackBarShow("id와 비밀번호를 입력해주세요.");
    } else {
      if (idController.text.trim() != 'root' &&
          pwdController.text.trim() != 'qwer1234') {
        snackBarShow('id와 비밀번호를 확인해주세요.');
      } else {
        Get.offAll(() => const Tabbar());
      }
    }
  }

  snackBarShow(snackBarMessage) {
    Get.snackbar(
      "오류",
      snackBarMessage,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
      colorText: Colors.amber,
    );
    setState(() {});
  }
}
