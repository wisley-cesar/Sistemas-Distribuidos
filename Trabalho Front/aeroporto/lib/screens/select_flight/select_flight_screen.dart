import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aeroporto/screens/login_funcionario/widgets/login_background.dart';
import 'package:aeroporto/screens/select_flight/controller/select_flight_controller.dart';
import 'package:aeroporto/screens/select_flight/widgets/select_flight_buttons.dart';
import 'package:aeroporto/models/voo/voo_embarque.dart';

class SelectFlightScreen extends StatelessWidget {
  const SelectFlightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SelectFlightController());

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade900,
              Colors.white,
            ],
            stops: const [0.0, 0.9],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selecionar Voo',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 254, 254, 254),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Escolha o voo desejado para continuar',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 253, 253, 253),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Obx(() {
                          if (controller.isLoading.value) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (controller.voos.isEmpty) {
                            return Center(
                              child: Text(
                                'Nenhum voo disponível',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            );
                          }

                          return ListView.builder(
                            padding: const EdgeInsets.all(24),
                            itemCount: controller.voos.length,
                            itemBuilder: (context, index) {
                              final voo = controller.voos[index];
                              return Obx(() {
                                final isSelected =
                                    controller.vooSelecionado.value?.id ==
                                        voo.id;
                                return Card(
                                  elevation: isSelected ? 8 : 1,
                                  margin: const EdgeInsets.only(bottom: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                      color: isSelected
                                          ? Colors.blue.shade700
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                  color: isSelected
                                      ? Colors.blue.shade50
                                      : Colors.white,
                                  child: InkWell(
                                    onTap: () {
                                      controller.selecionarVoo(voo);
                                    },
                                    borderRadius: BorderRadius.circular(12),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  if (isSelected)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8),
                                                      child: Icon(
                                                        Icons.check_circle,
                                                        color: Colors
                                                            .blue.shade700,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  Text(
                                                    'Voo ${voo.numeroVoo}',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: isSelected
                                                          ? Colors.blue.shade900
                                                          : Colors
                                                              .blue.shade700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 6,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: isSelected
                                                      ? Colors.blue.shade100
                                                      : Colors.blue.shade50,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  'Portão ${voo.portaoEmbarqueId.codigo}',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    color: isSelected
                                                        ? Colors.blue.shade900
                                                        : Colors.blue.shade700,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    voo.origem,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    'Origem',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Icon(
                                                Icons.arrow_forward,
                                                color: Colors.grey.shade400,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    voo.destino,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    'Destino',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            'Partida: ${voo.dataHoraPartida}',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                            },
                          );
                        }),
                      ),
                      SelectFlightButtons(
                        onBack: () => Get.back(),
                        onConfirm: () => controller.confirmarVoo(), 
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
