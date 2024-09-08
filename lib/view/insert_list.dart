import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/todo_list.dart';

class InsertList extends StatefulWidget {
  const InsertList({
    super.key,
    required this.icons,
    required this.list,
  });
  final List<TodoList> list;
  final List<IconData> icons;
  @override
  State<InsertList> createState() => _InsertListState();
}

class _InsertListState extends State<InsertList> {
  late TextEditingController titleEditingController;
  late TextEditingController durationEditingController;
  late TextEditingController contentEditingController;
  late IconData currentIcon;
  late List<Color> borderList;
  late List<TodoList> addList;

  @override
  void initState() {
    super.initState();
    addList = [
      TodoList(title: '', duration: '')
    ];
    borderList = [];
    for (int i = 0; i < widget.icons.length; i++) {
      borderList.add(Colors.yellow);
    }
    currentIcon = widget.icons[0];
    titleEditingController = TextEditingController();
    durationEditingController = TextEditingController();
    contentEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back(result: '아무것도 입력되지 않았습니다.');
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('할 일 추가하기'),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {});
        },
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.icons.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              currentIcon = widget.icons[index];
                              rebuildBorder(index);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 40,
                              height: 20,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: borderList[index],
                                width: 2.0,
                              )),
                              child: Card(
                                child: Row(
                                  children: [
                                    Icon(widget.icons[index]),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                    child: SizedBox(
                      height: 60,
                      width: 350,
                      child: TextField(
                        controller: titleEditingController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '할 일을 입력 하세요.',
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 60,
                      width: 350,
                      child: TextField(
                        controller: durationEditingController,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText:
                                (titleEditingController.text.trim().isEmpty)
                                    ? '할 일을 먼저 입력해주세요.'
                                    : '기한을 입력 하세요. ex)2024-08-06'),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 400,
                      width: 350,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {});
                        },
                        child: TextField(
                          minLines: 12,
                          maxLength: 40,
                          maxLines: 40,
                          controller: contentEditingController,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText:
                                  (titleEditingController.text.trim().isEmpty)
                                      ? '할 일을 먼저 입력해주세요.'
                                      : ' '),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _addList();
                    Get.back(result: addList);
                  },
                  child: const Text('추가하기'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addList() {
    if ((durationEditingController.text.trim().contains('-')) == false) {
      Get.defaultDialog(
          title: "입력 오류",
          middleText: "기한을 양식에 맞춰 입력해주세요.",
          backgroundColor: Colors.yellowAccent,
          barrierDismissible: false,
          actions: [
            TextButton(onPressed: () => Get.back(), child: const Text('확인'))
          ]);
    } else {
      addList[0].title = titleEditingController.text.trim();
      addList[0].duration = durationEditingController.text.toString();
    
      widget.list.add(addList[0]);
    }
    setState(() {});
  }

  rebuildBorder(index) {
    for (int i = 0; i < widget.icons.length; i++) {
      borderList[i] = Colors.yellow;
    }
    borderList[index] = Colors.red;
    currentIcon = widget.icons[index];
    setState(() {});
  }
}
