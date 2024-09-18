class TodoList {
  int? seq;
  late int count;
  late String title;
  late String date;
  late int serious;
  late int done;

  TodoList({
    this.seq,
    required this.title,
    required this.date,
    required this.serious,
    required this.done,
  });
  
  TodoList.fromMap(Map<String, dynamic> res)
  : seq = res['seq'],
    title = res['title'],
    date = res['date'],
    serious = res['serious'],
    done = res['done'];

  TodoList.countfromMap(Map<String, dynamic> res)
  : count = res['num'];
}
