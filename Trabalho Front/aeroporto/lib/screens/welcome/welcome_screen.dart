import 'package:aeroporto/screens/login_funcionario/widgets/button_login.dart';
import 'package:aeroporto/screens/welcome/widgets/copyright_text.dart';
import 'package:aeroporto/screens/welcome/widgets/user_type_dialog.dart';
import 'package:aeroporto/screens/welcome/widgets/welcome_background.dart';
import 'package:aeroporto/util/app_routes.dart';
import 'package:aeroporto/widgets/my_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _showUserTypeDialog(BuildContext context, bool isLogin) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return UserTypeDialog(
          isLogin: isLogin,
          onSelect: (String userType) {
            if (isLogin) {
              if (userType == 'Funcionário') {
                Get.toNamed(AppRoutes.login);
              } else {
                Get.toNamed(AppRoutes.login_passageiro);
              }
            } else {
              if (userType == 'Funcionário') {
                Get.toNamed(AppRoutes.register);
              } else {
                Get.toNamed(AppRoutes.register_passageiro);
              }
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WelcomeBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const MyIcon(
                  size: 120,
                  color: Colors.white,
                  backgroundColor: Color(0xFF1565C0),
                ),
                const SizedBox(height: 32),
                Text(
                  'Bem-vindo ao\nSistema do Aeroporto',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Gerencie voos, passageiros e funcionários de forma eficiente',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.8),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 48),
                ButtonLogin(
                  title: 'Entrar',
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue.shade700,
                  shadowColor: Colors.white,
                  onPressed: () => _showUserTypeDialog(context, true),
                ),
                const SizedBox(height: 16),
                ButtonLogin(
                  title: 'Cadastrar',
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.white,
                  isOutlined: true,
                  onPressed: () => _showUserTypeDialog(context, false),
                ),
                const SizedBox(height: 32),
                const CopyrightText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
