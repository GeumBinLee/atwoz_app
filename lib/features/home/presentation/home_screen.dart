import 'package:atwoz_app/core/theme/theme.dart';
import 'package:atwoz_app/features/home/widget/home_category_buttons_area.dart';
import 'package:atwoz_app/features/home/widget/home_navbar_area.dart';
import 'package:atwoz_app/features/home/widget/home_profile_card_area.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> hashTagList = ["#클라이밍", "#불교", "#무계획 여행", "+2"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeNavbarArea(), // 홈 상단 네비게이션바
              SizedBox(height: 16),
              HomeProfileCardArea(hashTagList: hashTagList), // 소개받은 프로필 페이지
              SizedBox(height: 16),
              Image.asset(
                "assets/images/home_test.png",
                fit: BoxFit.cover,
                width: context.screenWidth,
                height: 89,
              ),
              SizedBox(height: 24),
              HomeCategoryButtonsArea()
            ],
          ),
        ),
      )),
    );
  }
}
