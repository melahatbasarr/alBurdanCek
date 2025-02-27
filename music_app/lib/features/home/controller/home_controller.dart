import 'package:flutter/material.dart';
import 'package:music_app/features/home/model/home_model.dart';
class HomeController {
  // UserModel nesnesi oluşturuluyor
  final user = HomeModel(
    id: 1, // Eğer id int türünde ise int bir değer veriyoruz
    name: 'John', // Opsiyonel alanları da ekleyebilirsiniz
    surname: 'Doe',
    email: 'john.doe@example.com',
    avatarUrl: 'https://via.placeholder.com/150', // Parametre adını doğru yazdığınızdan emin olun
  );

  // Arama çubuğunu yönetmek için TextEditingController
  final searchController = TextEditingController();

  // Arama çubuğunda değişiklik olduğunda çalışacak metod
  void onSearchChanged(String value) {
  }
}
