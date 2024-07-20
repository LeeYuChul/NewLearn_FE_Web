import 'package:flutter/material.dart';
import 'package:newlearn_fe_web/constants/font_table.dart';
import 'package:newlearn_fe_web/constants/gaps.dart';

class PropensityCard extends StatelessWidget {
  const PropensityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
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
              '타이틀',
              style: AppTextStyles.sc_30_b.copyWith(color: Colors.black),
            ),
            Gaps.v25,
            Container(
              width: 200,
              height: 200,
              color: Colors.grey,
            ),
            Gaps.v25,
            SizedBox(
              height: 48,
              child: Text(
                '타이틀\n이렇게',
                style: AppTextStyles.sc_20_r.copyWith(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
