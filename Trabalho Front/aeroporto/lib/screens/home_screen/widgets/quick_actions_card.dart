import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aeroporto/widgets/my_card.dart';
import 'package:aeroporto/widgets/my_action_button.dart';

class QuickActionsCard extends StatelessWidget {
  const QuickActionsCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                  Icons.flight_takeoff,
                  color: Colors.blue.shade700,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Ações Rápidas',
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
          MyActionButton(
            label: 'Realizar Check-in',
            icon: Icons.check_circle_outline,
            onPressed: () {
              // TODO: Implementar check-in
            },
          ),
          const SizedBox(height: 12),
          MyActionButton(
            label: 'Ver Detalhes do Voo',
            icon: Icons.flight_outlined,
            onPressed: () {
              // TODO: Implementar visualização do voo
            },
          ),
        ],
      ),
    );
  }
}
