/*
FAB를 통해 연결되는 투두리스트 검색 페이지
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_v2/model/todolist.dart';
import 'package:todolist_v2/view/searchpopup.dart';
import 'package:todolist_v2/vm/donetodolist_handler.dart';
import 'package:todolist_v2/vm/todolist_handler.dart';

class SearchTodo extends StatefulWidget {
  const SearchTodo({super.key});

  @override
  State<SearchTodo> createState() => _SearchTodoState();
}

class _SearchTodoState extends State<SearchTodo> {
  late TextEditingController keywordController;
  late String keyword;
  late TodolistHandler todolistHandler;
  late DonetodolistHandler donetodolistHandler;

  @override
  void initState() {
    super.initState();
    keyword = '';
    todolistHandler = TodolistHandler();
    keywordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 65,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(8,8,0,12),
          child: Row(
            children: [
              SizedBox(
                height: 43,
                width: MediaQuery.of(context).size.width/1.38,
                child: SearchBar(
                  textStyle: WidgetStatePropertyAll(
                    TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 24,
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.inverseSurface),
                  controller: keywordController,
                  onChanged: (value) {
                    keyword = keywordController.text.trim();
                    setState(() {});
                  },
                  trailing: [
                    IconButton(
                      onPressed: () {   
                        keyword = keywordController.text.trim();
                        setState(() {});
                      }, 
                      icon: Icon(Icons.search,
                        color: Theme.of(context).colorScheme.surface
                      )
                    ),
                  ],
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  keywordController.text='';
                  keyword = '';
                  setState(() {});
                }, 
                child: Text('취소',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inverseSurface,
                    fontSize: 20,
                  ),
                )
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: FutureBuilder(
            future: todolistHandler.searchtodo(keyword),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return keyword == ''?
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1,
                    height: MediaQuery.of(context).size.height / 1.1,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('검색할 키워드를 입력하세요.',
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ) :
                snapshot.data!.isEmpty ?
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1,
                  height: MediaQuery.of(context).size.height / 1.1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          '찾으시는 일정이 없습니다.',
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
                            TodoList todoList = TodoList(
                              seq: snapshot.data![index].seq,
                              title: snapshot.data![index].title,
                              date: snapshot.data![index].date,
                              serious: snapshot.data![index].serious,
                              done: snapshot.data![index].done,
                            );
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.1,
                                height: MediaQuery.of(context).size.height / 7,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context).colorScheme.primaryContainer,
                                    width: 3
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  color:Theme.of(context).colorScheme.onPrimaryContainer,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                      alignment: Alignment.topRight,
                                      // height: 30,
                                     width: MediaQuery.of(context).size.width / 1.1 - 
                                          MediaQuery.of(context).size.width / 1.39,
                                      child: StatefulBuilder(
                                        builder: (context,StateSetter popupState) {
                                          return Searchpopup(todoList: todoList);
                                        }
                                      ),
                                    ),
                                  ],
                                ),
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
      ),
    );
  }
}