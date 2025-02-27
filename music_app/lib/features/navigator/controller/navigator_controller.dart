import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/features/bluetooth/screens/bluetooth_page.dart';
import 'package:music_app/features/home/screens/home_page.dart';
import 'package:music_app/features/library/screens/library_page.dart';

final class NavigatorController extends GetxController {
  var currentIndex = 0.obs;

  final List<Widget> pages = const [
    HomePage(),
    BluetoothPage(),
    LibraryPage(),
  ];
}
