import 'package:flutter/material.dart';
import 'dart:async';
import 'package:newlearn_fe_web/constants/constants.dart';

class MainResultPage extends StatefulWidget {
  final Map<String, dynamic>? selectedStock;
  final int? selectedPeriodCard, selectedPropensityCard;

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
    _startRollingText();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    String currentMessage = getCurrentMessage();

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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      color: Colors.white.withOpacity(0.8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v100,
                    Text('매수 투자의견',
                        style: AppTextStyles.sc_30_b
                            .copyWith(color: Colors.black)),
                    Gaps.v15,
                    Text(
                      'BUY',
                      style:
                          AppTextStyles.sc_40_b.copyWith(color: Colors.black),
                    )
                  ],
                ),
                SizedBox(
                  height: 400,
                  width: 400,
                  child: WebAnimation.result_good,
                ),
              ],
            ),
            Text('투자 의견사유',
                style: AppTextStyles.sc_30_b.copyWith(color: Colors.black)),
            Gaps.v20,
            Text('의견사유를 입력해주세요',
                style: AppTextStyles.sc_20_r.copyWith(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
