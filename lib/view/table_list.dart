/*
메인 페이지
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:todolist_v2/model/todolist.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todolist_v2/view/complete_card.dart';
import 'package:todolist_v2/view/fab.dart';
import 'package:todolist_v2/view/settings.dart';
import 'package:todolist_v2/view/table_status.dart';
import 'package:todolist_v2/view/todo_card.dart';
import 'package:todolist_v2/vm/donetodolist_handler.dart';
import 'package:todolist_v2/vm/state_handler.dart';
import 'package:todolist_v2/vm/todolist_handler.dart';
import 'package:todolist_v2/vm/user_handler.dart';

class TableList extends StatefulWidget {
  const TableList({
    super.key,
  });

  @override
  State<TableList> createState() => TableListState();
}

class TableListState extends State<TableList> {
  final box = GetStorage();
  late UserHandler userHandler;
  late TodolistHandler todolistHandler;
  late DonetodolistHandler donetodolistHandler;
  late List<TodoList> todoList;
  late List<TodoList> seriousList;
  late List<String> today;
  late DateTime now;
  late String viewToday;
  late DateFormat viewTodayFormatter;
  late String date;
  late StateHandler stateHandler;
  // Calendar
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    date = DateTime.now().year.toString().padLeft(4, '0') +
            DateTime.now().month.toString().padLeft(2, '0') +
            DateTime.now().day.toString().padLeft(2, '0');
    initStorage();
    stateHandler = StateHandler();
    userHandler = UserHandler();
    donetodolistHandler = DonetodolistHandler();
    seriousList = [];
    todolistHandler = TodolistHandler();
    firstRun();
    now = DateTime.now();
    viewTodayFormatter = DateFormat('yy년 MM월 dd일');
    viewToday = (viewTodayFormatter.format(now)).toString();
    todoList = [];
  }

  initStorage() {
    if (box.read('state') == '1') {
      return;
    } else {
      box.write('state', '0');
    }
  }

  firstRun() async {
    if (box.read('state') == '0') {
      await userHandler.initUser();
      box.write('state', '1');
    } else {}
  }

  @override
  void dispose() {
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
            onPressed: () => Get.to(const Settings(), ),
            icon: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.settings_outlined,
                color: Theme.of(context).colorScheme.onSurface,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      body: Column(
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
                              onTap: (){
                                popWindow(context,);
                                setState(() {});
                              },
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
                        ]
                      ),
                    ),
                    TableStatus(date: date),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '해야 할 일',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                      ),
                    ),
                    TodoCard(date: date),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '완료한 일',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                          ),
                        ),
                        CompleteCard(date: date),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: const Fab(),
    );
  }

  popWindow(BuildContext context) {
    Get.dialog(Builder(
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              content: SizedBox(
                width: MediaQuery.of(context).size.width / 1,
                height: MediaQuery.of(context).size.height / 2.5,
                child: TableCalendar(
                  locale: "ko_KR",
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
                    date = _selectedDay!.year.toString().padLeft(4, '0') +
                          _selectedDay!.month.toString().padLeft(2, '0') +
                          _selectedDay!.day.toString().padLeft(2, '0');
                    setState(() {});
                    Get.back();
                  },
                  child: const Text(
                    '날짜 변경',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    ));
  }

  reloadData() {
    setState(() {});
  }
}
