import 'package:flutter/material.dart';
import 'package:newlearn_fe_web/constants/constants.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.G1,
      appBar: CustomAppBar(),
      body: ResponsiveLayout(
        desktopBody: HomePageDesktop(),
        mobileBody: HomePageDesktop(), // 수정 필요함 추후에 HomePageMobile()로 변경
      ),
    );
  }
}
