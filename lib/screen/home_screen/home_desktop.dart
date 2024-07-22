import 'package:flutter/material.dart';
import 'package:newlearn_fe_web/constants/constants.dart';
import 'package:newlearn_fe_web/manage/data/stock_data.dart';

class HomePageDesktop extends StatefulWidget {
  const HomePageDesktop({super.key});

  @override
  State<HomePageDesktop> createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
  final TextEditingController _controller = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _textFieldKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  List<Map<String, String>> _filteredStocks = [];
  Map<String, String>? _selectedStock;

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
            hintText: 'ex) 삼성전자',
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth >= 1400
        ? 152.0
        : screenWidth <= 600
            ? 24.0
            : 24.0 + (152.0 - 24.0) * ((screenWidth - 600) / (1400 - 600));

    return GestureDetector(
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
              '회사명을 입력해주세요',
              style: AppTextStyles.sc_30_b.copyWith(color: AppColors.Black),
            ),
            Gaps.v40,
            companyTextField(),
            Gaps.v102,
            Text(
              '투자 성향을 선택해주세요',
              style: AppTextStyles.sc_30_b.copyWith(color: AppColors.Black),
            ),
            Gaps.v40,
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PropensityCard(),
                Gaps.h20,
                PropensityCard(),
                Gaps.h20,
                PropensityCard(),
              ],
            ),
            Gaps.v102,
            Container(
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
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
                  style:
                      AppTextStyles.sc_20_b.copyWith(color: AppColors.Oragne),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
