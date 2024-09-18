/*
메인 페이지의 해야 할일 카드 
*/

import 'package:flutter/material.dart';
import 'package:todolist_v2/model/todolist.dart';
import 'package:todolist_v2/view/popupmenu.dart';
import 'package:todolist_v2/view/table_list.dart';
import 'package:todolist_v2/vm/todolist_handler.dart';

class TodoCard extends StatefulWidget {
  const TodoCard({super.key, required this.date});
  final String date;

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  TodolistHandler todolistHandler = TodolistHandler();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width / 1.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(75),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: FutureBuilder(
          future: todolistHandler.queryTodoListbyDate(widget.date),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.isEmpty? 
                Center(
                  child: Text(
                    '예정된 일정이 없습니다.',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 28,
                    ),
                  ),
                ): 
                ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                  TodoList todoList = TodoList(
                    seq: snapshot.data![index].seq,
                    title: snapshot.data![index].title,
                    date: snapshot.data![index].date,
                    serious: snapshot.data![index].serious,
                    done: snapshot.data![index].done,
                  );
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: MediaQuery.of(context).size.height / 10,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            width: 2
                        ),
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).colorScheme.onPrimaryContainer
                      ),
                      child: Card(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        child: Row(
                          children: [
                            Padding(
                              padding:const EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          todolistHandler.updateSerious(todoList);
                                          TableListState? tablelistState = context.findAncestorStateOfType<TableListState>();
                                          tablelistState!.setState(() {});
                                        },
                                        child: Icon(
                                          snapshot.data![index].serious == 0 ? 
                                          Icons.star_outline_outlined: 
                                          Icons.star, 
                                          color: Theme.of(context).colorScheme.secondaryContainer,
                                          size: 24,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                          const EdgeInsets.fromLTRB(268, 0, 0, 0),
                                        child: SizedBox(
                                          height: 30,
                                          width: MediaQuery.of(context).size.width / 9,
                                          child: StatefulBuilder(
                                            builder: (context,StateSetter popupState) {
                                              return MyPopup(todoList: todoList);
                                            }
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                                    child: Text(
                                      snapshot.data![index].title,
                                      style: TextStyle(
                                        fontSize: 26,
                                        color: Theme.of(context).colorScheme.secondaryContainer
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
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
