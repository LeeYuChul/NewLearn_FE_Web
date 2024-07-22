import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:newlearn_fe_web/constants/constants.dart';

class AnimatedGradient extends StatefulWidget {
  const AnimatedGradient({super.key});

  @override
  State<AnimatedGradient> createState() => _AnimatedGradientState();
}

class _AnimatedGradientState extends State<AnimatedGradient>
    with TickerProviderStateMixin {
  late final MeshGradientController _controller;

  @override
  void initState() {
    super.initState();

    _controller = MeshGradientController(
      points: [
        MeshGradientPoint(
            position: const Offset(
              -1,
              0.2,
            ),
            color: AppColors.Oragne),
        MeshGradientPoint(
            position: const Offset(
              2,
              0.6,
            ),
            color: AppColors.Blue),
        MeshGradientPoint(
            position: const Offset(
              0.7,
              0.3,
            ),
            color: AppColors.B2),
        MeshGradientPoint(
            position: const Offset(
              0.4,
              0.8,
            ),
            color: AppColors.C2),
      ],
      vsync: this,
    );

    // Start infinite animation
    _startInfiniteAnimation();
  }

  void _startInfiniteAnimation() async {
    while (true) {
      await _controller.animateSequence(
        duration: const Duration(seconds: 6),
        sequences: [
          AnimationSequence(
            pointIndex: 0,
            newPoint: MeshGradientPoint(
              position: Offset(
                Random().nextDouble() * 2 - 0.5,
                Random().nextDouble() * 2 - 0.5,
              ),
              color: _controller.points.value[0].color,
            ),
            interval: const Interval(
              0,
              0.5,
              curve: Curves.easeInOut,
            ),
          ),
          AnimationSequence(
            pointIndex: 1,
            newPoint: MeshGradientPoint(
              position: Offset(
                Random().nextDouble() * 2 - 0.5,
                Random().nextDouble() * 2 - 0.5,
              ),
              color: _controller.points.value[1].color,
            ),
            interval: const Interval(
              0.25,
              0.75,
              curve: Curves.easeInOut,
            ),
          ),
          AnimationSequence(
            pointIndex: 2,
            newPoint: MeshGradientPoint(
              position: Offset(
                Random().nextDouble() * 2 - 0.5,
                Random().nextDouble() * 2 - 0.5,
              ),
              color: _controller.points.value[2].color,
            ),
            interval: const Interval(
              0.5,
              1,
              curve: Curves.easeInOut,
            ),
          ),
          AnimationSequence(
            pointIndex: 3,
            newPoint: MeshGradientPoint(
              position: Offset(
                Random().nextDouble() * 2 - 0.5,
                Random().nextDouble() * 2 - 0.5,
              ),
              color: _controller.points.value[3].color,
            ),
            interval: const Interval(
              0.75,
              1,
              curve: Curves.easeInOut,
            ),
          ),
        ],
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MeshGradient(
      controller: _controller,
      options: MeshGradientOptions(
        blend: 3.5,
        noiseIntensity: 0.2,
      ),
    );
  }
}
