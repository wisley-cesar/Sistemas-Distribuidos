import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? color;
  final int? maxLines;

  const MyInfoRow({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.color,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor = Colors.blue.shade700;
    final textColor = color ?? defaultColor;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: textColor,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: maxLines ?? 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
