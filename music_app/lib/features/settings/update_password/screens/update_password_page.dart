import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/common/widget/custom_widget.dart';
import 'package:music_app/common/widget/login_animation.dart';
import 'package:music_app/common/widget/orange_button.dart';
import 'package:music_app/common/widget/password_textfield.dart';
import 'package:music_app/config/theme/custom_colors.dart';
import 'package:music_app/features/settings/update_password/controller/update_password_controller.dart';
import 'package:music_app/features/settings/update_password/repository/update_password_repository.dart';


final class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

final class _UpdatePasswordPageState extends State<UpdatePasswordPage> with UpdatePasswordDelegate {
  final UpdatePasswordController _controller = UpdatePasswordController(UpdatePasswordRepositoryImpl());
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordConfirmController = TextEditingController();

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
          appBar: CustomWidgets.appBar("Şifre Güncelle"),
          body: ListView(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            children: [
              PasswordTextField(title: "Mevcut Şifre", controller: _currentPasswordController),
              const SizedBox(height: 12),
              PasswordTextField(title: "Yeni Şifre", controller: _newPasswordController),
              const SizedBox(height: 12),
              PasswordTextField(title: "Yeni Şifre Tekrar", controller: _newPasswordConfirmController),
              const SizedBox(height: 30),
              OrangeButton(title: "Güncelle", onTap: ()=>_checkFields()),
            ],
          ),
        ),

        Obx(()=>LoadingAnimation(isLoading: _controller.isLoading.value)),
      ],
    );
  }

  _showUpdatedDialog() {
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
              "Şifre Güncelle",
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Poppins SemiBold",
              ),
            ),
            content: const Text(
              "Hesabınızın şifresi başarıyla güncellenmiştir",
              style: TextStyle(
                fontFamily: "Poppins Regular",
                fontSize: 12,
              ),
            ),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith((states) =>CustomColors.darkGreyColor),
                ),
                child: const Text(
                  "Geri",
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
    if(_currentPasswordController.text.isEmpty){
      CustomWidgets.showSnackBar(message: "Mevcut şifrenizi giriniz");
    } else if(_newPasswordController.text.isEmpty){
      CustomWidgets.showSnackBar(message: "Yeni şifrenizi giriniz");
    } else if(_newPasswordConfirmController.text.isEmpty){
      CustomWidgets.showSnackBar(message: "Yeni şifrenizin tekrarını giriniz");
    } else if(_newPasswordController.text != _newPasswordConfirmController.text){
      CustomWidgets.showSnackBar(message: "Yeni şifreniz ile tekraraı aynı olmalıdır");
    } else {
      _controller.updatePassword(oldPassword: _currentPasswordController.text, newPassword: _newPasswordController.text);
    }
  }

  @override
  void notify(bool isSuccess) {
    if(isSuccess){
      _showUpdatedDialog();
    }
  }
}
