// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WebAnimation {
  static Widget get resultLoading => Lottie.asset(
        'assets/animation/result_loading.json',
        repeat: true,
        frameRate: FrameRate.max,
        fit: BoxFit.fill,
      );
  static Widget get result_good => Lottie.asset(
        'assets/animation/result_good.json',
        repeat: true,
        frameRate: FrameRate.max,
        fit: BoxFit.fill,
      );
  static Widget get result_hold => Lottie.asset(
        'assets/animation/result_hold.json',
        repeat: true,
        frameRate: FrameRate.max,
        fit: BoxFit.fill,
      );
}
