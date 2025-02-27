class HomeModel {
  final int id; // Eğer id int türündeyse bu şekilde
  final String? name; // Opsiyonel hale getirdik
  final String? surname; // Opsiyonel hale getirdik
  final String? email; // Opsiyonel hale getirdik
  final String avatarUrl;

  HomeModel({
    required this.id,
    this.name,
    this.surname,
    this.email,
    required this.avatarUrl,
  });
}
