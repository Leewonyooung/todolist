/*
메인 페이지의 해야할 일 팝업메뉴버튼을 통해
수정 버튼을 눌렀을떄 가는 수정 페이지
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todolist_v2/model/todolist.dart';
import 'package:todolist_v2/vm/todolist_handler.dart';

class UpdateTodo extends StatefulWidget {
  const UpdateTodo({super.key, required this.todoList});
  final TodoList todoList;
  @override
  State<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {
  late bool _isChecked;
  late TodolistHandler todolistHandler;
  late TextEditingController dateController;
  late TextEditingController titleController;
  late String viewToday;
  late DateFormat viewTodayFormatter;
  late DateTime now;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    _isChecked = widget.todoList.serious == 1 ? true : false;
    todolistHandler = TodolistHandler();
    viewTodayFormatter = DateFormat('yy년 MM월 dd일');
    viewToday = (viewTodayFormatter.format(now)).toString();
    dateController = TextEditingController();
    titleController = TextEditingController();
    titleController.text = widget.todoList.title;
    dateController.text = 
    "${widget.todoList.date.substring(0,4)}년 ${widget.todoList.date.substring(4,6)}월 ${widget.todoList.date.substring(6)}일";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 50,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        title: const Text(
          '일정 추가',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.4,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 30, 20, 5),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1,
                                height: MediaQuery.of(context).size.height / 7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '제목',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Theme.of(context).colorScheme.onPrimary
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: Row(
                                        mainAxisAlignment:MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:BorderRadius.circular(10),
                                              border: Border.all(color: Colors.black)
                                            ),
                                            width: MediaQuery.of(context).size.width / 1.25,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                              child: TextField(
                                                decoration:
                                                  const InputDecoration(
                                                    hintText: "제목을 입력하세요.",
                                                    hintStyle: TextStyle(
                                                      color: Colors.black38
                                                    ),
                                                  ),
                                                controller: titleController,
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  color: Theme.of(context).colorScheme.primaryContainer
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:const EdgeInsets.fromLTRB(20, 10, 20, 30),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '기한',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Theme.of(context).colorScheme.onPrimary
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: Row(
                                        mainAxisAlignment:MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                              borderRadius:BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.black
                                              ),
                                            ),
                                            height: MediaQuery.of(context).size.width / 8,
                                            width: MediaQuery.of(context).size.width / 1.25,
                                            child: Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    popWindow(context, '날짜선택');
                                                  },
                                                  icon: const Icon(
                                                    Icons.calendar_month
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width / 1.8,
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                                    child: TextField(
                                                      decoration:const InputDecoration(
                                                        hintText:"날짜를 선택하세요.",
                                                        hintStyle: TextStyle(
                                                          color: Colors.black38
                                                        ),
                                                        border:InputBorder.none
                                                      ),
                                                      controller:dateController,
                                                      style: TextStyle(
                                                        fontSize: 22,
                                                        color: Theme.of(context).colorScheme.primaryContainer
                                                      ),
                                                      readOnly: true,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(25, 40, 20, 5),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                      child: Text(
                                        '중요!',
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Theme.of(context).colorScheme.onPrimary
                                        ),
                                      ),
                                    ),
                                    CupertinoSwitch(
                                      value: _isChecked,
                                      activeColor:Theme.of(context).colorScheme.primary,
                                      onChanged: (bool? value) {
                                        _isChecked = value!;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: MediaQuery.of(context).size.height / 17,
                    child: ElevatedButton(
                      onPressed: () async {
                        TodoList todoList = TodoList(
                          seq: widget.todoList.seq,
                          title: titleController.text.trim(),
                          date: _selectedDay == null
                          ? widget.todoList.date 
                          : _selectedDay!.year.toString().padLeft(4, '0') +
                            _selectedDay!.month.toString().padLeft(2, '0') +
                            _selectedDay!.day.toString().padLeft(2, '0'),
                          serious: _isChecked ? 1 : 0,
                          done: widget.todoList.done,
                        );
                        updateTodoList(todoList);
                        setState(() {});
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow
                      ),
                      child: Text(
                        '수정 하기',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  popWindow(BuildContext context, String title) {
    Get.dialog(Builder(
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              titlePadding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
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
                      _selectedDay ?? DateTime.now();
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      viewToday =
                          (viewTodayFormatter.format(_selectedDay!)).toString();
                      dateController.text = viewToday;
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
                    dateController.text = viewToday;
                    setState(() {});
                    Get.back();
                  },
                  child: const Text('선택'),
                ),
              ],
            );
          },
        );
      },
    ));
  }

  updateTodoList(TodoList todolist) async {
    todolistHandler.updatetodoList(todolist);
  }
}
