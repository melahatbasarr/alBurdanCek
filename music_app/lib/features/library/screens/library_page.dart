import 'package:flutter/material.dart';
import 'package:music_app/config/theme/custom_colors.dart';
import 'package:music_app/common/widget/custom_widget.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomWidgets.appBar("Library"),
      backgroundColor: CustomColors.darkGreyColor,
    );
  }
}
