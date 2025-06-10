class PassageiroLoginResponse {
  final String token;
  final String nome;
  final String cpf;
  final String idVoo;
  final String statusCheckIn;

  PassageiroLoginResponse({
    required this.token,
    required this.nome,
    required this.cpf,
    required this.idVoo,
    required this.statusCheckIn,
  });

  factory PassageiroLoginResponse.fromJson(Map<String, dynamic> json) {
    return PassageiroLoginResponse(
      token: json['token'] ?? '',
      nome: json['nome'] ?? '',
      cpf: json['cpf'] ?? '',
      idVoo: json['idVoo'] ?? '',
      statusCheckIn: json['statusCheckIn'] ?? 'PENDENTE',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'nome': nome,
      'cpf': cpf,
      'idVoo': idVoo,
      'statusCheckIn': statusCheckIn,
    };
  }
}
