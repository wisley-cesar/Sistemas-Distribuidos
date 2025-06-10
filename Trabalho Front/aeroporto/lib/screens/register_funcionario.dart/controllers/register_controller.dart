import 'package:aeroporto/models/funcionario/cadastro_funcionario.dart';
import 'package:aeroporto/service/api_service_funcionario.dart';
import 'package:aeroporto/service/api_service_passageiro.dart';
import 'package:aeroporto/util/app_routes.dart';
import 'package:aeroporto/util/user_type.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

class RegisterController extends GetxController {
  final ApiServiceFuncionario _apiServiceFuncionario = ApiServiceFuncionario();
  final ApiServicePassageiro _apiServicePassageiro = ApiServicePassageiro();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<UserType> selectedUserType = UserType.FUNCIONARIO.obs;

  void setUserType(UserType type) {
    selectedUserType.value = type;
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _validatePassword(String password) {
    // Mínimo 8 caracteres, pelo menos uma letra maiúscula, uma minúscula e um número
    final passwordRegex =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
    return passwordRegex.hasMatch(password);
  }

  String? validateFields(
      String nome, String email, String senha, String confirmarSenha) {
    if (nome.isEmpty) {
      return 'O nome é obrigatório';
    }
    if (nome.length < 3) {
      return 'O nome deve ter pelo menos 3 caracteres';
    }
    if (email.isEmpty) {
      return 'O email é obrigatório';
    }
    if (!_validateEmail(email)) {
      return 'Email inválido';
    }
    if (senha.isEmpty) {
      return 'A senha é obrigatória';
    }
    if (!_validatePassword(senha)) {
      return 'A senha deve ter no mínimo 8 caracteres, uma letra maiúscula, uma minúscula e um número';
    }
    if (senha != confirmarSenha) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  Future<bool> register(
      String nome, String email, String senha, String confirmarSenha) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Validação dos campos
      final validationError =
          validateFields(nome, email, senha, confirmarSenha);
      if (validationError != null) {
        errorMessage.value = validationError;
        return false;
      }

      // Se for passageiro, primeiro seleciona o voo
      if (Get.arguments == true) {
        final idVoo = await Get.toNamed(AppRoutes.selectFlight);
        if (idVoo == null) {
          errorMessage.value = 'Seleção de voo cancelada';
          return false;
        }

        await _apiServicePassageiro.cadastrarPassageiro(
          nome: nome,
          cpf: email, // Usando o email como CPF temporariamente
          email: email,
          senha: senha,
          idVoo: idVoo,
        );
      } else {
        final funcionario = CadastroFuncionario(
          id: const Uuid().v4(),
          nome: nome,
          email: email,
          senha: senha,
          cargo: selectedUserType.value.name,
        );

        try {
          await _apiServiceFuncionario.cadastrarFuncionario(funcionario);

          Get.snackbar(
            'Sucesso',
            'Cadastro realizado com sucesso!',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
          );

          return true;
        } catch (e) {
          errorMessage.value = e.toString().replaceAll('Exception: ', '');
          return false;
        }
      }

      return true;
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
