import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:newlearn_fe_web/constants/api_model_manage.dart';
import 'package:newlearn_fe_web/constants/constants.dart';

class FinancialDataDisplay extends StatefulWidget {
  final List<FinancialDataModel> financialData;
  final bool showFinancialData;
  final Function toggleDisplay;

  const FinancialDataDisplay({
    super.key,
    required this.financialData,
    required this.showFinancialData,
    required this.toggleDisplay,
  });

  @override
  FinancialDataDisplayState createState() => FinancialDataDisplayState();
}

class FinancialDataDisplayState extends State<FinancialDataDisplay> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => widget.toggleDisplay(),
            child: Row(
              children: [
                Text(
                  '재무제표 데이터',
                  style: AppTextStyles.sc_24_b.copyWith(color: Colors.black),
                ),
                Gaps.h10,
                Icon(
                  widget.showFinancialData
                      ? Icons.arrow_drop_down_circle_rounded
                      : Icons.arrow_drop_down_circle_outlined,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          if (widget.showFinancialData)
            GridView.count(
              shrinkWrap: true, // 내용 크기에 맞게 GridView 크기 조절
              physics: const NeverScrollableScrollPhysics(), // 스크롤 막기
              crossAxisCount: 2, // 한 줄에 2개의 그래프
              childAspectRatio: 2, // 그래프의 가로 세로 비율
              children: widget.financialData
                  .map((data) => buildFinancialChart(data))
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget buildFinancialChart(FinancialDataModel data) {
    List<BarChartGroupData> groups = [];
    List<MapEntry<String, double>> entries = data.periodData.entries.toList();
    double minY = 0;
    double maxY = 0;

    // 최대 및 최소값 계산
    if (entries.isNotEmpty) {
      minY = entries.first.value.toDouble();
      maxY = entries.first.value.toDouble();
      for (var entry in entries) {
        double value = entry.value.toDouble();
        if (value > maxY) maxY = value;
        if (value < minY) minY = value;
      }
    }

    // maxY 및 minY에 여유분 추가
    maxY += maxY * 0.1; // 최대값에 10% 추가
    if (minY < 0) {
      minY += minY * 0.1; // 음수일 경우 절댓값을 줄여서 여유 공간 추가
    } else {
      minY -= minY * 0.1; // 양수일 경우 감소
    }

    // 바 차트 그룹 데이터 생성
    for (int i = 0; i < entries.length; i++) {
      final entry = entries[i];
      groups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: entry.value.toDouble(),
              color: i % 2 == 0 ? AppColors.Blue : AppColors.Oragne,
              width: 15,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
      );
    }

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              data.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 229,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  minY: minY,
                  maxY: maxY,
                  barGroups: groups,
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          // 연도만 표시 (키의 첫 4자리)
                          return Text(
                            entries[index].key.substring(0, 4),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 10),
                          );
                        },
                        interval: 1,
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) => Text(
                          formatNumber(value),
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String formatNumber(double value) {
  if (value >= 1e9) {
    return '${(value / 1e9).toStringAsFixed(1)}B'; // 십억 단위
  } else if (value >= 1e6) {
    return '${(value / 1e6).toStringAsFixed(1)}M'; // 백만 단위
  } else if (value >= 1e3) {
    return '${(value / 1e3).toStringAsFixed(1)}K'; // 천 단위
  } else {
    return value.toStringAsFixed(1); // 그 외
  }
}
