import 'package:flutter/material.dart';
import 'package:newlearn_fe_web/constants/color_table.dart';
import 'package:newlearn_fe_web/constants/font_table.dart';
import 'package:newlearn_fe_web/constants/gaps.dart';

class PropensityCard extends StatelessWidget {
  final String thisPropTitle, thisPropDescription;
  final int thisPropNum, selectedPropensityCard;
  final VoidCallback thisPropOnTap;

  const PropensityCard({
    super.key,
    required this.thisPropTitle,
    required this.thisPropDescription,
    required this.thisPropNum,
    required this.selectedPropensityCard,
    required this.thisPropOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: thisPropOnTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          decoration: BoxDecoration(
            color: selectedPropensityCard == thisPropNum
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
                thisPropTitle,
                style: AppTextStyles.sc_24_b.copyWith(color: Colors.black),
              ),
              Gaps.v25,
              SizedBox(
                height: 48,
                child: Text(
                  thisPropDescription,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.sc_16_r.copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
