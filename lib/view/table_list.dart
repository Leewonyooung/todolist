import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:ui';
import 'package:todolist_v2/model/todo_list.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todolist_v2/view/add_todo.dart';

class TableList extends StatefulWidget {
  const TableList({
    super.key,
  });

  @override
  State<TableList> createState() => _TableListState();
}

class _TableListState extends State<TableList> {
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController inputActionController;
  late TextEditingController inputDateController;
  late TextEditingController searchController;
  late List<TodoList> todoList;
  late String strToday;
  late List<String> today;
  late double percent;
  late String textpercent;
  late Timer _timer;
  late String viewToday;
  late List<TodoList> addList;
  late DateTime now;
  late DateFormat viewTodayFormatter;
  late DateFormat formatter;
  late int currentIndex;
  late String choosedDate;
  late String checkDate;
  late String startDate;
  late String endDate;
  // Calendar
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    startDate = '';
    endDate = '';
    checkDate = '';
    currentIndex = 0;
    startDateController = TextEditingController();
    endDateController = TextEditingController();
    searchController = TextEditingController();
    inputActionController = TextEditingController();
    inputDateController = TextEditingController();
    addList = [];
    now = DateTime.now();
    viewTodayFormatter = DateFormat('yy년 MM월 dd일');
    choosedDate = (viewTodayFormatter.format(now)).toString();
    formatter = DateFormat('yyyy-MM-dd');
    viewToday = (viewTodayFormatter.format(now)).toString();
    strToday = (formatter.format(now)).toString();
    today = strToday.split('-');
    todoList = [];
    percent = 0;
    textpercent = '0';
    _timer = Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        if (isRunningOnPlatformThread) {
          timer.cancel();
        }
        strToday = formatter.format(now);
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
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
          'My Todo List',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () => Get.to(const AddTodo()),
              icon: const Icon(Icons.add_outlined))
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 15, 8, 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () => popWindow(context, '날짜선택'),
                                  child: Text(
                                    viewToday,
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.brown[50],
                            border: Border.all(color: Colors.black)),
                        width: 100,
                        height: 75,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                '오늘의 할 일',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 55,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      // color: Colors.brown[100],
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    '2개',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 520,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(75),
                          image: const DecorationImage(
                              image: AssetImage('images/memo.png'),
                              fit: BoxFit.contain),
                        ),
                        child: SizedBox(
                          height: 400,
                          width: 400,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                            child: ListView.builder(
                                itemCount: todoList.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          currentIndex = index;
                                          setState(() {});
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              60, 0, 0, 0),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                height: 50,
                                                width: 260,
                                                child: SizedBox(
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 170,
                                                        child: Text(
                                                          '   ${todoList[index].title}',
                                                          style: TextStyle(
                                                            color: index % 2 ==
                                                                    0
                                                                ? Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onPrimary
                                                                : Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onSecondary,
                                                            fontSize: 30,
                                                            fontFamily: 'leaf',
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                30, 0, 0, 0),
                                                        child: Checkbox(
                                                          fillColor:
                                                              const WidgetStatePropertyAll(
                                                                  Colors
                                                                      .black38),
                                                          checkColor:
                                                              Colors.black,
                                                          value: todoList[index]
                                                                      .task ==
                                                                  0
                                                              ? false
                                                              : true,
                                                          onChanged: (value) {
                                                            todoList[index]
                                                                    .task =
                                                                value! == true
                                                                    ? 1
                                                                    : 0;
                                                            _calculateChecked();
                                                            setState(() {});
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        indent: 60,
                                        endIndent: 30,
                                        thickness: 2,
                                      )
                                    ],
                                  );
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      // floatingActionButton: SizedBox(
      //   height: 50,
      //   width: 50,
      //   child: FloatingActionButton(
      //       child: const Icon(
      //         Icons.add,
      //         size: 30,
      //       ),
      //       onPressed: () {
      //         // floatingactionSheet();

      //         _buildBottomMenu();
      //       }),
      // ),
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
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomMenu() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(Icons.person, color: Colors.orange),
            title: const Text('알바', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.purple),
            title: const Text('부동산', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.directions_car, color: Colors.blue),
            title: const Text('중고차', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.sell, color: Colors.deepPurple),
            title:
                const Text('여러 물건 팔기', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.add, color: Colors.orange),
            title: const Text('내 물건 팔기', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  floatingactionSheet() {
    // showCupertinoModalPopup(
    //   context: context,
    //   barrierDismissible: true,
    //   builder: (context) => SingleChildScrollView(
    //     child: CupertinoActionSheet(
    //       actions: [
    //         CupertinoActionSheetAction(
    //           onPressed: () {
    //             Get.back();
    //             addTodo();
    //             // inputactionSheet(context, setState);
    //           },
    //           child: const Text('일정 추가하기'),
    //         ),
    //       ],
    //       cancelButton: CupertinoActionSheetAction(
    //           onPressed: () => Get.back(), child: const Text('Cancel')),
    //     ),
    //   ),
    // );
  }

  _calculateChecked() {
    int count = 0;
    for (int i = 0; i < todoList.length; i++) {
      if (todoList[i].task == true) {
        count++;
      }
    }
    percent = (count / todoList.length);
    textpercent = (percent * 100).toString();
    setState(() {});
  }

  popWindow(BuildContext context, String title) {
    Get.dialog(Builder(
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              titlePadding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
              title: SizedBox(
                  width: 560,
                  height: 50,
                  child: Stack(children: [
                    //제목
                    Positioned(
                        top: 15,
                        left: 0,
                        right: 0,
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        )),
                    //닫기 버튼
                    Positioned(
                        width: 45,
                        height: 45,
                        right: 0,
                        child: TextButton(
                          onPressed: () {
                            Get.back(); //창 닫기
                          },
                          child: const Icon(Icons.close),
                        ))
                  ])),
              //화면에 표시될 영역
              content: SizedBox(
                width: 300,
                height: 350,
                child: TableCalendar(
                  locale: 'ko_KR',
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  calendarFormat: _calendarFormat,
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      viewToday =
                          (viewTodayFormatter.format(_selectedDay!)).toString();
                      setStateDialog(() {});
                    }
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      _calendarFormat = format;
                      setStateDialog(() {});
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                    setStateDialog(() {});
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {});
                    Get.back();
                  },
                  child: const Text('적용'),
                ),
              ],
            );
          },
        );
      },
    ));
  }
}
