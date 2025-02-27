import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/common/widget/custom_widget.dart';
import 'package:music_app/common/widget/orange_button.dart';
import 'package:music_app/config/theme/custom_colors.dart';
import 'package:music_app/features/settings/delete_account/controller/delete_acoount_controller.dart';
import 'package:music_app/features/settings/delete_account/repository/delete_account_repository.dart';

import '../../../../common/widget/login_animation.dart';

final class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

final class _DeleteAccountPageState extends State<DeleteAccountPage> with DeleteAccountDelegate {
  final DeleteAccountController _controller = DeleteAccountController(DeleteAccountRepositoryImpl());
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.delegate = this;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: CustomColors.darkGreyColor,
          appBar: CustomWidgets.appBar("Account Deletion Request"),
          body: ListView(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 20),
              _buildMessageInput(),
              const SizedBox(height: 30),
              OrangeButton(title: "Send", onTap: ()=>_checkFields()),
            ],
          ),
        ),

        Obx(()=>LoadingAnimation(isLoading: _controller.isLoading.value)),
      ],
    );
  }

  _buildMessageInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Please explain the reason for deleting your account",
          style: TextStyle(
            color: CustomColors.whiteText,
            fontFamily: "Poppins Regular",
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: _messageController,
          maxLines: 3,
          decoration: InputDecoration(
            isDense: true,
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  _showSentDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext){
        // ignore: deprecated_member_use
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            title: const Text(
              "Hesap Silme Talebi",
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Poppins SemiBold",
              ),
            ),
            content: const Text(
              "Your account deletion request has been sent to us. After the necessary examinations, your transaction will be carried out.",
              style: TextStyle(
                fontFamily: "Poppins Regular",
                fontSize: 12,
              ),
            ),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith((states) => CustomColors.orangeText),
                ),
                child: const Text(
                  "Back",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: (){
                  Navigator.pop(dialogContext);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _checkFields() {
    if(_messageController.text.isEmpty){
      CustomWidgets.showSnackBar(message: "Enter your message");
    } else {
      _controller.sendDeleteRequest(_messageController.text);
    }
  }

  @override
  void notify(bool isSuccess) {
    if(isSuccess){
      _showSentDialog();
    }
  }
}
