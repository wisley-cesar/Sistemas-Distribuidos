import 'package:aeroporto/models/voo/voo_embarque.dart';

class PassageiroCadastro {
  String nome;
  String cpf;
  VooEmbarque vooEmbarqueId;

  PassageiroCadastro({
    required this.nome,
    required this.cpf,
    required this.vooEmbarqueId,
  });
  PassageiroCadastro.fromJson(Map<String, dynamic> json)
    : nome = json['nome'],
      cpf = json['cpf'],
      vooEmbarqueId = VooEmbarque.fromJson(json['id']);

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'cpf': cpf,
      'vooEmbarqueId': vooEmbarqueId.toJson(),
    };
  }

  @override
  String toString() {
    return 'PassageiroCadastro{nome: $nome, cpf: $cpf, vooEmbarqueId: $vooEmbarqueId}';
  }
}
