class Funcionario {
  final String id;
  final String nome;
  final String email;
  final String cargo;

  Funcionario({
    required this.id,
    required this.nome,
    required this.email,
    required this.cargo,
  });

  @override
  String toString() {
    return 'Funcionario{id: $id, nome: $nome, email: $email,cargo: $cargo}';
  }

  factory Funcionario.fromJson(Map<String, dynamic> json) {
    return Funcionario(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      cargo: json['cargo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'cargo': cargo,
    };
  }
}
