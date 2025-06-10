import 'package:get/get.dart';
import 'package:aeroporto/models/passageiros/passageiro_login_response.dart';

class HomeController extends GetxController {
  final Rx<PassageiroLoginResponse?> passageiro =
      Rx<PassageiroLoginResponse?>(null);

  @override
  void onInit() {
    super.onInit();
    // TODO: Carregar dados do passageiro do armazenamento local
  }

  void logout() {
    // TODO: Limpar dados do passageiro do armazenamento local
    Get.offAllNamed('/welcome');
  }
}
