import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aeroporto/models/passageiros/passageiro_login_response.dart';
import 'package:aeroporto/screens/home_screen/controllers/home_controller.dart';
import 'package:aeroporto/widgets/my_card.dart';
import 'package:aeroporto/widgets/my_action_button.dart';
import 'package:aeroporto/widgets/my_info_row.dart';
import 'package:aeroporto/screens/home_screen/widgets/home_app_bar.dart';
import 'package:aeroporto/screens/home_screen/widgets/welcome_section.dart';
import 'package:aeroporto/screens/home_screen/widgets/passenger_info_card.dart';
import 'package:aeroporto/screens/home_screen/widgets/quick_actions_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      body: Container(
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
          child: Column(
            children: [
              HomeAppBar(controller: controller),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const WelcomeSection(),
                      const SizedBox(height: 32),
                      PassengerInfoCard(controller: controller),
                      const SizedBox(height: 24),
                      const QuickActionsCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
