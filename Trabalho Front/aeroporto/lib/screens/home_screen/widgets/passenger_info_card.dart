import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aeroporto/screens/home_screen/controllers/home_controller.dart';
import 'package:aeroporto/widgets/my_card.dart';
import 'package:aeroporto/widgets/my_info_row.dart';
import 'package:aeroporto/screens/home_screen/widgets/loading_text.dart';

class PassengerInfoCard extends StatelessWidget {
  final HomeController controller;

  const PassengerInfoCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final passageiro = controller.passageiro.value;
      final isLoading = controller.isLoading.value;

      return MyCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.person,
                    color: Colors.blue.shade700,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Informações do Passageiro',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (isLoading) ...[
              LoadingText(
                text: 'Carregando nome...',
                fontSize: 16,
                color: Colors.blue.shade700,
              ),
              const SizedBox(height: 16),
              LoadingText(
                text: 'Carregando CPF...',
                fontSize: 16,
                color: Colors.blue.shade700,
              ),
              const SizedBox(height: 16),
              LoadingText(
                text: 'Carregando status...',
                fontSize: 16,
                color: Colors.blue.shade700,
              ),
            ] else ...[
              MyInfoRow(
                label: 'Nome',
                value: passageiro?.nome ?? 'Não disponível',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),
              MyInfoRow(
                label: 'CPF',
                value: passageiro?.cpf ?? 'Não disponível',
                icon: Icons.badge_outlined,
              ),
              const SizedBox(height: 16),
              MyInfoRow(
                label: 'Status do Check-in',
                value: passageiro?.statusCheckIn ?? 'Não disponível',
                icon: Icons.check_circle_outline,
              ),
            ],
          ],
        ),
      );
    });
  }
}
