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
  final isReady = false.obs;

  @override
  void onInit() {
    super.onInit();
    print('HomeController inicializado');

    // Verifica se temos o token
    final token = _authService.getToken();
    if (token == null) {
      print('Token não encontrado, redirecionando para login');
      Get.offAllNamed(AppRoutes.welcome);
      return;
    }

    // Se já temos dados do passageiro, verificamos se estão completos
    if (passageiro.value != null) {
      print('Verificando dados existentes do passageiro');
      _validatePassageiroData();
    } else {
      print('Dados do passageiro não encontrados, redirecionando para login');
      Get.offAllNamed(AppRoutes.welcome);
    }
  }

  void _validatePassageiroData() {
    final data = passageiro.value;
    if (data == null ||
        data.nome.isEmpty ||
        data.cpf.isEmpty ||
        data.idVoo.isEmpty) {
      print('Dados do passageiro incompletos, redirecionando para login');
      Get.offAllNamed(AppRoutes.welcome);
      return;
    }

    print('Dados do passageiro validados com sucesso');
    isLoading.value = false;
    isReady.value = true;
  }

  Future<void> refreshData() async {
    try {
      print('Iniciando atualização dos dados do passageiro');
      isLoading.value = true;

      // Busca os dados atualizados do passageiro
      final data = await _apiService.getPassageiroData();
      print('Dados atualizados recebidos: ${data.toJson()}');

      if (data != null) {
        passageiro.value = data;
        _validatePassageiroData();
      } else {
        print('Dados não recebidos da API, redirecionando para login');
        Get.offAllNamed(AppRoutes.welcome);
      }
    } catch (e) {
      print('Erro ao atualizar dados do passageiro: $e');
      Get.snackbar(
        'Erro',
        'Não foi possível atualizar os dados. Tente novamente.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    print('Realizando logout');
    // Limpa o token de autenticação
    _authService.clearToken();
    // Limpa os dados do passageiro
    passageiro.value = null;
    isReady.value = false;
    // Redireciona para a tela de welcome
    Get.offAllNamed(AppRoutes.welcome);
  }
}
