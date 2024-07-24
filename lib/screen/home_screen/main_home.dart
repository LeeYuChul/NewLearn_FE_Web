import 'package:flutter/material.dart';
import 'package:newlearn_fe_web/constants/constants.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  bool showResultPage = false;

  void navigateToResultPage() {
    setState(() {
      showResultPage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final homePageDesktopState =
        HomePageDesktop.homePageDesktopKey.currentState;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Stack(
        children: [
          const Positioned.fill(
            child: AnimatedGradient(),
          ),
          Positioned.fill(
            child: ResponsiveLayout(
              desktopBody: showResultPage
                  ? MainResultPage(
                      selectedStock: homePageDesktopState?.selectedStock,
                      selectedPeriodCard:
                          homePageDesktopState?.selectedPeriodCard,
                      selectedPropensityCard:
                          homePageDesktopState?.selectedPropensityCard,
                    )
                  : HomePageDesktop(onNext: navigateToResultPage),
              mobileBody: showResultPage
                  ? MainResultPage(
                      selectedStock: homePageDesktopState?.selectedStock,
                      selectedPeriodCard:
                          homePageDesktopState?.selectedPeriodCard,
                      selectedPropensityCard:
                          homePageDesktopState?.selectedPropensityCard,
                    )
                  : HomePageDesktop(
                      onNext:
                          navigateToResultPage), // 수정 필요함 추후에 HomePageMobile()로 변경
            ),
          ),
        ],
      ),
    );
  }
}
