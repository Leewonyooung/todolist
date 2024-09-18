/*
휴지통 페이지
*/

import 'package:flutter/material.dart';
import 'package:todolist_v2/model/wastebasket.dart';
import 'package:todolist_v2/view/wastepopup.dart';
import 'package:todolist_v2/vm/wastebasket_handler.dart';

class DeletedTodo extends StatefulWidget {
  const DeletedTodo({super.key});

  @override
  State<DeletedTodo> createState() => DeletedTodoState();
}

class DeletedTodoState extends State<DeletedTodo> {
 late TextEditingController keywordController;
  late String keyword;
  late WastebasketHandler wastebasketHandler;

  @override
  void initState() {
    super.initState();
    keyword = '';
    keywordController = TextEditingController();
    wastebasketHandler = WastebasketHandler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 65,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        title: const Text(
          '휴지통',
          style: TextStyle(
            fontSize: 28,
          ),
        )
      ),
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: wastebasketHandler.querydeleted(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return 
              snapshot.data!.isEmpty ?
                SizedBox(
                width: MediaQuery.of(context).size.width / 1,
                height: MediaQuery.of(context).size.height / 1.1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '삭제된 일정이 없습니다.',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ) :
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height/1.1,
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Wastebasket deletedtodoList = Wastebasket(
                            seq: snapshot.data![index].seq,
                            todolistSeq: snapshot.data![index].todolistSeq, 
                            userSeq: snapshot.data![index].userSeq, 
                            title: snapshot.data![index].title, 
                            date: snapshot.data![index].date, 
                            serious: snapshot.data![index].serious, 
                            deletedDate: snapshot.data![index].deletedDate
                          );
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 7,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(15),
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20,20,0,20),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "제 목 : ",
                                              style: TextStyle(
                                                color: Theme.of(context).colorScheme.surface,
                                                fontSize: 24,
                                              ),
                                            ),
                                            Text(
                                              "날짜 : ",
                                              style: TextStyle(
                                                color: Theme.of(context).colorScheme.surface,
                                                fontSize: 24,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width / 2,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data![index].title,
                                                style: TextStyle(
                                                  color: Theme.of(context).colorScheme.surface,
                                                  fontSize: 24,
                                                ),
                                              ),
                                              Text(
                                                snapshot.data![index].date,
                                                style: TextStyle(
                                                  color: Theme.of(context).colorScheme.surface,
                                                  fontSize: 24,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.topRight,
                                    // height: 30,
                                    width: MediaQuery.of(context).size.width / 1.1 - 
                                          MediaQuery.of(context).size.width / 1.39,
                                    child: StatefulBuilder(
                                      builder: (context,StateSetter popupState) {
                                        return Wastepopup(deletedtodoList: deletedtodoList,
                                        );
                                      }
                                    ),
                                  ),
                              ]
                            )
                          )
                        );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return SizedBox(
                width: MediaQuery.of(context).size.width / 1,
                height: MediaQuery.of(context).size.height / 1.1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '찾으실 일정을 검색하세요.',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}