import 'package:aeroporto/screens/login_funcionario/login_funcionario_screen.dart';
import 'package:aeroporto/screens/login_passageiro/login_passageiro_screen.dart';
import 'package:aeroporto/screens/register_funcionario.dart/register_screen.dart';
import 'package:aeroporto/screens/register_passageiro/register_passageiro_screen.dart';
import 'package:aeroporto/screens/select_flight/select_flight_screen.dart';
import 'package:aeroporto/screens/welcome/welcome_screen.dart';
import 'package:aeroporto/service/api_service_funcionario.dart';
import 'package:aeroporto/util/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/home_screen/home_screen.dart';

class AeroportoApp extends StatelessWidget {
  const AeroportoApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Inicializa o ApiServiceFuncionario
    Get.put(ApiServiceFuncionario());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aeroporto App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AppRoutes.welcome,
      getPages: [
        GetPage(name: AppRoutes.home, page: () => const HomeScreen()),
        GetPage(name: AppRoutes.welcome, page: () => const WelcomeScreen()),
        GetPage(name: AppRoutes.login, page: () => LoginFuncionarioScreen()),
        GetPage(
            name: AppRoutes.loginPassageiro,
            page: () => LoginPassageiroScreen()),
        GetPage(
            name: AppRoutes.loginFuncionario,
            page: () => LoginFuncionarioScreen()),
        GetPage(
            name: AppRoutes.registerPassageiro,
            page: () => RegisterPassageiroScreen()),
        GetPage(
            name: AppRoutes.registerFuncionario, page: () => RegisterScreen()),
        GetPage(name: AppRoutes.selectFlight, page: () => SelectFlightScreen()),
      ],
    );
  }
}
