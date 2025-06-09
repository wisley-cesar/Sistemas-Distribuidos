import 'package:aeroporto/models/funcionario/cadastro_funcionario.dart';
import 'package:aeroporto/service/api_service_funcionario.dart';
import 'package:aeroporto/service/api_service_passageiro.dart';
import 'package:aeroporto/util/app_routes.dart';
import 'package:aeroporto/util/user_type.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class RegisterController extends GetxController {
  final ApiServiceFuncionario _apiServiceFuncionario = ApiServiceFuncionario();
  final ApiServicePassageiro _apiServicePassageiro = ApiServicePassageiro();

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

        await _apiServiceFuncionario.cadastrarFuncionario(funcionario);
      }

      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
