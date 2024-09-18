/*
휴지통에서 Card에 포함된 팝업메뉴버튼
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todolist_v2/model/todolist.dart';
import 'package:todolist_v2/model/wastebasket.dart';
import 'package:todolist_v2/view/deleted_todo.dart';
import 'package:todolist_v2/vm/todolist_handler.dart';
import 'package:todolist_v2/vm/wastebasket_handler.dart';

class Wastepopup extends StatefulWidget {
  const Wastepopup({super.key, required this.deletedtodoList});

  final Wastebasket deletedtodoList;
  @override
  State<Wastepopup> createState() => _WastepopupState();
}

class _WastepopupState extends State<Wastepopup> {
  TodolistHandler todolistHandler = TodolistHandler();
  WastebasketHandler wastebasketHandler = WastebasketHandler();
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Theme.of(context).colorScheme.tertiary
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
            _menuItem("복구"),
            _menuItem("완전 삭제"),
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
    return PopupMenuItem<String>(
      enabled: true,
      onTap: () {
        if (text == "복구") {
          restoreDialog();
        }
        if (text == "완전 삭제") {
          removeDialog();
        }
      },
      value: text,
      height: 35,
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

  restoreDialog() {
    Get.defaultDialog(
      radius: 10,
      title: '복구',
      titlePadding: const EdgeInsets.fromLTRB(0,20,0,0,),
      titleStyle: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold
      ),
      middleText: '복구 하시겠습니까?',
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
                  TodoList todolist = TodoList(
                    title: widget.deletedtodoList.title, 
                    date: widget.deletedtodoList.date, 
                    serious: widget.deletedtodoList.serious, 
                    done: 0,
                  );
                  wastebasketHandler.deletedeletedtodoList(widget.deletedtodoList.seq!);
                  todolistHandler.insertTodoList(todolist);
                  reloadData();
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

  removeDialog(){
     Get.defaultDialog(
      radius: 10,
      title: '완전 삭제',
      titlePadding: const EdgeInsets.fromLTRB(0,20,0,0,),
      titleStyle: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold
      ),
      middleText: '정말로 삭제하시겠습니까? \n 삭제 후 복구할 수 없습니다.',
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
                  wastebasketHandler.deletedeletedtodoList(widget.deletedtodoList.seq!);
                  reloadData();
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

  reloadData(){
    DeletedTodoState? deletedState = context.findAncestorStateOfType<DeletedTodoState>();
    deletedState!.setState(() {});
  }
}
