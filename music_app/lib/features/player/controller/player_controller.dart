import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerController extends GetxController {
  // Current playing song details
  final Rx<String> currentTitle = "".obs;
  final Rx<String> currentArtist = "".obs;
  final Rx<String> currentImageUrl = "".obs;
  final RxBool isPlaying = false.obs;
  final RxDouble progress = 0.0.obs;
  final RxInt currentSongIndex = 0.obs;
  final RxBool isFavorite = false.obs;
  
  // Playlist details
  final RxList<Map<String, String>> currentPlaylist = <Map<String, String>>[].obs;
  
  // Favorites
  final RxList<Map<String, String>> favoriteSongs = <Map<String, String>>[].obs;
  
  // Initialize with default values
  @override
  void onInit() {
    super.onInit();
    // Set default song to display in mini player until user selects a song
    currentTitle.value = "Shape of You";
    currentArtist.value = "Ed Sheeran";
    currentImageUrl.value = "assets/music/music_8.jpeg";
  }
  
  // Play song from specific data
  void playSong(String title, String artist, String imageUrl) {
    currentTitle.value = title;
    currentArtist.value = artist;
    currentImageUrl.value = imageUrl;
    isPlaying.value = true;
    _checkIfFavorite();
  }
  
  // Play song from playlist
  void playSongFromPlaylist(List<Map<String, String>> playlist, int index) {
    if (playlist.isEmpty || index < 0 || index >= playlist.length) return;
    
    currentPlaylist.value = playlist;
    currentSongIndex.value = index;
    
    final song = playlist[index];
    currentTitle.value = song['title'] ?? "";
    currentArtist.value = song['artist'] ?? "";
    currentImageUrl.value = song['image'] ?? "";
    isPlaying.value = true;
    _checkIfFavorite();
  }
  
  // Toggle play/pause
  void togglePlayPause() {
    isPlaying.value = !isPlaying.value;
  }
  
  // Play next song
  void playNextSong() {
    if (currentPlaylist.isEmpty) return;
    
    int nextIndex = (currentSongIndex.value + 1) % currentPlaylist.length;
    playSongFromPlaylist(currentPlaylist, nextIndex);
  }
  
  // Play previous song
  void playPreviousSong() {
    if (currentPlaylist.isEmpty) return;
    
    int prevIndex = (currentSongIndex.value - 1 + currentPlaylist.length) % currentPlaylist.length;
    playSongFromPlaylist(currentPlaylist, prevIndex);
  }
  
  // Update progress
  void updateProgress(double value) {
    if (value >= 0 && value <= 1.0) {
      progress.value = value;
    }
  }
  
  // Toggle favorite status
  void toggleFavorite() {
    if (currentTitle.value.isEmpty) return;
    
    if (isFavorite.value) {
      // Remove from favorites
      _removeFromFavorites();
    } else {
      // Add to favorites
      _addToFavorites();
    }
    
    isFavorite.toggle();
  }
  
  // Add current song to favorites
  void _addToFavorites() {
    final song = {
      'title': currentTitle.value,
      'artist': currentArtist.value,
      'image': currentImageUrl.value,
      'dateAdded': DateTime.now().toIso8601String(),
    };
    
    // Kontrol et, eğer aynı şarkı yoksa ekle
    bool exists = false;
    for (var favSong in favoriteSongs) {
      if (favSong['title'] == song['title'] && 
          favSong['artist'] == song['artist']) {
        exists = true;
        break;
      }
    }
    
    if (!exists) {
      favoriteSongs.add(song);
      Get.snackbar(
        'Favorilere Eklendi',
        '"${currentTitle.value}" favorilerinize eklendi',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black.withOpacity(0.7),
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
      );
    }
  }
  
  // Remove current song from favorites
  void _removeFromFavorites() {
    favoriteSongs.removeWhere((song) => 
      song['title'] == currentTitle.value && 
      song['artist'] == currentArtist.value
    );
    
    Get.snackbar(
      'Favorilerden Çıkarıldı',
      '"${currentTitle.value}" favorilerinizden çıkarıldı',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black.withOpacity(0.7),
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 2),
    );
  }
  
  // Check if current song is in favorites
  void _checkIfFavorite() {
    if (currentTitle.value.isEmpty) {
      isFavorite.value = false;
      return;
    }
    
    bool exists = false;
    for (var song in favoriteSongs) {
      if (song['title'] == currentTitle.value && 
          song['artist'] == currentArtist.value) {
        exists = true;
        break;
      }
    }
    
    isFavorite.value = exists;
  }
  
  // Get all favorite songs
  List<Map<String, String>> getFavoriteSongs() {
    return favoriteSongs;
  }
} 