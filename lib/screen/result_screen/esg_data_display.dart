// esg_data_display.dart
import 'package:flutter/material.dart';
import 'package:newlearn_fe_web/constants/api_model_manage.dart';
import 'package:newlearn_fe_web/constants/constants.dart';

class EsgDataDisplay extends StatefulWidget {
  final List<EsgNewsModel> esgData;
  final bool showEsgData;
  final Function toggleDisplay;

  const EsgDataDisplay({
    super.key,
    required this.esgData,
    required this.showEsgData,
    required this.toggleDisplay,
  });

  @override
  _EsgDataDisplayState createState() => _EsgDataDisplayState();
}

class _EsgDataDisplayState extends State<EsgDataDisplay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => widget.toggleDisplay(),
          child: Row(
            children: [
              Text(
                'ESG 분석 데이터',
                style: AppTextStyles.sc_24_b.copyWith(color: Colors.black),
              ),
              Gaps.h10,
              Icon(
                widget.showEsgData
                    ? Icons.arrow_drop_down_circle_rounded
                    : Icons.arrow_drop_down_circle_outlined,
                color: Colors.black,
              ),
            ],
          ),
        ),
        if (widget.showEsgData)
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              color: Colors.white,
              child: Column(
                children: widget.esgData.map((news) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            news.newsTitle,
                            style: AppTextStyles.sc_20_r
                                .copyWith(color: Colors.black),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            news.esgCategory,
                            style: AppTextStyles.sc_20_b
                                .copyWith(color: AppColors.Blue),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            news.esgScore.toString(),
                            style: AppTextStyles.sc_20_b
                                .copyWith(color: AppColors.Blue),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
      ],
    );
  }
}
