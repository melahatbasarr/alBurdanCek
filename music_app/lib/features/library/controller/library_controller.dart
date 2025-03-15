import 'package:get/get.dart';
import 'package:music_app/features/home/controller/home_controller.dart';
import 'package:music_app/features/player/controller/player_controller.dart';

class LibraryController extends GetxController {
  final PlayerController _playerController = Get.find<PlayerController>();
  final HomeController _homeController = HomeController();
  
  final RxInt selectedTabIndex = 0.obs;
  
  List<Map<String, String>> getRecentlyAdded() {
    // Simüle edilmiş veriler - gerçek uygulamada veritabanından gelecektir
    return [
      ..._homeController.getRecentlyPlayed().take(3),
      ..._homeController.getPopularSongs().take(2),
    ];
  }
  
  List<Map<String, String>> getPlaylists() {
    // Simüle edilmiş veriler - gerçek uygulamada veritabanından gelecektir
    return _homeController.getRecommendedPlaylists();
  }
  
  List<Map<String, String>> getFavoriteSongs() {
    // Favori şarkıları PlayerController'dan al
    return _playerController.getFavoriteSongs();
  }
  
  void playFavoriteSong(int index) {
    final favorites = getFavoriteSongs();
    if (favorites.isNotEmpty && index < favorites.length) {
      _playerController.playSongFromPlaylist(favorites, index);
    }
  }
  
  void playRecentSong(int index) {
    final recents = getRecentlyAdded();
    if (recents.isNotEmpty && index < recents.length) {
      _playerController.playSongFromPlaylist(recents, index);
    }
  }
  
  void playPlaylist(int index) {
    final playlists = getPlaylists();
    if (playlists.isNotEmpty && index < playlists.length) {
      // Oynatma ekranına yönlendir ve içeriği çalmaya başla
      _playerController.playSong(
        playlists[index]['title'] ?? '',
        'Playlist',
        playlists[index]['image'] ?? '',
      );
    }
  }
  
  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
} 