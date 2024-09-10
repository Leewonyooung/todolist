class TodoList {
  int? seq;
  late String title;
  late String startDate;
  late String endDate;
  late int task;

  TodoList({
    this.seq,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.task,
  });
}
