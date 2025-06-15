import 'package:flutter/material.dart';

class HomeBackground extends StatelessWidget {
  final Widget child;

  const HomeBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade700,
            Colors.white,
          ],
          stops: const [0.0, 0.8],
        ),
      ),
      child: SafeArea(
        child: child,
      ),
    );
  }
}
