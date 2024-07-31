// stock_data_display.dart
import 'package:flutter/material.dart';
import 'package:newlearn_fe_web/constants/api_model_manage.dart';
import 'package:newlearn_fe_web/constants/constants.dart';

class StockDataDisplay extends StatefulWidget {
  final StockDataModel stockData;
  final bool showStockData;
  final Function toggleDisplay;

  const StockDataDisplay({
    super.key,
    required this.stockData,
    required this.showStockData,
    required this.toggleDisplay,
  });

  @override
  _StockDataDisplayState createState() => _StockDataDisplayState();
}

class _StockDataDisplayState extends State<StockDataDisplay> {
  @override
  Widget build(BuildContext context) {
    final stockData = widget.stockData;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => widget.toggleDisplay(),
          child: Row(
            children: [
              Text(
                '실시간 투자 데이터 ',
                style: AppTextStyles.sc_24_b.copyWith(color: Colors.black),
              ),
              Gaps.h10,
              Icon(
                widget.showStockData
                    ? Icons.arrow_drop_down_circle_rounded
                    : Icons.arrow_drop_down_circle_outlined,
                color: Colors.black,
              ),
            ],
          ),
        ),
        if (widget.showStockData)
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              color: Colors.white,
              child: Wrap(
                spacing: 20.0, // 칸 간격
                runSpacing: 20.0, // 줄 간격
                children: [
                  _buildStockDataItem('현재가', stockData.nowPrice),
                  _buildStockDataItem('전일 종가', stockData.previousClosePrice),
                  _buildStockDataItem('시가', stockData.openingPrice),
                  _buildStockDataItem('최고가', stockData.highPrice),
                  _buildStockDataItem('최저가', stockData.lowPrice),
                  _buildStockDataItem('거래량', stockData.volume),
                  _buildStockDataItem('거래대금', stockData.tradingVolume),
                  _buildStockDataItem('시가총액', stockData.marketCap),
                  _buildStockDataItem(
                      '외국인 소진율', stockData.foreignPossessionRate),
                  _buildStockDataItem('52주 최고가', stockData.high52Week),
                  _buildStockDataItem('52주 최저가', stockData.low52Week),
                  _buildStockDataItem('PER', stockData.per),
                  _buildStockDataItem('EPS', stockData.eps),
                  _buildStockDataItem('추정 PER', stockData.estimatedPer),
                  _buildStockDataItem('추정 EPS', stockData.estimatedEps),
                  _buildStockDataItem('PBR', stockData.pbr),
                  _buildStockDataItem('BPS', stockData.bps),
                  _buildStockDataItem('배당 수익률', stockData.dividendYield),
                  _buildStockDataItem('주당 배당금', stockData.dividendPerShare),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildStockDataItem(String title, String value) {
    return Container(
      width: (MediaQuery.of(context).size.width) / 5, // 5열로 나누기 위한 넓이 설정
      height: 80, // 고정된 높이 설정
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyles.sc_20_r.copyWith(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          Text(
            value,
            style: AppTextStyles.sc_20_b.copyWith(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
