class VooEmbarque {
  final String id;
  final String numeroVoo;
  final String origem;
  final String destino;
  final String dataHoraPartida;
  final PortaoEmbarque portaoEmbarqueId;

  VooEmbarque({
    required this.id,
    required this.numeroVoo,
    required this.origem,
    required this.destino,
    required this.dataHoraPartida,
    required this.portaoEmbarqueId,
  });

  factory VooEmbarque.fromJson(Map<String, dynamic> json) {
    return VooEmbarque(
      id: json['id'],
      numeroVoo: json['numeroVoo'],
      origem: json['origem'],
      destino: json['destino'],
      dataHoraPartida: json['dataHoraPartida'],
      portaoEmbarqueId: PortaoEmbarque.fromJson(json['portaoEmbarqueId']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numeroVoo': numeroVoo,
      'origem': origem,
      'destino': destino,
      'dataHoraPartida': dataHoraPartida,
      'portaoEmbarqueId': portaoEmbarqueId.toJson(),
    };
  }
}

class PortaoEmbarque {
  final String id;
  final String codigo;

  PortaoEmbarque({
    required this.id,
    required this.codigo,
  });

  factory PortaoEmbarque.fromJson(Map<String, dynamic> json) {
    return PortaoEmbarque(
      id: json['id'],
      codigo: json['codigo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'codigo': codigo,
    };
  }
}
