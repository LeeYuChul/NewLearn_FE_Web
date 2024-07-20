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
  List<Map<String, String>> _filteredStocks = [];
  Map<String, String>? _selectedStock;

  void _filterStocks(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredStocks = [];
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
    });
  }

  Widget companyTextField() {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: '삼성전자',
            filled: true,
            fillColor: AppColors.G8,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            suffixIcon: _selectedStock != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text(
                      _selectedStock!['code']!,
                      style: AppTextStyles.sc_20_r
                          .copyWith(color: AppColors.Black),
                    ),
                  )
                : null,
          ),
          onChanged: _filterStocks,
        ),
        if (_filteredStocks.isNotEmpty && _controller.text.length > 1)
          Container(
            color: Colors.white,
            child: ListView.builder(
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
                      _controller.text =
                          '${stock['name']} (${stock['market']})';
                      _filteredStocks.clear();
                    });
                  },
                );
              },
            ),
          ),
      ],
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

    return Container(
      width: screenWidth,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gaps.v160,
          Text(
            '회사명을 입력해주세요',
            style: AppTextStyles.sc_40_b.copyWith(color: AppColors.Black),
          ),
          Gaps.v40,
          companyTextField(),
          Gaps.v102,
          Text(
            '투자 성향을 선택해주세요',
            style: AppTextStyles.sc_40_b.copyWith(color: AppColors.Black),
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
        ],
      ),
    );
  }
}
