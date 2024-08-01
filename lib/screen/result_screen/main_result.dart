// main_result_page.dart
import 'package:flutter/material.dart';
import 'package:newlearn_fe_web/constants/api_model_manage.dart';
import 'dart:async';
import 'package:newlearn_fe_web/constants/constants.dart';
import 'package:newlearn_fe_web/screen/result_screen/fin_data_display.dart';
import 'package:newlearn_fe_web/screen/result_screen/stock_data_display.dart';
import 'package:newlearn_fe_web/screen/result_screen/esg_data_display.dart';

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
  bool isLoading = false;
  int _currentIndex = 0;
  late Timer _timer;

  // UI에 표시될 데이터들 선언
  String caseType = 'BUY';
  String reason = '';
  bool showStockData = false;
  bool showEsgData = false;
  bool showFinancialData = false; // 재무 데이터 표시 여부
  StockDataModel? stockData;
  List<EsgNewsModel>? esgData; // ESG 데이터
  List<FinancialDataModel>? financialData; // 재무 데이터

  @override
  void initState() {
    super.initState();
    _startRollingText();
    // clovaAPI();
    getStockData();
    getEsgResult();
    getFinancialData();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startRollingText() {
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % 5;
      });
    });
  }

  Future<void> getFinancialData() async {
    try {
      final result = await DetailResultApiManage.fetchFinancialData(
          widget.selectedStock?['code'], widget.selectedPeriodCard ?? 3);
      setState(() {
        financialData = result;
      });
    } catch (e) {
      print('Error fetching financial data: $e');
    }
  }

  Future<void> getStockData() async {
    try {
      final result = await DetailResultApiManage.fetchStockData(
          widget.selectedStock?['code']);
      setState(() {
        stockData = result;
      });
    } catch (e) {
      print('Error fetching stock data: $e');
    }
  }

  Future<void> getEsgResult() async {
    try {
      final result = await DetailResultApiManage.fetchEsgNewsResults(
          widget.selectedStock?['code']);
      setState(() {
        esgData = result;
      });
    } catch (e) {
      print('Error fetching ESG data: $e');
    }
  }

  void clovaAPI() async {
    try {
      final result = await ClovaApiManage.fetchFinalAnswer(
        companyName: widget.selectedStock?['name'],
        stockCode: widget.selectedStock?['code'],
        period: widget.selectedPeriodCard.toString(),
      );
      setState(() {
        caseType = result.buysellopinion;
        reason = result.reason;
        isLoading = false;
      });
    } catch (e) {
      print('클로바:Error fetching data: $e');
    }
  }

  void toggleStockDataDisplay() {
    setState(() {
      showStockData = !showStockData;
    });
  }

  void toggleEsgDataDisplay() {
    setState(() {
      showEsgData = !showEsgData;
    });
  }

  void toggleFinancialData() {
    setState(() {
      showFinancialData = !showFinancialData;
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
      case 4:
        return '결과를 받기까지 평균 1분 40초가 필요합니다';
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
      default:
        return WebAnimation.result_good;
    }
  }

  Color getTextColor(String caseType) {
    switch (caseType) {
      case 'BUY':
        return AppColors.Blue;
      case 'HOLD':
        return AppColors.Oragne;
      default:
        return AppColors.Black;
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
                          '${widget.selectedStock?['name']} ESG 가치 통합 분석',
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
                Text('AI 매수 의견서',
                    style: AppTextStyles.sc_30_b.copyWith(color: Colors.black)),
                Gaps.v20,
                Text(reason,
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
                ),
                Gaps.v20,
                if (stockData != null)
                  StockDataDisplay(
                    stockData: stockData!,
                    showStockData: showStockData,
                    toggleDisplay: toggleStockDataDisplay,
                  ),
                Gaps.v20,
                if (esgData != null)
                  EsgDataDisplay(
                    esgData: esgData!,
                    showEsgData: showEsgData,
                    toggleDisplay: toggleEsgDataDisplay,
                  ),
                Gaps.v20,
                if (financialData != null)
                  FinancialDataDisplay(
                    financialData: financialData!,
                    showFinancialData: showFinancialData,
                    toggleDisplay: toggleFinancialData,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
