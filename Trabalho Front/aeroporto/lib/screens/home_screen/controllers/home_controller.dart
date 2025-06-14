import 'package:get/get.dart';
import 'package:aeroporto/models/passageiros/passageiro_login_response.dart';
import 'package:aeroporto/service/api_service_passageiro.dart';
import 'package:aeroporto/service/api_service_funcionario.dart';
import 'package:aeroporto/util/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:aeroporto/models/passageiros/voo_info.dart' as voo;

class HomeController extends GetxController {
  final _apiService = Get.find<ApiServicePassageiro>();
  final _authService = Get.find<ApiServiceFuncionario>();
  final passageiro = Rxn<PassageiroLoginResponse>();
  final vooInfo = Rxn<voo.VooInfo>();
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Só carrega os dados se não tiver dados do passageiro
    if (passageiro.value == null) {
      _loadPassageiroData();
    } else {
      isLoading.value = false;
    }
  }

  Future<void> _loadPassageiroData() async {
    try {
      isLoading.value = true;
      final data = await _apiService.getPassageiroData();
      if (data != null) {
        passageiro.value = data;
        print('Dados do passageiro carregados: ${data.toJson()}');
      }
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
