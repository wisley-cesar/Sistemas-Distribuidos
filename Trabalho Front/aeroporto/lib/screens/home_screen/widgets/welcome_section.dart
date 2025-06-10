import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bem-vindo ao\nSistema do Aeroporto',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 255, 255),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Gerencie suas informações de voo de forma simples',
          style: GoogleFonts.poppins(
            fontSize: 17,
            color: const Color.fromARGB(255, 245, 245, 245),
          ),
        ),
      ],
    );
  }
}
