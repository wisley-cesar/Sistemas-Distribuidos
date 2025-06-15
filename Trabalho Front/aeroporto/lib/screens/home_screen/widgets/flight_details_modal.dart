import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aeroporto/models/passageiros/voo_info.dart' as voo_info;

class FlightDetailsModal extends StatelessWidget {
  final voo_info.VooInfo voo;
  final VoidCallback onClose;

  const FlightDetailsModal({
    super.key,
    required this.voo,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.flight_takeoff,
                          color: Colors.blue.shade700,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Detalhes do Voo',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: onClose,
                    icon: Icon(
                      Icons.close,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildInfoRow(
                'Número do Voo',
                voo.numeroVoo.toString(),
                Icons.flight,
              ),
              const SizedBox(height: 16),
              _buildInfoRow(
                'Origem',
                voo.origem,
                Icons.location_on,
              ),
              const SizedBox(height: 16),
              _buildInfoRow(
                'Destino',
                voo.destino,
                Icons.location_on,
              ),
              const SizedBox(height: 16),
              _buildInfoRow(
                'Data e Hora de Partida',
                voo.dataHoraPartida.toString(),
                Icons.calendar_today,
              ),
              const SizedBox(height: 16),
              _buildInfoRow(
                'Portão de Embarque',
                voo.idPortao.codigo,
                Icons.door_front_door,
              ),
              const SizedBox(height: 16),
              _buildInfoRow(
                'Status do Voo',
                voo.status,
                Icons.info_outline,
                valueColor: _getStatusColor(voo.status),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onClose,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Fechar',
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
  }

  Widget _buildInfoRow(
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
