import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aeroporto/screens/home_screen/controllers/home_controller.dart';
import 'package:aeroporto/screens/home_screen/widgets/home_app_bar.dart';
import 'package:aeroporto/screens/home_screen/widgets/welcome_section.dart';
import 'package:aeroporto/screens/home_screen/widgets/passenger_info_card.dart';
import 'package:aeroporto/screens/home_screen/widgets/quick_actions_card.dart';
import 'package:aeroporto/screens/home_screen/widgets/home_background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      body: HomeBackground(
        child: Column(
          children: [
            HomeAppBar(controller: controller),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  // Recarrega os dados do passageiro
                  await controller.refreshData();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
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
            ),
          ],
        ),
      ),
    );
  }
}
