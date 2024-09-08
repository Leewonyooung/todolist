import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AddRestaurant extends StatefulWidget {
  const AddRestaurant({super.key});

  @override
  State<AddRestaurant> createState() => _AddRestaurantState();
}

class _AddRestaurantState extends State<AddRestaurant> {
  List<String> categories = Get.arguments ?? '__';
  String? selectedValue;
  late TextEditingController latitudeController;
  late TextEditingController longitudeController;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController representController;
  late TextEditingController commentController;
  late bool canRun;
  late List location;
  late double latData;
  late double longData;

  @override
  void initState() {
    super.initState();
    latitudeController = TextEditingController();
    longitudeController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    representController = TextEditingController();
    commentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 50,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          '일정 추가',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 720,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 23, 5),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '위치',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 8, 30, 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.black)),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                9,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            child: TextField(
                                              style: const TextStyle(
                                                fontSize: 13,
                                              ),
                                              textAlign: TextAlign.center,
                                              readOnly: true,
                                              controller: latitudeController,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.black)),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              9,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          child: TextField(
                                            style: const TextStyle(
                                              fontSize: 13,
                                            ),
                                            readOnly: true,
                                            textAlign: TextAlign.center,
                                            controller: longitudeController,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '이름',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.black)),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                9,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.25,
                                            child: TextField(
                                              controller: nameController,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '전화번호',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.black)),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                9,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.25,
                                            child: TextField(
                                              keyboardType: TextInputType.phone,
                                              controller: phoneController,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '분류',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.black)),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                9,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.25,
                                            child: DropdownButtonHideUnderline(
                                                child: DropdownButton2<String>(
                                              hint: const Text('분류'),
                                              items: categories
                                                  .map((String categories) =>
                                                      DropdownMenuItem<String>(
                                                        value: categories,
                                                        child: Text(categories),
                                                      ))
                                                  .toList(),
                                              value: selectedValue,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  selectedValue = value;
                                                });
                                              },
                                              buttonStyleData:
                                                  const ButtonStyleData(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                height: 45,
                                                width: 80,
                                              ),
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '대표음식',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.black)),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                9,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.25,
                                            child: TextField(
                                              controller: representController,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '메모',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.black)),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.25,
                                            child: TextField(
                                              minLines: 8,
                                              maxLines: 20,
                                              controller: commentController,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: ElevatedButton(
                        onPressed: () async {},
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .secondaryContainer),
                        child: const Text('추가 하기')),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
