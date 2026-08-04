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
    _accelerometerSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      if (!mounted) return;
      setState(() {
        // Simple calculation for horizon leveling
        // In a real app, we might use more sophisticated sensor fusion
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
    // Determine if the camera is level (within a threshold)
    bool isLevelHorizontally = _roll.abs() < 0.2;
    bool isLevelVertically = _pitch.abs() < 0.2;
    bool isLevel = isLevelHorizontally && isLevelVertically;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Horizontal level indicator
        AnimatedRotation(
          turns: _roll * -0.01,
          duration: const Duration(milliseconds: 100),
          child: Container(
            width: 120,
            height: 4,
            decoration: BoxDecoration(
              color: isLevelHorizontally ? Colors.greenAccent : Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Vertical level indicator
        AnimatedRotation(
          turns: _pitch * 0.01, // Negative because of coordinate system
          duration: const Duration(milliseconds: 100),
          child: Container(
            width: 4,
            height: 120,
            decoration: BoxDecoration(
              color: isLevelVertically ? Colors.greenAccent : Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }
}