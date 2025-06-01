class PortaoEmbarqueCadastro {
  final String codigo;
  final bool disponivel;

  PortaoEmbarqueCadastro({
    required this.codigo,
    required this.disponivel,
  });
  PortaoEmbarqueCadastro.fromJson(Map<String, dynamic> json)
    : codigo = json['codigo'],
      disponivel = json['disponivel'];

  Map<String, dynamic> toJson() {
    return {
      'codigo': codigo,
      'disponivel': disponivel,
    };
  }
}
