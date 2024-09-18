class Searchtodo {
  int? seq;
  late String title;
  late String date;

  Searchtodo(
    {
      this.seq,
      required this.title,
      required this.date,
    }
  );

  Searchtodo.fromMap(Map<String, dynamic> res)
  : seq = res['seq'],
    title = res['title'],
    date = res['date'];
}