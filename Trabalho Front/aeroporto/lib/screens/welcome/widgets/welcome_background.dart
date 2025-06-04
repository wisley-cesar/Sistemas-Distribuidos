import 'package:flutter/material.dart';

class WelcomeBackground extends StatelessWidget {
  final Widget child;

  const WelcomeBackground({
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
            Colors.blue.shade900,
          ],
        ),
      ),
      child: child,
    );
  }
}
