import 'package:aeroporto/models/funcionario/cadastro_funcionario.dart';
import 'package:aeroporto/service/api_service_funcionario.dart';
import 'package:aeroporto/util/app_routes.dart';
import 'package:aeroporto/util/user_type.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class RegisterController extends GetxController {
  final ApiServiceFuncionario _apiService = Get.find<ApiServiceFuncionario>();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<UserType> selectedUserType = UserType.FUNCIONARIO.obs;

  void setUserType(UserType type) {
    selectedUserType.value = type;
  }

  Future<bool> register(String nome, String email, String senha) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Verifica se o tipo selecionado é válido
      if (selectedUserType.value == UserType.PASSAGEIRO) {
        errorMessage.value =
            'Cadastro de passageiros não é permitido nesta tela';
        return false;
      }

      final funcionario = CadastroFuncionario(
        id: const Uuid().v4(),
        nome: nome,
        email: email,
        senha: senha,
        cargo: selectedUserType
            .value.name, // Usa o nome do enum (ADMIN ou FUNCIONARIO)
      );

      await _apiService.cadastrarFuncionario(funcionario);

      // Se chegou aqui, o cadastro foi bem sucedido
      Get.offAllNamed(AppRoutes.login);
      return true;
    } catch (e) {
      errorMessage.value = 'Erro ao cadastrar: $e';
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
