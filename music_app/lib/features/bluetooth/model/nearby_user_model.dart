class NearbyUserModel {
  final String id;
  final String username;
  final String avatarUrl;
  final double distance; // metre cinsinden
  final String currentSong;
  final String currentArtist;
  final String imageUrl;
  
  NearbyUserModel({
    required this.id,
    required this.username,
    required this.avatarUrl,
    required this.distance,
    required this.currentSong,
    required this.currentArtist,
    required this.imageUrl,
  });
} 