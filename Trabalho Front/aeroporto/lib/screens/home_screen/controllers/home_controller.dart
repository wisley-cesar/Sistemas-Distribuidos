import 'package:get/get.dart';
import 'package:aeroporto/models/passageiros/passageiro_login_response.dart';
import 'package:aeroporto/service/api_service_passageiro.dart';
import 'package:aeroporto/service/api_service_funcionario.dart';
import 'package:aeroporto/util/app_routes.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  final _apiService = Get.find<ApiServicePassageiro>();
  final _authService = Get.find<ApiServiceFuncionario>();
  final passageiro = Rxn<PassageiroLoginResponse>();
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadPassageiroData();
  }

  Future<void> _loadPassageiroData() async {
    try {
      isLoading.value = true;
      passageiro.value = await _apiService.getPassageiroData();
    } catch (e) {
      print('Erro ao carregar dados do passageiro: $e');
      Get.snackbar(
        'Erro',
        'Não foi possível carregar os dados do passageiro. Tente novamente.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    // Limpa o token de autenticação
    _authService.clearToken();
    // Limpa os dados do passageiro
    passageiro.value = null;
    // Redireciona para a tela de welcome
    Get.offAllNamed(AppRoutes.welcome);
  }
}
