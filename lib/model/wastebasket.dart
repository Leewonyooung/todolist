class Wastebasket {
  int? seq;
  late int todolistSeq;
  late int userSeq;
  late String title;
  late String date;
  late int serious;
  late String deletedDate;

  Wastebasket({
    this.seq,
    required this.todolistSeq,
    required this.userSeq,
    required this.title,
    required this.date,
    required this.serious,
    required this.deletedDate,
  });

  Wastebasket.fromMap(Map<String, dynamic> res)
  : seq = res['seq'],
    todolistSeq = res['todolist_seq'],
    userSeq = res['user_seq'],
    title = res['title'],
    date = res['date'],
    serious = res['serious'],
    deletedDate = res['deleteddate'];
}
