import 'package:flutter/material.dart';
import 'package:newlearn_fe_web/constants/constants.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  bool showResultPage = true;

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
                  ? const MainResultPage(
                      selectedStock: {
                        'name': '삼성전자',
                        'code': '005930',
                        'market': 'KOSPI',
                      },
                      selectedPeriodCard: 1,
                      selectedPropensityCard: 3,
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
