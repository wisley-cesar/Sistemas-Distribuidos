import 'package:aeroporto/models/portao/portao_embarque.dart';
import 'package:aeroporto/models/voo/status_voo.dart';

class VooEmbarque {
  final String id;
  final int numeroVoo;
  final String origem;
  final String destino;
  final String dataHoraPartida;
  final PortaoEmbarque portaoEmbarqueId;
  final StatusVoo statusVoo;
  final bool ativo;

  VooEmbarque({
    required this.id,
    required this.numeroVoo,
    required this.origem,
    required this.destino,
    required this.dataHoraPartida,
    required this.portaoEmbarqueId,
    required this.statusVoo,
    required this.ativo,
  });

  VooEmbarque.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        numeroVoo = json['numeroVoo'],
        origem = json['origem'],
        destino = json['destino'],
        dataHoraPartida = json['dataHoraPartida'],
        portaoEmbarqueId = PortaoEmbarque.fromJson(json['portaoEmbarqueId']),
        statusVoo = StatusVoo.values.firstWhere(
          (status) => status.name == (json['statusVoo'] ?? 'PROGRAMADO'),
          orElse: () => StatusVoo.PROGRAMADO,
        ),
        ativo = json['ativo'] ?? true;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numeroVoo': numeroVoo,
      'origem': origem,
      'destino': destino,
      'dataHoraPartida': dataHoraPartida,
      'portaoEmbarqueId': portaoEmbarqueId.id,
      'statusVoo': statusVoo.name,
      'ativo': ativo,
    };
  }

  static VooEmbarque somenteId(String id) {
    return VooEmbarque(
      id: id,
      numeroVoo: 0,
      origem: '',
      destino: '',
      dataHoraPartida: '',
      portaoEmbarqueId: PortaoEmbarque.somenteId(''),
      statusVoo: StatusVoo.PROGRAMADO,
      ativo: true,
    );
  }
}
