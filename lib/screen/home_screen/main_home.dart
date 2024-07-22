import 'package:flutter/material.dart';
import 'package:newlearn_fe_web/constants/constants.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  // 배경 그라데이션 애니메이션 정의
  BoxDecoration animatedGradientBG = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.blue,
        Colors.purple,
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        decoration: animatedGradientBG,
        child: const ResponsiveLayout(
          desktopBody: HomePageDesktop(),
          mobileBody: HomePageDesktop(), // 수정 필요함 추후에 HomePageMobile()로 변경
        ),
      ),
    );
  }
}
