import 'package:flutter/material.dart';
import 'package:music_app/config/theme/custom_colors.dart';
import 'package:music_app/features/home/controller/home_controller.dart';
import 'package:music_app/features/settings/settings/screens/settings_page.dart';
import 'package:music_app/features/player/controller/player_controller.dart';
import 'package:music_app/common/widget/music_item_widget.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _controller = HomeController();
  final PlayerController _playerController = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.darkGreyColor,
      body: SafeArea(
        child: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ListView(
                physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 20),
                _buildSearchAndAvatarRow(),
                  const SizedBox(height: 25),
                  _buildCategorySection(),
                  const SizedBox(height: 25),
                  _buildRecentlyPlayedSection(),
                  const SizedBox(height: 25),
                  _buildPopularSongsSection(),
                  const SizedBox(height: 25),
                  _buildRecommendedPlaylistsSection(),
                  const SizedBox(height: 80), // Extra space for bottom navigation
              ],
            ),
          ),
        ],
        ),
      ),
    );
  }
  
  Widget _buildSearchAndAvatarRow() {
    return Row(
      children: [
        Expanded(
          child: _buildSearchField(),
        ),
        const SizedBox(width: 10),
        _buildAvatar(),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _controller.searchController,
      onChanged: _controller.onSearchChanged,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        hintText: 'Ara...',
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey.shade800,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SettingsPage(),
          ),
        );
      },
      child: CircleAvatar(
        backgroundImage: NetworkImage(_controller.user.avatarUrl),
        radius: 20,
      ),
    );
  }
  
  Widget _buildCategorySection() {
    return _buildSectionWithTitle(
      'Categories',
      ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _controller.getCategories().length,
        itemBuilder: (context, index) {
          final category = _controller.getCategories()[index];
          return _buildCategoryItem(category['name']!, category['image']!);
        },
      ),
      height: 120,
    );
  }

  Widget _buildRecentlyPlayedSection() {
    return _buildSectionWithTitle(
      'Recently Played',
      ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _controller.getRecentlyPlayed().length,
        itemBuilder: (context, index) {
          final song = _controller.getRecentlyPlayed()[index];
          return GestureDetector(
            onTap: () => _playerController.playSongFromPlaylist(
              _controller.getRecentlyPlayed(), index
            ),
            child: _buildMusicItem(
              song['title']!, 
              song['artist']!, 
              song['image']!,
              width: 130,
              height: 130,
              showPlayButton: true,
            ),
          );
        },
      ),
      height: 190,
    );
  }

  Widget _buildPopularSongsSection() {
    return _buildSectionWithTitle(
      'Popular Songs',
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _controller.getPopularSongs().length,
        itemBuilder: (context, index) {
          final song = _controller.getPopularSongs()[index];
          return GestureDetector(
            onTap: () => _playerController.playSongFromPlaylist(
              _controller.getPopularSongs(), index
            ),
            child: _buildPopularSongItem(
              song['title']!,
              song['artist']!,
              song['duration']!,
              song['image']!,
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecommendedPlaylistsSection() {
    return _buildSectionWithTitle(
      'Recommended Playlists',
      SizedBox(
        height: 220,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: _controller.getRecommendedPlaylists().length,
          itemBuilder: (context, index) {
            final playlist = _controller.getRecommendedPlaylists()[index];
            return _buildPlaylistItem(
              playlist['title']!,
              playlist['songCount']!,
              playlist['image']!,
              () => _playPlaylist(index),
            );
          },
        ),
      ),
    );
  }
  
  Widget _buildSectionWithTitle(String title, Widget content, {double? height}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
              fontFamily: "Poppins-Bold",
            ),
          ),
        ),
        const SizedBox(height: 15),
        height != null ? SizedBox(height: height, child: content) : content,
      ],
    );
  }

  Widget _buildMusicItem(String title, String artist, String imagePath, {
    double width = 130,
    double height = 130,
    bool showPlayButton = false,
  }) {
    return Container(
      width: width,
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height,
            width: width,
            child: Stack(
              children: [
                Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: _buildMusicImage(imagePath, 12),
                ),
                if (showPlayButton)
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: CustomColors.orangeText,
                        size: 20,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            artist,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildPopularSongItem(String title, String artist, String duration, String imagePath) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade800.withOpacity(0.3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            _buildMusicImage(imagePath, 10, size: 50),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    artist,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Text(
              duration,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.2),
              ),
              child: const Icon(Icons.play_arrow, color: CustomColors.orangeText),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaylistItem(String title, String songCount, String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey.shade800.withOpacity(0.3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: _buildMusicImage(imagePath, 16, isTopOnly: true),
                    ),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: CustomColors.orangeText,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      songCount,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCategoryItem(String title, String imagePath) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade800,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: _buildMusicImage(imagePath, 12, isTopOnly: true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMusicImage(String imagePath, double radius, {double size = 0, bool isTopOnly = false}) {
    BorderRadius borderRadius = isTopOnly
        ? BorderRadius.vertical(top: Radius.circular(radius))
        : BorderRadius.circular(radius);
    
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.asset(
        imagePath,
        width: size > 0 ? size : double.infinity,
        height: size > 0 ? size : double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print("Hata: Görsel yüklenemedi: $imagePath - $error");
          return Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  CustomColors.orangeText.withOpacity(0.7),
                  CustomColors.orangeText.withOpacity(0.3),
                ],
              ),
            ),
            child: Center(
              child: Icon(
                _getMusicIconFromPath(imagePath),
                color: Colors.white,
                size: size > 0 ? size * 0.5 : 40,
              ),
            ),
          );
        },
      ),
    );
  }
  
  IconData _getMusicIconFromPath(String path) {
    if (path.contains('category')) {
      return Icons.category;
    } else if (path.contains('playlist')) {
      return Icons.queue_music;
    } else {
      return Icons.music_note;
    }
  }
  
  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'pop':
        return Icons.music_note;
      case 'rock':
        return Icons.electric_bolt;
      case 'jazz':
        return Icons.queue_music;
      case 'classical':
        return Icons.music_note;
      case 'hip hop':
        return Icons.headphones;
      default:
        return Icons.music_note;
    }
  }
  
  void _playPlaylist(int index) {
    final playlists = _controller.getRecommendedPlaylists();
    final playlist = playlists[index];
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${playlist['title']} çalma listesi çalınıyor')),
    );
    
    // PlayerController'a oynatma komutu verebilirsiniz
    // _playerController.playPlaylist(playlistId);
  }
}


