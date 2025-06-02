import 'package:aeroporto/models/portao/portao_embarque.dart';
import 'package:aeroporto/models/voo/status_voo.dart';

class VooCadastro {
  final int numeroVoo;
  final String origem;
  final String destino;
  final String dataHoraPartida;
  final PortaoEmbarque portaoEmbarqueId;
  final StatusVoo statusVoo;

  VooCadastro({
    required this.numeroVoo,
    required this.origem,
    required this.destino,
    required this.dataHoraPartida,
    required this.portaoEmbarqueId,
    required this.statusVoo,
  });

  VooCadastro.fromJson(Map<String, dynamic> json)
    : numeroVoo = json['numeroVoo'],
      origem = json['origem'],
      destino = json['destino'],
      dataHoraPartida = json['dataHoraPartida'],
      portaoEmbarqueId = PortaoEmbarque.fromJson(json['portaoEmbarqueId']),
      statusVoo = StatusVoo.fromJson(json['statusVoo']);

  Map<String, dynamic> toJson() {
    return {
      'numeroVoo': numeroVoo,
      'origem': origem,
      'destino': destino,
      'dataHoraPartida': dataHoraPartida,
      'portaoEmbarqueId': portaoEmbarqueId.toJson(),
      'statusVoo': statusVoo.name
    };
  }
}
