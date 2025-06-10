import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final Color? backgroundColor;
  final double? width;
  final double height;
  final bool showArrow;

  const MyActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.color,
    this.backgroundColor,
    this.width,
    this.height = 50,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor = Colors.blue.shade700;
    final buttonColor = color ?? defaultColor;
    final buttonBackgroundColor = backgroundColor ?? Colors.white;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: buttonBackgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: buttonColor.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: buttonColor,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: buttonColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (showArrow)
                Icon(
                  Icons.arrow_forward_ios,
                  color: buttonColor,
                  size: 16,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
