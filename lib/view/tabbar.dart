import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../model/todo_list.dart';
import 'package:intl/intl.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({super.key});

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> with SingleTickerProviderStateMixin {
  late TabController controller; // 탭바 property
  late List<TodoList> todayList;
  late List<TodoList> futureList;
  late List<TodoList> pastList;
  late List<TodoList> addList;
  late List<IconData> icons;
  late List<bool> todaychecked;
  late List<bool> futurechecked;
  late String strToday;
  late List<String> today;
  late TextEditingController inputActionController;

  @override
  void initState() {
    super.initState();

    todaychecked = [];
    futurechecked = [];
    addList = [
      TodoList(title: '', duration: '', )
    ];
    todayList = [];
    futureList = [];
    pastList = [];
    addList = [];
    icons = [
      Icons.home,
      Icons.search,
      Icons.add_ic_call_rounded,
      Icons.wine_bar,
      Icons.apartment_sharp,
    ];
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    strToday = formatter.format(now);
    today = strToday.split('-');
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose(); //순서에 주의
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          centerTitle: true,
          title: const Text(
            'My Todo List',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          bottom: TabBar(
            isScrollable: false,
            controller: controller,
            tabs: const [
              Tab(
                text: '오늘 할 일',
              ),
              Tab(
                text: '앞으로 할 일',
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: 500,
        height: 800,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/memo.png'), fit: BoxFit.contain),
        ),
        child: TabBarView(
          controller: controller,
          children: [
           TableList(list: todayList, checked: todaychecked,notlist: futureList,),
           SecondTable(list: futureList, checked: todaychecked)
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('images/profile.png'),
              ),
              accountName: const Padding(
                padding: EdgeInsets.fromLTRB(8, 12, 0, 0),
                child: Text('이원영'),
              ),
              accountEmail: const Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Text('wylee99@naver.com'),
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondary,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
              title: const Text('Home'),
              onTap: () {},
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                thickness: 3,
                height: 2,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.settings_backup_restore,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
              title: const Text('이전 항목 보기'),
              onTap: () => Get.to(() => PastTable(
                    list: pastList,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  addData(result) {
    if (result == '아무것도 입력되지 않았습니다.') {
      return 0;
    }
    List<String> finalDuration = ((result[0].duration).toString()).split('-');
    if (int.parse(finalDuration[2]) > int.parse(today[2])) {
      futureList.add(TodoList(
          title: result[0].title,
          duration: result[0].duration,
         ));
      futurechecked.add(false);
    } else if (int.parse(finalDuration[2]) == int.parse(today[2])) {
      todayList.add(TodoList(
          title: result[0].title,
          duration: result[0].duration,
         ));
      todaychecked.add(false);
    } else {
      pastList.add(TodoList(
          title: result[0].title,
          duration: result[0].duration,
        ));
    }
    setState(() {});
  }
}
