import 'package:get/get.dart';
import 'package:music_app/features/bluetooth/model/nearby_user_model.dart';
import 'package:music_app/features/player/controller/player_controller.dart';

class BluetoothController extends GetxController {
  final RxBool isScanning = false.obs;
  final RxList<NearbyUserModel> nearbyUsers = <NearbyUserModel>[].obs;
  final PlayerController _playerController = Get.find<PlayerController>();
  
  @override
  void onInit() {
    super.onInit();
    // Örnek veri ekleme - gerçek uygulamada Bluetooth API kullanılır
    _loadMockData();
  }
  
  void startScan() {
    isScanning.value = true;
    // Gerçek uygulamada burada bluetooth taraması başlatılır
    
    // Mock data için 2 saniye bekleme
    Future.delayed(const Duration(seconds: 2), () {
      isScanning.value = false;
    });
  }
  
  void stopScan() {
    isScanning.value = false;
    // Gerçek uygulamada burada bluetooth taraması durdurulur
  }
  
  void playNearbyUserSong(int index) {
    if (index >= 0 && index < nearbyUsers.length) {
      final user = nearbyUsers[index];
      _playerController.playSong(
        user.currentSong,
        user.currentArtist,
        user.imageUrl,
      );
    }
  }
  
  // Mock veri yükleme
  void _loadMockData() {
    nearbyUsers.addAll([
      NearbyUserModel(
        id: '1',
        username: 'Ahmet Y.',
        avatarUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
        distance: 15.5,
        currentSong: 'Billie Jean',
        currentArtist: 'Michael Jackson',
        imageUrl: 'assets/music/music_9.jpeg',
      ),
      NearbyUserModel(
        id: '2',
        username: 'Ayşe K.',
        avatarUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
        distance: 22.7,
        currentSong: 'Shape of You',
        currentArtist: 'Ed Sheeran',
        imageUrl: 'assets/music/music_8.jpeg',
      ),
      NearbyUserModel(
        id: '3',
        username: 'Mehmet A.',
        avatarUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
        distance: 35.2,
        currentSong: 'Blinding Lights',
        currentArtist: 'The Weeknd',
        imageUrl: 'assets/music/music_11.jpeg',
      ),
      NearbyUserModel(
        id: '4',
        username: 'Zeynep B.',
        avatarUrl: 'https://randomuser.me/api/portraits/women/4.jpg',
        distance: 47.9,
        currentSong: 'Dance Monkey',
        currentArtist: 'Tones and I',
        imageUrl: 'assets/music/music_12.jpeg',
      ),
      NearbyUserModel(
        id: '5',
        username: 'Can D.',
        avatarUrl: 'https://randomuser.me/api/portraits/men/5.jpg',
        distance: 58.3,
        currentSong: 'Watermelon Sugar',
        currentArtist: 'Harry Styles',
        imageUrl: 'assets/music/music_13.jpeg',
      ),
    ]);
  }
} 