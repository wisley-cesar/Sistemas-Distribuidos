import 'package:get/get.dart';
import 'package:aeroporto/models/voo/voo_embarque.dart';
import 'package:aeroporto/service/api_service_voo.dart';
import 'package:aeroporto/util/app_routes.dart';

class SelectFlightController extends GetxController {
  late final ApiServiceVoo _apiService;
  final RxList<VooEmbarque> voos = <VooEmbarque>[].obs;
  final Rx<VooEmbarque?> vooSelecionado = Rx<VooEmbarque?>(null);
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _apiService = Get.put(ApiServiceVoo());
    limparSelecao();
    carregarVoos();
  }

  void limparSelecao() {
    vooSelecionado.value = null;
  }

  Future<void> carregarVoos() async {
    try {
      isLoading.value = true;
      final voosDisponiveis = await _apiService.listarVoos();
      voos.value = voosDisponiveis;
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Não foi possível carregar os voos. Tente novamente.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void selecionarVoo(VooEmbarque voo) {
    if (vooSelecionado.value?.id == voo.id) {
      vooSelecionado.value = null;
    } else {
      vooSelecionado.value = voo;
    }
  }

  void confirmarVoo() {
    if (vooSelecionado.value == null) {
      Get.snackbar(
        'Atenção',
        'Selecione um voo para continuar',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Get.toNamed(
      AppRoutes.registerPassageiro,
      arguments: vooSelecionado.value,
    );
  }
}
