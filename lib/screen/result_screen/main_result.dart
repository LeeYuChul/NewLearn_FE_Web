import 'package:flutter/material.dart';
import 'dart:async';
import 'package:newlearn_fe_web/constants/constants.dart';

class MainResultPage extends StatefulWidget {
  final Map<String, dynamic>? selectedStock;
  final int? selectedPeriodCard, selectedPropensityCard;
  final String caseType = 'HOLD'; // caseType 변수 추가

  const MainResultPage({
    super.key,
    this.selectedStock,
    this.selectedPeriodCard,
    this.selectedPropensityCard,
  });

  @override
  State<MainResultPage> createState() => _MainResultPageState();
}

class _MainResultPageState extends State<MainResultPage> {
  bool isLoading = true;
  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    setLoadingStop();
    _startRollingText();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void setLoadingStop() {
    _timer = Timer(const Duration(seconds: 6), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  void _startRollingText() {
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % 4; // 4 different messages
      });
    });
  }

  String getCurrentMessage() {
    switch (_currentIndex) {
      case 0:
        return '잠시만 기다려주세요';
      case 1:
        return '${widget.selectedStock?['name']} 기업의 ESG 정보를 분석하고 있습니다';
      case 2:
        return '${widget.selectedStock?['name']} 기업의 재무제표 데이터를 분석하고 있습니다';
      case 3:
        return '곧 분석 결과를 알려드리겠습니다';
      default:
        return '';
    }
  }

  Widget getAnimationWidget(String caseType) {
    switch (caseType) {
      case 'BUY':
        return WebAnimation.result_good;
      case 'HOLD':
        return WebAnimation.result_hold;
      // 필요한 경우 다른 case를 추가할 수 있습니다.
      default:
        return WebAnimation.result_good; // 기본값
    }
  }

  Color getTextColor(String caseType) {
    switch (caseType) {
      case 'BUY':
        return AppColors.Blue;
      case 'HOLD':
        return AppColors.Oragne;
      // 필요한 경우 다른 case를 추가할 수 있습니다.
      default:
        return AppColors.Black; // 기본값
    }
  }

  @override
  Widget build(BuildContext context) {
    String currentMessage = getCurrentMessage();
    String caseType = widget.caseType; // caseType 변수 가져오기

    if (isLoading) {
      return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 500,
              child: WebAnimation.resultLoading,
            ),
            const SizedBox(height: 20),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Text(
                currentMessage,
                key: ValueKey<int>(_currentIndex),
                style: AppTextStyles.sc_24_b.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }

    // 로딩완료 후 결과 화면
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(24, 24, 24, 12),
            padding: const EdgeInsets.fromLTRB(48, 24, 48, 48),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gaps.v60,
                        Text(
                          '${widget.selectedStock?['name']} 기업 매수 투자의견',
                          style: AppTextStyles.sc_30_b
                              .copyWith(color: Colors.black),
                        ),
                        Gaps.v15,
                        Text(
                          caseType,
                          style: TextStyle(
                            fontFamily: 'score',
                            fontSize: 60,
                            fontWeight: FontWeight.w800,
                            height: 72 / 60,
                            color: getTextColor(caseType),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 380,
                      width: 500,
                      child: getAnimationWidget(caseType),
                    ),
                  ],
                ),
                Gaps.v50,
                Text('투자 의견사유',
                    style: AppTextStyles.sc_30_b.copyWith(color: Colors.black)),
                Gaps.v20,
                Text('의견사유를 입력해주세요',
                    style: AppTextStyles.sc_20_r.copyWith(color: Colors.black)),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            padding: const EdgeInsets.fromLTRB(48, 24, 48, 48),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v20,
                Text('${widget.selectedStock?['name']} 기업 매수 상세 보고서',
                    style: AppTextStyles.sc_30_b.copyWith(color: Colors.black)),
                Gaps.v20,
                Container(
                  width: double.infinity,
                  height: 3,
                  color: AppColors.G5,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
