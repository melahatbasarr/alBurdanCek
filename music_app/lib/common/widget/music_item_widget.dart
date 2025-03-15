import 'package:flutter/material.dart';
import 'package:music_app/config/theme/custom_colors.dart';

class MusicItemWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final bool showPlayButton;
  final bool isPlaylist;

  const MusicItemWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.onTap,
    this.width = 130,
    this.height = 130,
    this.showPlayButton = true,
    this.isPlaylist = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                    child: _buildMusicImage(),
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
              subtitle,
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
    );
  }

  Widget _buildMusicImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        imagePath,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print("Hata: Görsel yüklenemedi: $imagePath - $error");
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
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
                _getMusicIconFromPath(),
                color: Colors.white,
                size: 40,
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _getMusicIconFromPath() {
    if (isPlaylist) {
      return Icons.queue_music;
    } else if (imagePath.contains('category')) {
      return Icons.category;
    } else {
      return Icons.music_note;
    }
  }
} 