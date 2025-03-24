import 'package:flutter/material.dart';
import 'package:pingcoin/constants/colors.dart';
import 'dart:math';

class CustomButton extends StatefulWidget {
  final String label;
  final VoidCallback func;
  final double? width;
  final String? fail;

  const CustomButton({super.key,this.fail, required this.label, required this.func, this.width});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> with SingleTickerProviderStateMixin {
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
            width: widget.width ?? MediaQuery.of(context).size.width,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: widget.fail=="fail"?Color(0xffFF7D7D):rGreen),
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  widget.fail=="fail"?Color(0xffFF7D7D).withOpacity(0.4):rGreen.withOpacity(0.22),
                  widget.fail=="fail"?Color(0xffFF7D7D).withOpacity(0.02):rGreen.withOpacity(0.02),
                ],
                begin: begin,
                end: end,
              ),
            ),
            alignment: Alignment.center,
            child: Text(widget.label, style: TextStyle(color: rWhite)),
          );
        },
      ),
    );
  }
}
