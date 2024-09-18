/*
완료한 일 카드 
*/

import 'package:flutter/material.dart';
import 'package:todolist_v2/model/donetodolist.dart';
import 'package:todolist_v2/view/donepopupmenu.dart';
import 'package:todolist_v2/vm/donetodolist_handler.dart';

class CompleteCard extends StatefulWidget {
  const CompleteCard({super.key, required this.date});
  final String date;
  @override
  State<CompleteCard> createState() => _CompleteCardState();
}

class _CompleteCardState extends State<CompleteCard> {

  DonetodolistHandler donetodolistHandler = DonetodolistHandler();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width / 1.1,
      child: FutureBuilder(
        future: donetodolistHandler.querydoneTodoList(widget.date),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isEmpty? 
              Center(
                child: Text(
                  '완료된 일정이 없습니다.',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 28,
                  ),
                ),
              ): 
              ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Donetodolist donetodolist = Donetodolist(
                    seq: snapshot.data![index].seq,
                    todolistSeq: snapshot.data![index].todolistSeq,
                    userSeq: snapshot.data![index].userSeq,
                    title: snapshot.data![index].title,
                    date: snapshot.data![index].date,
                    serious: snapshot.data![index].serious,
                    doneDate: snapshot.data![index].doneDate,
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
                                    Icon(
                                      Icons.check,
                                      color: Theme.of(context).colorScheme.secondaryContainer,
                                      size: 24,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(268, 0, 0, 0),
                                      child: SizedBox(
                                        height: 30, 
                                        width: MediaQuery.of(context).size.width /9,
                                          child: StatefulBuilder(
                                            builder:(context, StateSetter popupState) {
                                              return Donepopupmenu(donetodolist: donetodolist,);
                                          }
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                                  child: Column(
                                    children: [
                                      Text(
                                        snapshot.data![index].title,
                                        style: TextStyle(
                                          fontSize: 26,
                                          color: Theme.of(context).colorScheme.secondaryContainer
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
    );
  }
}
