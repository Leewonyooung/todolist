/*
Speed Dial 패키지를 이용한 
Floating Action Button 구현
*/

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:todolist_v2/view/add_todo.dart';
import 'package:todolist_v2/view/deleted_todo.dart';
import 'package:todolist_v2/view/search_todo.dart';
import 'package:todolist_v2/view/table_list.dart';

class Fab extends StatefulWidget {
  const Fab({super.key});

  @override
  State<Fab> createState() => _FabState();
}

class _FabState extends State<Fab> {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.edit_outlined,
      activeIcon: Icons.close,
      closeManually: false,
      childrenButtonSize: const Size(60, 60),
      buttonSize: const Size(60, 60),
      visible: true,
      curve: Curves.bounceIn,
      // renderOverlay: false,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      children: [
        SpeedDialChild(
          child: const Icon(
            Icons.add_outlined,
            color: Colors.white,
            size: 30,
          ),
          label: "일정 추가",
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w500, 
            color: Colors.white, 
            fontSize: 18
          ),
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
          labelBackgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
          onTap: () {
            Get.to(const AddTodo())!.then((value) => reloadData());
          }
        ),
        SpeedDialChild(
          child: const Icon(
            Icons.search_outlined,
            color: Colors.white,
            size: 30,
          ),
          label: "검색하기",
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
          labelBackgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w500, 
              color: Colors.white, 
              fontSize: 18.0),
          onTap: () => Get.to(
            const SearchTodo(),
            transition: Transition.topLevel,
            duration: const Duration(milliseconds: 800)
          ),
        ),
        SpeedDialChild(
          child: const Icon(
            Icons.delete_forever,
            color: Colors.white,
            size: 30,
          ),
          label: "휴지통",
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18
          ),
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
          labelBackgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
          onTap: () => 
            Get.to(const DeletedTodo())!.then((value) => reloadData()),
        ),
      ],
    );
  }

  reloadData() {
    TableListState? tableListState = context.findAncestorStateOfType<TableListState>();
    tableListState!.setState(() {});
  }
}
