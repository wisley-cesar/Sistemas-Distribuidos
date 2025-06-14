class VooInfo {
  final String id;
  final int numeroVoo;
  final String origem;
  final String destino;
  final DateTime dataHoraPartida;
  final PortaoInfo idPortao;
  final String status;
  final bool ativo;

  VooInfo({
    required this.id,
    required this.numeroVoo,
    required this.origem,
    required this.destino,
    required this.dataHoraPartida,
    required this.idPortao,
    required this.status,
    required this.ativo,
  });

  factory VooInfo.fromJson(Map<String, dynamic> json) {
    return VooInfo(
      id: json['id'] as String? ?? '',
      numeroVoo: json['numeroVoo'] as int? ?? 0,
      origem: json['origem'] as String? ?? '',
      destino: json['destino'] as String? ?? '',
      dataHoraPartida: DateTime.parse(json['dataHoraPartida'] as String? ??
          DateTime.now().toIso8601String()),
      idPortao: PortaoInfo.fromJson(json['idPortao'] as Map<String, dynamic>),
      status: json['status'] as String? ?? '',
      ativo: json['ativo'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numeroVoo': numeroVoo,
      'origem': origem,
      'destino': destino,
      'dataHoraPartida': dataHoraPartida.toIso8601String(),
      'idPortao': idPortao.toJson(),
      'status': status,
      'ativo': ativo,
    };
  }
}

class PortaoInfo {
  final String id;
  final String codigo;
  final bool disponivel;
  final bool ativo;

  PortaoInfo({
    required this.id,
    required this.codigo,
    required this.disponivel,
    required this.ativo,
  });

  factory PortaoInfo.fromJson(Map<String, dynamic> json) {
    return PortaoInfo(
      id: json['id'] as String? ?? '',
      codigo: json['codigo'] as String? ?? '',
      disponivel: json['disponivel'] as bool? ?? false,
      ativo: json['ativo'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'codigo': codigo,
      'disponivel': disponivel,
      'ativo': ativo,
    };
  }
}
