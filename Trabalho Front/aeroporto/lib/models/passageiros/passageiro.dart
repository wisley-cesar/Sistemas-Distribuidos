import 'package:aeroporto/models/passageiros/status_checkin.dart';
import 'package:aeroporto/models/voo/voo_embarque.dart';

class Passageiro {
  final String id;
  final String nome;
  final String cpf;
  final bool ativo;
  final StatusCheckin statusCheckin;
  final VooEmbarque vooEmbarque;

  Passageiro({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.ativo,
    required this.statusCheckin,
    required this.vooEmbarque,
  });

  Passageiro.somenteId(String id)
    : id = id,
      nome = '',
      cpf = '',
      ativo = false,
      vooEmbarque = VooEmbarque.somenteId(''),
      statusCheckin = StatusCheckin.PENDENTE;

  Passageiro.cadastro({
    required String nome,
    required String cpf,
    required VooEmbarque vooEmbarqueId,
  }) : id = '',
       nome = nome,
       cpf = cpf,
       vooEmbarque = VooEmbarque.somenteId(vooEmbarqueId.id),
       ativo = true,
       statusCheckin = StatusCheckin.PENDENTE;

  Passageiro.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      nome = json['nome'],
      cpf = json['cpf'],
      ativo = json['ativo'],
      statusCheckin = StatusCheckin.values.firstWhere(
        (e) => e.name == json['statusCheckin'],
        orElse: () => StatusCheckin.PENDENTE,
      ),
      vooEmbarque = VooEmbarque.fromJson(json['idVoo']);

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'cpf': cpf,
      'statusCheckin': statusCheckin.name,
      'ativo': ativo,
      'vooEmbarque': {'id': vooEmbarque.id},
    };
  }

  @override
  String toString() {
    return 'Passageiro{id: $id, nome: $nome, cpf: $cpf, ativo: $ativo, statusCheckin: $statusCheckin}';
  }
}
