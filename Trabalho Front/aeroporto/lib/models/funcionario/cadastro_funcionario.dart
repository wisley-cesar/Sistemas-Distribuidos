class CadastroFuncionario {
  final String id;
  final String nome;
  final String email;
  final String cargo;
  final String senha;

  CadastroFuncionario({
    required this.id,
    required this.nome,
    required this.email,
    required this.cargo,
    required this.senha,
  });

  CadastroFuncionario.fromJson(Map<String, dynamic> json)
    : nome = json['nome'],
      id = json['id'],
      email = json['email'],
      cargo = json['cargo'],
      senha = json['senha'];

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'email': email,
      'cargo': cargo,
      'senha': senha,
    };
  }

  @override
  String toString() {
    return 'CadastroFuncionario{nome: $nome, email: $email,cargo: $cargo, senha: $senha}';
  }
}
