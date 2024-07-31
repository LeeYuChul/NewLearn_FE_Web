// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:newlearn_fe_web/constants/constants.dart';
import 'package:newlearn_fe_web/manage/data/stock_data.dart';

// GlobalKey 정의
class HomePageDesktop extends StatefulWidget {
  final VoidCallback onNext;
  static final GlobalKey<_HomePageDesktopState> homePageDesktopKey =
      GlobalKey<_HomePageDesktopState>();

  HomePageDesktop({required this.onNext}) : super(key: homePageDesktopKey);

  static _HomePageDesktopState? get currentState =>
      homePageDesktopKey.currentState;

  @override
  _HomePageDesktopState createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
  final TextEditingController _controller = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _textFieldKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  List<Map<String, String>> _filteredStocks = [];
  Map<String, String>? _selectedStock;
  int _selectedPeriodCard = 0;
  int _selectedPropensityCard = 0;

  Map<String, String>? get selectedStock => _selectedStock;
  int get selectedPeriodCard => _selectedPeriodCard;
  int get selectedPropensityCard => _selectedPropensityCard;

  //기간 선택 카드 탭
  void _onPeriodCardTap(int index) {
    setState(() {
      _selectedPeriodCard = index;
    });
  }

  //투자 성향 카드 탭
  void _onPropensityCardTap(int index) {
    setState(() {
      _selectedPropensityCard = index;
    });
  }

  //다음 버튼 활성화 조건
  bool get isNextButtonActive =>
      _selectedStock != null &&
      _selectedPeriodCard != 0 &&
      _selectedPropensityCard != 0;

  // 다음 버튼 활성화 탭
  void _onNextButtonTap() {
    if (isNextButtonActive) {
      widget.onNext();
    }
  }

  void _filterStocks(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredStocks = [];
        _removeOverlay();
      });
      return;
    }
    final List<Map<String, String>> results = stocks.where((stock) {
      final stockName = stock['name']?.toLowerCase() ?? '';
      final input = query.toLowerCase();
      return stockName.contains(input);
    }).toList();

    setState(() {
      _filteredStocks = results.take(5).toList();
      _showOverlay();
    });
  }

  void _showOverlay() {
    _removeOverlay();
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  //유사 리스트 메소드
  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox =
        _textFieldKey.currentContext!.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy +
            size.height, // 이 부분을 수정하여 TextField 바로 아래에 오버레이가 나타나도록 설정
        width: size.width,
        child: Material(
          elevation: 4.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            constraints: const BoxConstraints(
              maxHeight: 200,
            ),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: _filteredStocks.length,
              itemBuilder: (context, index) {
                final stock = _filteredStocks[index];
                return ListTile(
                  title: Text(stock['name']!),
                  subtitle: Text(stock['market']!),
                  onTap: () {
                    setState(() {
                      _selectedStock = stock;
                      _controller.text = '${stock['name']}';
                      _filteredStocks.clear();
                      _removeOverlay();
                    });
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  Widget companyTextField() {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        key: _textFieldKey,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'ex) 미래에셋증권, NAVER',
            hintStyle: const TextStyle(
              color: AppColors.G3,
            ),
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            suffixIcon: _selectedStock != null
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 12, 10),
                    child: Text(
                      "${_selectedStock!['market']!} | ${_selectedStock!['code']!}",
                      style: AppTextStyles.sc_20_r
                          .copyWith(color: AppColors.Black),
                    ),
                  )
                : null,
          ),
          onChanged: _filterStocks,
        ),
      ),
    );
  }

  //현재 연도를 가져오는 메소드
  int getThisYear() {
    return DateTime.now().year;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth >= 1400
        ? 152.0
        : screenWidth <= 600
            ? 24.0
            : 24.0 + (152.0 - 24.0) * ((screenWidth - 600) / (1400 - 600));

    return SingleChildScrollView(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          _removeOverlay();
        },
        child: Container(
          width: screenWidth,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gaps.v160,
              Text(
                '기업명이 무엇인가요?',
                style: AppTextStyles.sc_30_b.copyWith(color: AppColors.Black),
              ),
              Gaps.v40,
              companyTextField(),
              Gaps.v102,
              Text(
                '판단 기간을 어떻게 설정할까요?',
                style: AppTextStyles.sc_30_b.copyWith(color: AppColors.Black),
              ),
              Gaps.v40,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PeriodCard(
                    thisYearTitle: '3년',
                    thisYearDescription:
                        '${getThisYear() - 1}년부터 ${getThisYear() - 3}년의 기간 동안 판단합니다.',
                    thisPeriodOnTap: () => _onPeriodCardTap(3),
                    selectedPeriodCardNum: _selectedPeriodCard,
                    thisPeriodCardNum: 3,
                  ),
                  const SizedBox(width: 20),
                  PeriodCard(
                    thisYearTitle: '5년',
                    thisYearDescription:
                        '${getThisYear() - 1}년부터 ${getThisYear() - 5}년의 기간 동안 판단합니다.',
                    thisPeriodOnTap: () => _onPeriodCardTap(5),
                    selectedPeriodCardNum: _selectedPeriodCard,
                    thisPeriodCardNum: 5,
                  ),
                ],
              ),
              Gaps.v102,
              Text(
                '투자 성향이 어떻게 되시나요?',
                style: AppTextStyles.sc_30_b.copyWith(color: AppColors.Black),
              ),
              Gaps.v40,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PropensityCard(
                    thisPropTitle: '공격투자형',
                    thisPropDescription: '자산가치의 변동에 따른\n손실위험을 적극 수용함',
                    thisPropNum: 1,
                    selectedPropensityCard: _selectedPropensityCard,
                    thisPropOnTap: () => _onPropensityCardTap(1),
                  ),
                  Gaps.h20,
                  PropensityCard(
                    thisPropTitle: '위험중립형',
                    thisPropDescription: '투자에 상응하는 투자위험이\n있음을 충분히 인식하고 있음',
                    thisPropNum: 2,
                    selectedPropensityCard: _selectedPropensityCard,
                    thisPropOnTap: () => _onPropensityCardTap(2),
                  ),
                  Gaps.h20,
                  PropensityCard(
                    thisPropTitle: '안정형',
                    thisPropDescription: '투자원금에 손실이 발생하는 것을\n원하지 않음',
                    thisPropNum: 3,
                    selectedPropensityCard: _selectedPropensityCard,
                    thisPropOnTap: () => _onPropensityCardTap(3),
                  ),
                ],
              ),
              Gaps.v102,
              GestureDetector(
                onTap: _onNextButtonTap,
                child: Container(
                  width: 200,
                  height: 60,
                  decoration: BoxDecoration(
                    color: isNextButtonActive ? Colors.white : AppColors.G4,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '다음',
                      style: AppTextStyles.sc_20_b.copyWith(
                          color: isNextButtonActive
                              ? AppColors.Oragne
                              : AppColors.G3),
                    ),
                  ),
                ),
              ),
              Gaps.v160,
            ],
          ),
        ),
      ),
    );
  }
}
