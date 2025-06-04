class CadastroFuncionario {
  final String id;
  final String nome;
  final String email;
  final String senha;
  final String cargo;

  CadastroFuncionario({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.cargo,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
      'cargo': cargo,
    };
  }

  factory CadastroFuncionario.fromJson(Map<String, dynamic> json) {
    return CadastroFuncionario(
      id: json['id'] as String,
      nome: json['nome'] as String,
      email: json['email'] as String,
      senha: json['senha'] as String,
      cargo: json['cargo'] as String,
    );
  }

  @override
  String toString() {
    return 'CadastroFuncionario{nome: $nome, email: $email,cargo: $cargo, senha: $senha}';
  }
}
