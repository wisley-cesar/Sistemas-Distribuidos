import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CopyrightText extends StatelessWidget {
  const CopyrightText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '© 2024 Sistema do Aeroporto',
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.white.withOpacity(0.6),
      ),
    );
  }
}
