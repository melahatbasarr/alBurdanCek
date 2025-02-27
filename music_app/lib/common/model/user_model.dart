final class UserModel {
  int id;
  String name;
  String surname;
  String email;
  UserModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.email
  });

  factory UserModel.fromJson(Map<String,dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    surname: json["surname"],
    email: json["email"],
  );
}