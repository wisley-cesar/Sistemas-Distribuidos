class CadastroFuncionario {
  final String nome;
  final String email;
  final String telefone;
  final String cargo;
  final String senha;

  CadastroFuncionario({
    required this.nome,
    required this.email,
    required this.telefone,
    required this.cargo,
    required this.senha,
  });

  CadastroFuncionario.fromJson(Map<String, dynamic> json)
    : nome = json['nome'],
      email = json['email'],
      telefone = json['telefone'],
      cargo = json['cargo'],
      senha = json['senha'];

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'cargo': nome,
      'senha': senha,
    };
  }

  @override
  String toString() {
    return 'CadastroFuncionario{nome: $nome, email: $email, telefone: $telefone, cargo: $cargo, senha: $senha}';
  }
}
