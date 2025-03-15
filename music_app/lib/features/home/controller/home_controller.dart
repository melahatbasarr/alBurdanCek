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
    // Searching logic will be implemented here
  }
  
  // Get categories
  List<Map<String, String>> getCategories() {
    return [
      {'name': 'Pop', 'image': 'assets/music/music_1.jpeg'},
      {'name': 'Rock', 'image': 'assets/music/music_2.jpeg'},
      {'name': 'Jazz', 'image': 'assets/music/music_3.jpeg'},
      {'name': 'Classical', 'image': 'assets/music/music_4.jpeg'},
      {'name': 'Hip Hop', 'image': 'assets/music/music_5.jpeg'},
    ];
  }
  
  // Get recently played songs
  List<Map<String, String>> getRecentlyPlayed() {
    return [
      {'title': 'Imagine', 'artist': 'John Lennon', 'image': 'assets/music/music_7.jpeg'},
      {'title': 'Shape of You', 'artist': 'Ed Sheeran', 'image': 'assets/music/music_8.jpeg'},
      {'title': 'Billie Jean', 'artist': 'Michael Jackson', 'image': 'assets/music/music_9.jpeg'},
      {'title': 'Bohemian Rhapsody', 'artist': 'Queen', 'image': 'assets/music/music_10.jpeg'},
    ];
  }
  
  // Get popular songs
  List<Map<String, String>> getPopularSongs() {
    return [
      {'title': 'Blinding Lights', 'artist': 'The Weeknd', 'duration': '3:20', 'image': 'assets/music/music_11.jpeg'},
      {'title': 'Dance Monkey', 'artist': 'Tones and I', 'duration': '3:29', 'image': 'assets/music/music_12.jpeg'},
      {'title': 'Watermelon Sugar', 'artist': 'Harry Styles', 'duration': '2:54', 'image': 'assets/music/music_13.jpeg'},
      {'title': 'Don\'t Start Now', 'artist': 'Dua Lipa', 'duration': '3:03', 'image': 'assets/music/music_14.jpeg'},
    ];
  }
  
  // Get recommended playlists
  List<Map<String, String>> getRecommendedPlaylists() {
    return [
      {'title': 'Workout Mix', 'songCount': '15 songs', 'image': 'assets/music/music_15.jpeg'},
      {'title': 'Chill Vibes', 'songCount': '20 songs', 'image': 'assets/music/music_16.jpeg'},
      {'title': 'Road Trip', 'songCount': '18 songs', 'image': 'assets/music/music_17.jpeg'},
      {'title': 'Study Session', 'songCount': '25 songs', 'image': 'assets/music/musci_6.jpeg'}, // Dosya ismi hatası var, ama dosya adı böyle
    ];
  }
}
