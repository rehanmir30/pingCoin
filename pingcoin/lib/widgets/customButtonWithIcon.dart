import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

import '../constants/colors.dart';

class CustomButtonWithIcon extends StatefulWidget {
  final String label;
  final VoidCallback func;

  const CustomButtonWithIcon({super.key, required this.label, required this.func});

  @override
  State<CustomButtonWithIcon> createState() => _CustomButtonWithIconState();
}

class _CustomButtonWithIconState extends State<CustomButtonWithIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.func,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          // Convert animation value into radians (0 to 2π for a full circle)
          double angle = _controller.value * 2 * pi;

          // Use sine and cosine to create a circular movement pattern
          Alignment begin = Alignment(cos(angle), sin(angle));
          Alignment end = Alignment(-cos(angle), -sin(angle));

          return Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: rGreen),
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  rGreen.withOpacity(0.22),
                  rGreen.withOpacity(0.02),
                ],
                begin: begin,
                end: end,
              ),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.label, style: TextStyle(color: rWhite)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.chevron_right, color: rWhite.withOpacity(0.2)),
                    Icon(Icons.chevron_right, color: rWhite.withOpacity(0.5)),
                    Icon(Icons.chevron_right, color: rWhite.withOpacity(0.8)),
                  ],
                )
              ],
            ).marginSymmetric(horizontal: 12),
          );
        },
      ),
    );
  }
}
