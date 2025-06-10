import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Widget child;
  final double elevation;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Color? startColor;
  final Color? endColor;

  const MyCard({
    super.key,
    required this.child,
    this.elevation = 8,
    this.borderRadius = 20,
    this.padding = const EdgeInsets.all(16.0),
    this.startColor,
    this.endColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              startColor ?? Colors.blue.shade50,
              endColor ?? Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
