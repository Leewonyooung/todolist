import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:ui';

import 'package:todolist_v2/model/todo_list.dart';


class SecondTable extends StatefulWidget {
  final List<TodoList> list;
  final List<bool> checked;
  const SecondTable({super.key, required this.list, required this.checked});

  @override
  State<SecondTable> createState() => _TableListState();
}

class _TableListState extends State<SecondTable> {
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

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
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
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: 400,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.black,
                    )),
                    height: 50,
                    width: 300,
                    child: TextField(
                      controller: searchController,
                      style: const TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.black,
                      )),
                      child: IconButton(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: const Icon(Icons.search)))
                ],
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: 800,
                child: Center(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    width: 150,
                                    child: Text(
                                      viewToday,

                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                height: 480,
                                width: 350,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: const DecorationImage(
                                      image: AssetImage('images/memo.png'),
                                      fit: BoxFit.contain),
                                ),
                                child: SizedBox(
                                  height: 400,
                                  width: 400,
                                  child: searchController.text != ''
                                      ? const Center(
                                          child: Text(
                                          '찾으시는 일정이 없습니다.',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 30,
                                          ),
                                        ))
                                      : Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 40, 0, 0),
                                          child: ListView.builder(
                                              itemCount: widget.list.length,
                                              itemBuilder: (context, index) {
                                                return Dismissible(
                                                  direction: DismissDirection
                                                      .endToStart,
                                                  key: ValueKey(
                                                      widget.list[index]),
                                                  onDismissed: (direction) {
                                                    widget.list.remove(
                                                        widget.list[index]);
                                                  },
                                                  child: StatefulBuilder(
                                                      builder:
                                                          (BuildContext context,
                                                              StateSetter
                                                                  setState) {
                                                    return Column(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            currentIndex =
                                                                index;
                                                            _showstatefulEditBottomSheet(
                                                                widget
                                                                    .list[index]
                                                                    .title,
                                                                currentIndex,
                                                                setState);
                                                            setState(() {});
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    60,
                                                                    0,
                                                                    0,
                                                                    0),
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                  height: 50,
                                                                  width: 260,
                                                                  child:
                                                                      SizedBox(
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              170,
                                                                          child:
                                                                              Text(
                                                                            '   ${widget.list[index].title}',
                                                                            style:
                                                                                TextStyle(
                                                                              color: index % 2 == 0 ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSecondary,
                                                                              fontSize: 30,
                                                                              fontFamily: 'leaf',
                                                                              fontWeight: FontWeight.w300,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .fromLTRB(
                                                                              30,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              Checkbox(
                                                                            fillColor:
                                                                                const WidgetStatePropertyAll(Colors.black38),
                                                                            checkColor:
                                                                                Colors.black,
                                                                            value:
                                                                                widget.checked[index],
                                                                            onChanged:
                                                                                (value) {
                                                                              widget.checked[index] = value!;
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
                                                );
                                              }),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        child: Text(
                          '앞으로의 일정이에요.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 50,
        child: FloatingActionButton(
            child: const Icon(
              Icons.add,
              size: 30,
            ),
            onPressed: () {
              floatingactionSheet(currentIndex);
            }),
      ),
    );
  }

  floatingactionSheet(index) {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Get.back();
              inputactionSheet(context, setState);
            },
            child: const Text('일정 추가하기'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
            onPressed: () => Get.back(), child: const Text('Cancel')),
      ),
    );
  }

  inputactionSheet(context, setState) {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return CupertinoActionSheet(
            actions: [
              SizedBox(
                height: 300,
                child: Column(
                  children: [
                    SizedBox(
                      height: 180,
                      child: CupertinoDatePicker(
                        initialDateTime: now,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (dateTime) {
                          setState(() {
                            choosedDate = dateTime.toString();
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoTextField(
                        controller: inputActionController,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        placeholder: '할 일을 입력하세요',
                      ),
                    ),
                  ],
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Get.back();
                  _addList();
                },
                child: const Text('일정 추가하기'),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
          );
        },
      ),
    );
  }

  _addList() {
    addList = [TodoList(title: '', duration: '')];
    addList[0].title = inputActionController.text.trim();
    addList[0].duration = choosedDate;
    widget.list.add(addList[0]);
    widget.checked.add(false);
    inputActionController.text = '';
    setState(() {});
  }

  _calculateChecked() {
    int count = 0;
    for (int i = 0; i < widget.checked.length; i++) {
      if (widget.checked[i]) {
        count++;
      }
    }
    percent = (count / widget.checked.length);
    textpercent = (percent * 100).toString();
    setState(() {});
  }

  _showstatefulEditBottomSheet(title, index, setState) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              width: 400,
              height: 350,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            '닫기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextButton(
                          onPressed: () {
                            Get.back();
                            widget.list[index].duration = choosedDate;
                            String temp = choosedDate.substring(
                                choosedDate.length - 4, choosedDate.length - 1);
                            temp = temp.trim();
                            String tempstrToday = strToday.substring(
                                strToday.length - 2, strToday.length);
                            tempstrToday = tempstrToday.trim();
                            if (int.parse(temp) > int.parse(tempstrToday)) {
                              widget.list.removeAt(index);
                              widget.checked.removeAt(index);
                            }
                            setState(() {});
                          },
                          child: const Text(
                            '완료',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '기한 : ',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        choosedDate,
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _showDatePicker(context, index, setState);
                        },
                        icon: const Icon(Icons.date_range),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  _showDatePicker(context, index, setState) async {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 350,
          color: Theme.of(context).colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                  child: CupertinoDatePicker(
                    initialDateTime: now,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime newDate) {
                      String temp = viewTodayFormatter.format(newDate);
                      choosedDate = temp;
                      setState(() {});
                    },
                  ),
                ),
                CupertinoButton(
                  child: const Text('확인'),
                  onPressed: () {
                    Get.back();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
