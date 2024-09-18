class User {
  int? seq;
  late String id;
  late String name;
  late String password;
  late String purchased;

  User({
    this.seq,
    required this.id,
    required this.name,
    required this.password,
    required this.purchased,
  });

  User.fromMap(Map<String, dynamic> res)
  : seq = res['seq'],
    id = res['id'],
    name = res['name'],
    password = res['password'],
    purchased = res['purchased'];
}
