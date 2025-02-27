import 'package:flutter/material.dart';
import 'package:music_app/config/theme/custom_colors.dart';
import 'package:music_app/features/auth/login/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

final class _OnBoardingPageState extends State<OnBoardingPage> {
  final List<String> titles = [
    "Fastest Payment in the world",
    "The most Secure Platform for Customer",
    "Paying for Everything is Easy and Convenient"
  ];
  final List<String> contents = [
    "Integrate multiple payment methods to help you up the process quickly",
    "Integrate multiple payment methods to help you up the process quickly",
    "Integrate multiple payment methods to help you up the process quickly"
  ];
  final PageController pageController = PageController();
  var selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.darkGreyColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: 3,
            itemBuilder: (builderContext, index) {
              return _buildPageContent(index);
            },
            onPageChanged: (index) {
              setState(() {
                selectedPageIndex = index;
              });
            },
          ),
          _buildNextButton(),
        ],
      ),
    );
  }

  _buildPageContent(int index) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding:
          const EdgeInsets.only(right: 50, left: 50, top: 100, bottom: 100),
      children: [
        Image.asset("assets/images/ob${index + 1}.png"),
        const SizedBox(height: 70),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (indicatorIndex) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 7),
              width: selectedPageIndex == indicatorIndex ? 12 : 7,
              height: 7,
              decoration: BoxDecoration(
                color: selectedPageIndex == indicatorIndex
                    ? CustomColors.orangeText
                    : CustomColors.whiteText.withOpacity(0.5),
                borderRadius: BorderRadius.circular(50),
              ),
            );
          }),
        ),
        const SizedBox(height: 70),
        Text(
          titles[index],
          style: const TextStyle(
            fontFamily: "Poppins SemiBold",
            fontSize: 26,
            height: 1,
            color: CustomColors.whiteText,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          contents[index],
          style: const TextStyle(
            fontFamily: "Poppins Regular",
            fontSize: 14,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Next button
  _buildNextButton() {
    return GestureDetector(
      onTap: () async {
        if (selectedPageIndex < 2) {
          pageController.animateToPage(selectedPageIndex + 1,
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear);
        } else {
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setBool("isOnBoardingSeen", true);
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false);
          }
        }
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: CustomColors.orangeText,
        ),
        alignment: Alignment.center,
        child: const Text(
          "Next",
          style: TextStyle(
            color: CustomColors.darkGreyColor,
          ),
        ),
      ),
    );
  }
}
