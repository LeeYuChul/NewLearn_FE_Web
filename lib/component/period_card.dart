import 'package:flutter/material.dart';
import 'package:newlearn_fe_web/constants/color_table.dart';
import 'package:newlearn_fe_web/constants/font_table.dart';
import 'package:newlearn_fe_web/constants/gaps.dart';

class PeriodCard extends StatelessWidget {
  final String thisYearTitle, thisYearDescription;
  final VoidCallback thisPeriodOnTap;
  final int selectedPeriodCardNum, thisPeriodCardNum;

  const PeriodCard({
    super.key,
    required this.thisYearTitle,
    required this.thisYearDescription,
    required this.thisPeriodOnTap,
    required this.selectedPeriodCardNum,
    required this.thisPeriodCardNum,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: thisPeriodOnTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          decoration: BoxDecoration(
            color: selectedPeriodCardNum == thisPeriodCardNum
                ? AppColors.G4
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                thisYearTitle,
                style: AppTextStyles.sc_24_b.copyWith(color: Colors.black),
              ),
              Gaps.v25,
              SizedBox(
                height: 48,
                child: Center(
                  child: Text(
                    thisYearDescription,
                    style: AppTextStyles.sc_16_r.copyWith(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
