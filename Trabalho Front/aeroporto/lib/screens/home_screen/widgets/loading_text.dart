import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingText extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color color;

  const LoadingText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.color = Colors.grey,
  });

  @override
  State<LoadingText> createState() => _LoadingTextState();
}

class _LoadingTextState extends State<LoadingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          widget.text,
          style: GoogleFonts.poppins(
            fontSize: widget.fontSize,
            color: widget.color.withOpacity(0.5 + (_animation.value * 0.5)),
          ),
        );
      },
    );
  }
}
