import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_v2/model/todo_list.dart';
import 'package:todolist_v2/view/detail_list.dart';

class PastTable extends StatefulWidget {
  final List<TodoList> list;
  const PastTable({super.key, required this.list,});

  @override
  State<PastTable> createState() => _PastTableState();
}

class _PastTableState extends State<PastTable> {
  late List<TodoList> todoList;
  late String strToday;
  late List<String> today;
  late double percent;
  late String textpercent;
  
  @override
  void initState() {
    super.initState();
    todoList = [];
    percent = 0;
    textpercent = '';
    addData();
  }

  addData() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('예전 할 일'),
      ),
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
            child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(
                45,
                40,
                0,
                0,
              ),
              child: Row(
                children: [
                  Text(
                    '예전 할 일',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 30, 20, 0),
                  child: SizedBox(
                    height: 700,
                    width: 500,
                    child: ListView.builder(
                        itemCount: widget.list.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            direction: DismissDirection.endToStart,
                            key: ValueKey(widget.list[index]),
                            onDismissed: (direction) {
                              widget.list.remove(widget.list[index]);
                              
                            },
                            background: Container(
                              height: 100,
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: const Icon(
                                Icons.delete_forever,
                                size: 50,
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(DetailList(
                                  list: widget.list,
                                  index: index,
                                ));
                              },
                              child: SizedBox(
                                height: 70,              
                                child: Row(
                                  children: [
                                  
                                    SizedBox(
                                      height: 70,
                                      width: 330,
                                      child: Card(
                                        color: index % 2 == 0
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                        child: Row(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                15,
                                                0,
                                                15,
                                                0,
                                              ),
                                            ),
                                      
                                            Text(
                                              '   ${widget.list[index].title}',
                                              style: TextStyle(
                                                color: index % 2 == 0
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary
                                                    : Theme.of(context)
                                                        .colorScheme
                                                        .onSecondary,
                                                fontSize: 30,
                                                fontWeight: FontWeight.w300,
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
                          );
                        }),
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
 
}
