class State {
  late int todayCount;
  late int finishCount;
  late int seriousCount;
  
  State(
    {
      required this.todayCount,
      required this.finishCount,
      required this.seriousCount,
    }
  );

  State.fromMap(Map<String, dynamic> res)
  : todayCount = res['todaycount'],
    finishCount = res['finishcount'],
    seriousCount = res['seriouscount'];
}