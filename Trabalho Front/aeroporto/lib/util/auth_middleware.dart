import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aeroporto/service/api_service_funcionario.dart';
import 'package:aeroporto/util/app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final apiService = Get.find<ApiServiceFuncionario>();
    final token = apiService.getToken();

    // Se não houver token, redireciona para a tela de login
    if (token == null) {
      return const RouteSettings(name: AppRoutes.loginPassageiro);
    }

    return null;
  }
}
