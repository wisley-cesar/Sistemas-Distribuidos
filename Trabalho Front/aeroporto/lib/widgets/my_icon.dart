import 'package:flutter/material.dart';

class MyIcon extends StatelessWidget {
  final double size;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const MyIcon({
    super.key,
    this.size = 80,
    this.color,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        Icons.flight_takeoff,
        size: size,
        color: color ?? Colors.blue.shade700,
      ),
    );

    if (onTap != null) {
      iconWidget = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: iconWidget,
      );
    }

    return iconWidget;
  }
}
