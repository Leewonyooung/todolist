/*
완료한 일 카드의 팝업메뉴 버튼
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todolist_v2/model/donetodolist.dart';
import 'package:todolist_v2/model/wastebasket.dart';
import 'package:todolist_v2/view/table_list.dart';
import 'package:todolist_v2/vm/donetodolist_handler.dart';
import 'package:todolist_v2/vm/todolist_handler.dart';
import 'package:todolist_v2/vm/wastebasket_handler.dart';

class Donepopupmenu extends StatefulWidget {
  const Donepopupmenu({super.key, required this.donetodolist});
  final Donetodolist donetodolist;
  
  @override
  State<Donepopupmenu> createState() => _DonepopupmenuState();
}

class _DonepopupmenuState extends State<Donepopupmenu> {
  DonetodolistHandler donetodolisthandler = DonetodolistHandler();
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
            _menuItem("삭제"),
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
        if (text == "삭제") {
          deleteDialog();
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
                    todolistSeq: widget.donetodolist.seq!, 
                    userSeq: int.parse(box.read('state')), 
                    title: widget.donetodolist.title, 
                    date: widget.donetodolist.date, 
                    serious: widget.donetodolist.serious, 
                    deletedDate: DateTime.now().year.toString().padLeft(4, '0') +
                            DateTime.now().month.toString().padLeft(2, '0') +
                            DateTime.now().day.toString().padLeft(2, '0'),
                  );
                  TableListState? tableListState = context.findAncestorStateOfType<TableListState>();
                  donetodolisthandler.deletedonetodoList(widget.donetodolist.seq!);
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
}
