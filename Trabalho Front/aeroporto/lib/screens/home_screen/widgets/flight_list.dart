import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aeroporto/screens/home_screen/controllers/home_controller.dart';
import 'package:aeroporto/service/api_service_passageiro.dart';
import 'package:aeroporto/models/passageiros/voo_info.dart' as voo;
import 'package:aeroporto/screens/home_screen/widgets/flight_details_modal.dart';

class FlightListController extends GetxController {
  final ApiServicePassageiro _apiService = Get.find<ApiServicePassageiro>();
  final RxBool isLoading = false.obs;
  final Rx<voo.VooInfo?> vooDetalhes = Rx<voo.VooInfo?>(null);

  Future<void> buscarDetalhesVoo(String idVoo) async {
    try {
      isLoading.value = true;
      final vooInfo = await _apiService.getVooDetails(idVoo);
      if (vooInfo != null) {
        vooDetalhes.value = vooInfo;
        Get.dialog(
          FlightDetailsModal(
            voo: vooInfo,
            onClose: () {
              Get.back();
              vooDetalhes.value = null;
            },
          ),
        );
      }
    } catch (e) {
      print('Erro ao buscar detalhes do voo: $e');
      Get.snackbar(
        'Erro',
        'Não foi possível carregar os detalhes do voo',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

class FlightList extends StatelessWidget {
  final HomeController _controller = Get.find<HomeController>();

  FlightList({super.key});

  @override
  Widget build(BuildContext context) {
    final listController = Get.put(FlightListController());

    return Obx(() {
      if (_controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final vooInfo = _controller.vooInfo.value;
      if (vooInfo == null) {
        return const Center(
          child: Text('Nenhum voo disponível'),
        );
      }

      return Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade50,
                Colors.white,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.flight,
                        size: 28,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Informações do Voo',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildFlightInfo(
                  context,
                  'Número do Voo',
                  vooInfo.numeroVoo.toString(),
                  Icons.flight,
                ),
                const SizedBox(height: 16),
                _buildFlightInfo(
                  context,
                  'Origem',
                  vooInfo.origem,
                  Icons.location_on,
                ),
                const SizedBox(height: 16),
                _buildFlightInfo(
                  context,
                  'Destino',
                  vooInfo.destino,
                  Icons.location_on,
                ),
                const SizedBox(height: 16),
                _buildFlightInfo(
                  context,
                  'Data e Hora de Partida',
                  vooInfo.dataHoraPartida.toString(),
                  Icons.calendar_today,
                ),
                const SizedBox(height: 16),
                _buildFlightInfo(
                  context,
                  'Portão de Embarque',
                  vooInfo.idPortao.codigo,
                  Icons.door_front_door,
                ),
                const SizedBox(height: 16),
                _buildFlightInfo(
                  context,
                  'Status do Voo',
                  vooInfo.status,
                  Icons.info_outline,
                  valueColor: _getStatusColor(vooInfo.status),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      listController.buscarDetalhesVoo(vooInfo.id.toString());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Ver Detalhes',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildFlightInfo(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    Color? valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: valueColor ?? Colors.blue.shade900,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toUpperCase()) {
      case 'CONFIRMADO':
        return Colors.green.shade700;
      case 'ATRASADO':
        return Colors.orange.shade700;
      case 'CANCELADO':
        return Colors.red.shade700;
      default:
        return Colors.blue.shade900;
    }
  }
}
