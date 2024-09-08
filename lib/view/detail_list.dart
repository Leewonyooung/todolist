import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/todo_list.dart';

class DetailList extends StatefulWidget {
  const DetailList({super.key, required this.list, required this.index});
  final List<TodoList> list;
  final int index;
  @override
  State<DetailList> createState() => _DetailListState();
}

class _DetailListState extends State<DetailList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      appBar: AppBar(
        title: Text(widget.list[widget.index].title,
           style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
              // Get.to()
            }, 
            icon: const Icon(Icons.edit_note))
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Column(
                children: [
                  // Text(
                  //   style: TextStyle(
                  //     fontSize: 28,
                  //     color: Theme.of(context).colorScheme.surface,
                  //   ),
                  // ),
                ],
              ),
          ]
        ),
      ),
    );
  }
}
