class PortaoEmbarque {
  final String id;
  final String codigo;
  final bool disponivel;
  final bool ativo;

  PortaoEmbarque({
    required this.id,
    required this.codigo,
    required this.disponivel,
    required this.ativo,
  });
  PortaoEmbarque.somenteId(String id)
    : id = id,
      codigo = '',
      disponivel = false,
      ativo = false;

  PortaoEmbarque.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      codigo = json['codigo'],
      disponivel = json['disponivel'],
      ativo = json['ativo'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'codigo': codigo,
      'disponivel': disponivel,
      'ativo': ativo,
    };
  }

  @override
  String toString() {
    return 'PortaoEmbarque{id: $id, codigo: $codigo, disponivel: $disponivel, ativo: $ativo}';
  }
}
