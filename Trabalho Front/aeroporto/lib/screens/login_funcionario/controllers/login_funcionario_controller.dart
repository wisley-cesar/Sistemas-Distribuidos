import 'package:aeroporto/service/api_service_funcionario.dart';
import 'package:aeroporto/util/app_routes.dart';
import 'package:get/get.dart';

class LoginFuncionarioController extends GetxController {
  late final ApiServiceFuncionario _apiService;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _apiService = Get.put(ApiServiceFuncionario());
  }

  Future<bool> login(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await _apiService.fazerLogin(password, email);

      if (_apiService.getToken() != null) {
        Get.offAllNamed(AppRoutes.home);
        return true;
      } else {
        errorMessage.value =
            'Falha ao fazer login. Verifique suas credenciais.';
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Erro ao fazer login: $e';
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
