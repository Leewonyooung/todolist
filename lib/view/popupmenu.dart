/*
해야 할일 카드의 팝업메뉴버튼
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todolist_v2/model/donetodolist.dart';
import 'package:todolist_v2/model/todolist.dart';
import 'package:todolist_v2/model/wastebasket.dart';
import 'package:todolist_v2/view/table_list.dart';
import 'package:todolist_v2/view/update_todo.dart';
import 'package:todolist_v2/vm/donetodolist_handler.dart';
import 'package:todolist_v2/vm/todolist_handler.dart';
import 'package:todolist_v2/vm/wastebasket_handler.dart';

class MyPopup extends StatefulWidget {
  const MyPopup({super.key, required this.todoList});
  final TodoList todoList;
  
  @override
  State<MyPopup> createState() => _MyPopupState();
}

class _MyPopupState extends State<MyPopup> {
  final box = GetStorage();
  DonetodolistHandler donetodolistHandler = DonetodolistHandler();
  TodolistHandler todolistHandler = TodolistHandler();
  WastebasketHandler wastebasketHandler = WastebasketHandler();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Theme.of(context).colorScheme.tertiary,
      ),
      child: PopupMenuButton<String>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        elevation: 0,
        color: Theme.of(context).colorScheme.secondaryContainer,
        tooltip: "",
        position: PopupMenuPosition.under,
        itemBuilder: (context) {
          return [
            _menuItem("삭제"),
            _menuItem("수정"),
            _menuItem("완료"),
          ];
        },
        constraints: const BoxConstraints(minWidth: 90, maxWidth: 150),
        offset: const Offset(10, 0),
        icon: Icon(Icons.more_vert, color: Theme.of(context).colorScheme.surface,),
        splashRadius: 40,
        iconSize: 30,
        enabled: true,
      ),
    );
  }

  PopupMenuItem<String> _menuItem(String text) {
    TableListState? tableListState = context.findAncestorStateOfType<TableListState>();
    return PopupMenuItem<String>(
      enabled: true,
      onTap: () {
        if (text == "삭제") {
          deleteDialog();
        }
        if (text == "수정") {
          Get.to(UpdateTodo(todoList: widget.todoList,))!.then((value) {
            tableListState!.setState(() {});
          },);
        }
        if(text == "완료"){
          finishDialog();
        }
      },
      value: text,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textAlign: TextAlign.center,
            text,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white
            ),
          ),
        ],
      ),
    );
  }

  deleteDialog() {
    Get.defaultDialog(
      radius: 10,
      title: '삭제',
      titlePadding: const EdgeInsets.fromLTRB(0,20,0,0,),
      titleStyle: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold
      ),
      middleText: '정말로 삭제 하시겠습니까?',
      middleTextStyle: const TextStyle(
        fontSize: 22,
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      barrierDismissible: false,
      actions: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: TextButton(
                onPressed: () {
                  Wastebasket deletedtodolist = Wastebasket(
                    todolistSeq: widget.todoList.seq!, 
                    userSeq: int.parse(box.read('state')), 
                    title: widget.todoList.title, 
                    date: widget.todoList.date, 
                    serious: widget.todoList.serious, 
                    deletedDate: DateTime.now().year.toString().padLeft(4, '0') +
                            DateTime.now().month.toString().padLeft(2, '0') +
                            DateTime.now().day.toString().padLeft(2, '0'),
                  );
                  TableListState? tableListState = context.findAncestorStateOfType<TableListState>();
                  todolistHandler.deletetodoList(widget.todoList.seq!);
                  wastebasketHandler.insertdeletedTodoList(deletedtodolist);
                  tableListState!.setState(() {});
                  Get.back();
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    foregroundColor: Theme.of(context).colorScheme.error,
                    backgroundColor: Theme.of(context).colorScheme.onError),
                child: const Text(
                  '예',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: TextButton(
                onPressed: () => Get.back(),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                    foregroundColor: Theme.of(context).colorScheme.onError,
                    backgroundColor: Theme.of(context).colorScheme.error
                ),
                child: const Text('아니오',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  finishDialog() {
    Get.defaultDialog(
      radius: 10,
      title: '완료',
      titlePadding: const EdgeInsets.fromLTRB(0,20,0,0,),
      titleStyle: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold
      ),
      middleText: '완료 처리 하시겠습니까?',
      middleTextStyle: const TextStyle(
        fontSize: 22,
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      barrierDismissible: false,
      actions: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: TextButton(
                onPressed: () {
                  TableListState? tableListState = context.findAncestorStateOfType<TableListState>();
                  todolistHandler.deletetodoList(widget.todoList.seq!);
                  Donetodolist donetodolist = Donetodolist(
                    todolistSeq: widget.todoList.seq!, 
                    userSeq: int.parse(box.read('state')), 
                    title: widget.todoList.title, 
                    date: widget.todoList.date, 
                    serious: widget.todoList.serious, 
                    doneDate: DateTime.now().year.toString().padLeft(4, '0') +
                            DateTime.now().month.toString().padLeft(2, '0') +
                            DateTime.now().day.toString().padLeft(2, '0'),
                  );
                  donetodolistHandler.insertdoneTodoList(donetodolist);
                  tableListState!.setState(() {});
                  Get.back();
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                  foregroundColor: Theme.of(context).colorScheme.error,
                  backgroundColor: Theme.of(context).colorScheme.onError),
                child: const Text('예'),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: TextButton(
                onPressed: () => Get.back(),
                style:TextButton.styleFrom(
                  padding: const EdgeInsets.all(1),
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
                  foregroundColor: Theme.of(context).colorScheme.onError,
                  backgroundColor: Theme.of(context).colorScheme.error
                ),
                child: const Text('아니오')
              ),
            ),
          ],
        ),
      ],
    );
  }
}
