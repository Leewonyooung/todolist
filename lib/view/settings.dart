import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_v2/model/user.dart';
import 'package:todolist_v2/view/theme_changer.dart';
import 'package:todolist_v2/vm/user_handler.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  UserHandler userHandler = UserHandler();
  late List<User> userData;
  @override
  void initState() {
    userData = [];
    super.initState();
    getUserData();
  }

  getUserData() async{
    List<User> result = await userHandler.queryUser();
    userData.add(result[0]);
    print(userData);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        centerTitle: true,
        title: const Text(
          '설정',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '내 정보',
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: CircleAvatar(
                        radius: 40,
                        child: Icon(Icons.person),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          userData.isEmpty ? "Empty" : userData[0].name  ,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                '프리미엄',
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                width: MediaQuery.of(context).size.width/1.1,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,5,0),
                        child: Icon(
                          Icons.wallet,
                          color: Theme.of(context).colorScheme.surfaceContainerLow,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          alignment: Alignment.centerLeft,
                          minimumSize: Size(
                            MediaQuery.of(context).size.width/1.5, 
                            MediaQuery.of(context).size.height/16,
                          )
                        ),
                        onPressed: (){
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(  //외곽선 둥글기
                              borderRadius: BorderRadius.circular(15)
                            ),
                            backgroundColor: Theme.of(context).colorScheme.inverseSurface,
                            isScrollControlled: true,
                            context: context, 
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(0,0,0,30),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 1,
                                  height: MediaQuery.of(context).size.height / 1.15,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 0.8,
                                            color: Theme.of(context).colorScheme.surface,
                                          )
                                        ),
                                        width: MediaQuery.of(context).size.width / 1,
                                        child: Row(
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                fixedSize: Size(
                                                  MediaQuery.of(context).size.width / 7, 
                                                  MediaQuery.of(context).size.height / 16, 
                                                ),
                                                padding: EdgeInsets.zero,  // 버튼 안 글자 여백 없애기
                                                backgroundColor: Theme.of(context).colorScheme.inverseSurface,
                                                foregroundColor: Theme.of(context).colorScheme.surface,
                                                shape: RoundedRectangleBorder(  //외곽선 둥글기
                                                  borderRadius: BorderRadius.circular(15)
                                                ),
                                                elevation: 0,
                                              ),
                                              onPressed: (){
                                                Get.back();
                                              }, 
                                              child: const Text(
                                                "닫기",
                                                style: TextStyle(
                                                  fontSize: 28,
                                                ),
                                              )
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '프리미엄 혜택',
                                                style: TextStyle(
                                                  fontSize: 38,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context).colorScheme.surface,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/5.5,10,0,0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(Icons.check_outlined,
                                                          color: Theme.of(context).colorScheme.surface,
                                                        ),
                                                        Text(
                                                          '  모든 기기에서 연동되는 데이터',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            color: Theme.of(context).colorScheme.surface,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      // mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          Icons.check_outlined,
                                                          color: Theme.of(context).colorScheme.surface,  
                                                        ),
                                                        Text(
                                                          '  한번 결제시 평생 프리미엄 이용',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            color: Theme.of(context).colorScheme.surface,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: Size(
                                            MediaQuery.of(context).size.width / 1.2, 
                                            MediaQuery.of(context).size.height / 18, 
                                          )
                                        ),
                                        onPressed: (){}, 
                                        child: const Text("결제 하기")
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          "프리미엄 결제하기",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surfaceContainerLow,
                            fontSize: 28,
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.surface,)
                    ],
                  ),
                ),
              ),
            ), // 프리미엄 결제하기 버튼
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                '설정',
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                width: MediaQuery.of(context).size.width/1.1,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,5,0),
                        child: Icon(
                          Icons.more_horiz_outlined,
                          color: Theme.of(context).colorScheme.surfaceContainerLow,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          alignment: Alignment.centerLeft,
                          minimumSize: Size(
                            MediaQuery.of(context).size.width/1.5, 
                            MediaQuery.of(context).size.height/16,
                          )
                        ),
                        onPressed: (){
                          Get.to(const ThemeChanger());
                        },
                        child: Text(
                          "기타",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surfaceContainerLow,
                            fontSize: 28,
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.surface,)
                    ],
                  ),
                ),
              ),
            ), 
            
          ],
        ),
      ),
    );
  }
}