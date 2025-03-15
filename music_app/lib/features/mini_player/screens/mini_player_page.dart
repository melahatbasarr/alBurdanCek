import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/features/mini_player/screens/full_player_page.dart';
import 'package:music_app/features/player/controller/player_controller.dart';
import 'package:music_app/config/theme/custom_colors.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final PlayerController playerController = Get.find<PlayerController>();

    return Obx(() {
      // Eğer şarkı bilgileri boş ise mini player'ı gösterme
      if (playerController.currentTitle.value.isEmpty) {
        return const SizedBox.shrink();
      }

      return Positioned(
        left: 0,
        right: 0,
        bottom: 80, // Bottom navigation bar ile hizalı olacak
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FullPlayerPage(
                  title: playerController.currentTitle.value,
                  artist: playerController.currentArtist.value,
                  imageUrl: playerController.currentImageUrl.value,
                ),
              ),
            );
          },
          child: Material(
            color: Colors.black,
            elevation: 8.0, // Gölge ekleyerek derinlik hissi veriyoruz
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // İlerleme çubuğu
                SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 2.0,
                    thumbShape: SliderComponentShape.noThumb,
                    overlayShape: SliderComponentShape.noOverlay,
                  ),
                  child: Obx(() => Slider(
                    value: playerController.progress.value,
                    activeColor: CustomColors.orangeText,
                    inactiveColor: Colors.grey.withOpacity(0.2),
                    onChanged: (value) {
                      playerController.updateProgress(value);
                    },
                  )),
                ),
                
                Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey, width: 0.3)),
                  ),
                  child: Row(
                    children: [
                      // Albüm resmi
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          playerController.currentImageUrl.value,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.orange,
                              ),
                              child: const Icon(Icons.music_note, color: Colors.white, size: 20),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      // Şarkı ve sanatçı bilgisi
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              playerController.currentTitle.value,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              playerController.currentArtist.value,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      
                      // Oynatma kontrolleri
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            iconSize: 22,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(), // Boşluk kısıtlamalarını kaldırır
                            icon: const Icon(Icons.skip_previous, color: Colors.white),
                            onPressed: playerController.playPreviousSong,
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            iconSize: 30,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: Obx(() => Icon(
                              playerController.isPlaying.value ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                            )),
                            onPressed: playerController.togglePlayPause,
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            iconSize: 22,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(Icons.skip_next, color: Colors.white),
                            onPressed: playerController.playNextSong,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
