import 'package:flutter/material.dart';
import 'package:music_app/common/widget/custom_widget.dart';
import 'package:music_app/config/theme/custom_colors.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.appBar("Bluetooth"),
      backgroundColor: CustomColors.darkGreyColor,
      body: Center(
        child: _buildBluetoothIconSection(),
      ),
    );
  }

  Widget _buildBluetoothIconSection() {
    return Container(
      width: 200,
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: const ClipOval(
        child: Center(
          child: Image(
            image: AssetImage("assets/images/icon.png"),
          ),
        ),
      ), /* const Icon(
        Icons.bluetooth,
        color: Colors.blueAccent,
        size: 60,
      ), */
    );
  }
}
