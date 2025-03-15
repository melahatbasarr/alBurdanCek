import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/config/theme/custom_colors.dart';
import 'package:music_app/features/player/controller/player_controller.dart';

class FullPlayerPage extends StatefulWidget {
  final String title;
  final String artist;
  final String imageUrl;

  const FullPlayerPage({
    super.key, 
    required this.title,
    required this.artist,
    required this.imageUrl,
  });

  @override
  State<FullPlayerPage> createState() => _FullPlayerPageState();
}

class _FullPlayerPageState extends State<FullPlayerPage> {
  late final PlayerController _playerController;
  
  @override
  void initState() {
    super.initState();
    _playerController = Get.find<PlayerController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.darkGreyColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Now Playing",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Poppins Medium",
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Album Art
                  Container(
                    width: double.infinity,
                    height: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        _playerController.currentImageUrl.value,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print("Error loading image: ${_playerController.currentImageUrl.value} - $error");
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  CustomColors.orangeText.withOpacity(0.7),
                                  CustomColors.orangeText.withOpacity(0.3),
                                ],
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.music_note,
                                color: Colors.white,
                                size: 80,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 25),
                  
                  // Song and Artist
                  Obx(() => Text(
                    _playerController.currentTitle.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins Bold",
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
                  const SizedBox(height: 5),
                  Obx(() => Text(
                    _playerController.currentArtist.value,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: "Poppins Medium",
                    ),
                    textAlign: TextAlign.center,
                  )),
                  
                  const SizedBox(height: 30),
                  
                  // Progress Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "1:30",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Expanded(
                        child: Obx(() => Slider(
                          value: _playerController.progress.value,
                          activeColor: CustomColors.orangeText,
                          inactiveColor: Colors.grey.withOpacity(0.3),
                          onChanged: (value) {
                            _playerController.updateProgress(value);
                          },
                        )),
                      ),
                      const Text(
                        "3:45",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 5),
                  
                  // Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.shuffle,
                          color: Colors.grey,
                          size: 24,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.skip_previous,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: _playerController.playPreviousSong,
                      ),
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CustomColors.orangeText,
                          boxShadow: [
                            BoxShadow(
                              color: CustomColors.orangeText.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Obx(() => Icon(
                            _playerController.isPlaying.value ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 35,
                          )),
                          onPressed: _playerController.togglePlayPause,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.skip_next,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: _playerController.playNextSong,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.repeat,
                          color: Colors.grey,
                          size: 24,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Additional actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.playlist_add,
                          color: Colors.grey,
                          size: 26,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Obx(() => Icon(
                          _playerController.isFavorite.value 
                              ? Icons.favorite 
                              : Icons.favorite_border,
                          color: _playerController.isFavorite.value 
                              ? CustomColors.orangeText 
                              : Colors.grey,
                          size: 26,
                        )),
                        onPressed: _playerController.toggleFavorite,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.share,
                          color: Colors.grey,
                          size: 26,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 