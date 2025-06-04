import 'package:aeroporto/screens/login_funcionario/login_funcionario_screen.dart';
import 'package:aeroporto/screens/login_passageiro/login_passageiro_screen.dart';
import 'package:aeroporto/screens/register_funcionario.dart/register_screen.dart';
import 'package:aeroporto/screens/register_passageiro/register_passageiro_screen.dart';
import 'package:aeroporto/screens/welcome/welcome_screen.dart';
import 'package:aeroporto/service/api_service_funcionario.dart';
import 'package:aeroporto/util/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/home_screen.dart';

class AeroportoApp extends StatelessWidget {
  const AeroportoApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Inicializa o ApiServiceFuncionario
    Get.put(ApiServiceFuncionario());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aeroporto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.welcome_screen,
      getPages: [
        GetPage(
            name: AppRoutes.welcome_screen, page: () => const WelcomeScreen()),
        GetPage(name: AppRoutes.login, page: () => LoginFuncionarioScreen()),
        GetPage(name: AppRoutes.home, page: () => const HomeScreen()),
        GetPage(name: AppRoutes.register, page: () => RegisterScreen()),
        GetPage(
            name: AppRoutes.login_passageiro,
            page: () => LoginPassageiroScreen()),
        GetPage(
            name: AppRoutes.register_passageiro,
            page: () => RegisterPassageiroScreen()),
      ],
    );
  }
}
