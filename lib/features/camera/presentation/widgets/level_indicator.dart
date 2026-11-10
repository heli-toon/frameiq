import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class LevelIndicator extends StatefulWidget {
  const LevelIndicator({super.key});

  @override
  State<LevelIndicator> createState() => _LevelIndicatorState();
}

class _LevelIndicatorState extends State<LevelIndicator> {
  double _roll = 0; // Left/Right tilt
  double _pitch = 0; // Forward/Backward tilt
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;

  @override
  void initState() {
    super.initState();
    _accelerometerSubscription = accelerometerEventStream().listen((AccelerometerEvent event) {
      if (!mounted) return;
      setState(() {
        _roll = event.x;
        _pitch = event.y;
      });
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Threshold for being considered level
    final bool isLevelHorizontally = _roll.abs() < 0.25;
    final bool isLevel = isLevelHorizontally && (_pitch.abs() < 1.0);

    const levelColor = Color(0xFF10B981); // Emerald-500
    final normalColor = Colors.white.withValues(alpha: 0.45);

    return IgnorePointer(
      child: Center(
        child: SizedBox(
          width: 140,
          height: 140,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Minimalist center reticle dot
              Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isLevel ? levelColor : normalColor,
                ),
              ),

              // Rotating Horizon Bar
              AnimatedRotation(
                turns: _roll * -0.012,
                duration: const Duration(milliseconds: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left wing
                    Container(
                      width: 50,
                      height: 1.5,
                      decoration: BoxDecoration(
                        color: isLevel ? levelColor : normalColor,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                    const SizedBox(width: 40),
                    // Right wing
                    Container(
                      width: 50,
                      height: 1.5,
                      decoration: BoxDecoration(
                        color: isLevel ? levelColor : normalColor,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
