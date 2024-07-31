// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:newlearn_fe_web/constants/constants.dart';
import 'dart:html' as html;

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isFocusing = false;

  void _launchURL() {
    html.window.open('https://github.com/TeamNewLearn', '팀 뉴런 깃허브');
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 24,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'New:Learn',
                style: AppTextStyles.sc_20_b.copyWith(color: AppColors.Blue),
              ),
              Gaps.h10,
              Text(
                'X',
                style: AppTextStyles.sc_20_b.copyWith(color: AppColors.Black),
              ),
              Gaps.h10,
              Text(
                '2024 미래에셋증권 AI•Data Festival',
                style: AppTextStyles.sc_20_b.copyWith(color: AppColors.Oragne),
              ),
            ],
          ),
          if (MediaQuery.of(context).size.width >= 850)
            MouseRegion(
              onEnter: (_) {
                setState(() {
                  isFocusing = true;
                });
              },
              onExit: (_) {
                setState(() {
                  isFocusing = false;
                });
              },
              child: GestureDetector(
                onTap: _launchURL,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                  decoration: BoxDecoration(
                      color: isFocusing ? Colors.grey : const Color(0xff191A23),
                      borderRadius: BorderRadius.circular(14)),
                  child: const Text(
                    'Team New:Learn GitHub',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'SpaceGrotesk',
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
