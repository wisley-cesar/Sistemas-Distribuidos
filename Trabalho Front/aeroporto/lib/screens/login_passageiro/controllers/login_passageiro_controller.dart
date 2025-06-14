import 'package:aeroporto/service/api_service_passageiro.dart';
import 'package:aeroporto/util/app_routes.dart';
import 'package:get/get.dart';
import 'package:aeroporto/screens/home_screen/controllers/home_controller.dart';

class LoginPassageiroController extends GetxController {
  late final ApiServicePassageiro _apiService;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _apiService = Get.put(ApiServicePassageiro());
    print('LoginPassageiroController initialized');
  }

  Future<bool> login(String email, String password) async {
    print('Attempting login with email: $email');
    try {
      isLoading.value = true;
      errorMessage.value = '';

      print('Calling API service login method');
      final response = await _apiService.login(
        email: email,
        senha: password,
      );
      print('Login response received: ${response.toJson()}');

      if (response.token.isNotEmpty) {
        print('Login successful, navigating to home');
        // Armazena os dados do passageiro no controller da home
        final homeController = Get.put(HomeController());
        homeController.passageiro.value = response;
        homeController.isLoading.value =
            false; // Garante que o loading seja desativado

        Get.offAllNamed(AppRoutes.home);
        return true;
      } else {
        print('Login failed: Empty token received');
        errorMessage.value =
            'Credenciais inválidas. Por favor, verifique seu email e senha.';
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      if (e is Exception) {
        errorMessage.value = e.toString().replaceAll('Exception: ', '');
      } else {
        errorMessage.value = 'Ocorreu um erro inesperado. Tente novamente.';
      }
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
