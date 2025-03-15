import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/common/widget/custom_widget.dart';
import 'package:music_app/config/theme/custom_colors.dart';
import 'package:music_app/features/bluetooth/controller/bluetooth_controller.dart';
import 'package:music_app/features/bluetooth/model/nearby_user_model.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> with SingleTickerProviderStateMixin {
  late final BluetoothController _controller;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _isExpanded = false;
  bool _isFullScreen = false;
  
  @override
  void initState() {
    super.initState();
    _controller = Get.put(BluetoothController());
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
        _controller.startScan();
      } else {
        _animationController.reverse();
        _controller.stopScan();
        _isFullScreen = false;
      }
    });
  }
  
  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: CustomWidgets.appBar("Bluetooth"),
      backgroundColor: CustomColors.darkGreyColor,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _toggleExpanded,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: _isExpanded ? 120 : 200,
                    height: _isExpanded ? 120 : 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: CustomColors.orangeText.withOpacity(0.5),
                          blurRadius: _isExpanded ? 20 : 10,
                          spreadRadius: _isExpanded ? 5 : 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Obx(() => AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _controller.isScanning.value
                            ? CircularProgressIndicator(
                                color: CustomColors.orangeText,
                                strokeWidth: 3,
                              )
                            : Image.asset(
                                "assets/icons/bocek.png",
                                width: _isExpanded ? 60 : 100,
                                height: _isExpanded ? 60 : 100,
                              ),
                      )),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                AnimatedOpacity(
                  opacity: _isExpanded ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    "Çevrenizdeki müzikleri keşfedin",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16,
                      fontFamily: "Poppins Medium",
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Expanded Panel
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Positioned(
                // Panel ortada olacak şekilde konumlandırılıyor
                top: _isFullScreen 
                    ? size.height * 0.05 // Tam ekran modunda üstte
                    : size.height * 0.25, // Normal modda ortada
                left: _isFullScreen 
                    ? size.width * 0.05 // Tam ekran modunda sol kenardan az uzakta
                    : size.width * 0.1, // Normal modda sol kenardan uzakta
                right: _isFullScreen 
                    ? size.width * 0.05 // Tam ekran modunda sağ kenardan az uzakta
                    : size.width * 0.1, // Normal modda sağ kenardan uzakta
                child: AnimatedOpacity(
                  opacity: _fadeAnimation.value,
                  duration: const Duration(milliseconds: 300),
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: _isFullScreen 
                          ? size.height * 0.8 // Tam ekran modunda neredeyse tam ekran
                          : size.height * 0.5, // Normal modda yarım ekran
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Yakınınızdaki Müzikler",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins Medium",
                                  ),
                                ),
                                Row(
                                  children: [
                                    // Büyütme/Küçültme butonu
                                    IconButton(
                                      icon: Icon(
                                        _isFullScreen 
                                            ? Icons.fullscreen_exit
                                            : Icons.fullscreen,
                                        color: Colors.grey,
                                      ),
                                      onPressed: _toggleFullScreen,
                                    ),
                                    // Kapatma butonu
                                    IconButton(
                                      icon: const Icon(Icons.close, color: Colors.grey),
                                      onPressed: _toggleExpanded,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Ripple animasyonlu bir ayraç çizgisi
                          Container(
                            height: 2,
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  CustomColors.orangeText.withOpacity(0.5),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: Obx(() => ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              itemCount: _controller.nearbyUsers.length,
                              itemBuilder: (context, index) {
                                return _buildNearbyUserItem(
                                  _controller.nearbyUsers[index],
                                  () => _controller.playNearbyUserSong(index),
                                );
                              },
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildNearbyUserItem(NearbyUserModel user, VoidCallback onPlay) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade800.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
        // Hafif parıltı efekti
        boxShadow: [
          BoxShadow(
            color: CustomColors.orangeText.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          // Kullanıcı avatarı
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: CustomColors.orangeText.withOpacity(0.3),
                width: 2,
              ),
              image: DecorationImage(
                image: NetworkImage(user.avatarUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // Kullanıcı ve şarkı bilgileri
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      user.username,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: CustomColors.orangeText.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "${user.distance.toStringAsFixed(1)} m",
                        style: TextStyle(
                          color: CustomColors.orangeText,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  user.currentSong,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  user.currentArtist,
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
          // Çalma butonu
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  CustomColors.orangeText.withOpacity(0.7),
                  CustomColors.orangeText.withOpacity(0.3),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 20,
              ),
              padding: EdgeInsets.zero,
              onPressed: onPlay,
            ),
          ),
        ],
      ),
    );
  }
}
