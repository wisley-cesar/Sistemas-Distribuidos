import 'package:aeroporto/aeroporto_app.dart';
import 'package:aeroporto/models/funcionario/cadastro_funcionario.dart';
import 'package:aeroporto/models/portao/portao_embarque.dart';
import 'package:aeroporto/models/voo/status_voo.dart';
import 'package:aeroporto/models/voo/voo_cadastro.dart';
import 'package:aeroporto/models/voo/voo_embarque.dart';
import 'package:aeroporto/service/api_service_funcionario.dart';
import 'package:aeroporto/service/api_service_portao_embarque.dart';
import 'package:aeroporto/service/api_service_voo.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

void main() async {
  Get.put(ApiServiceFuncionario());

  runApp(
    const AeroportoApp(),
  );

  final api = Get.put(ApiServiceFuncionario());
  final funcionario = CadastroFuncionario(
    nome: 'Wisley César',
    email: 'wisleycesar32@gmail.com',
    cargo: 'admin',
    senha: '1223123',
    id: '6839a88de29a8973c2386c56',
  );

  // final api = ApiServiceFuncionario();
  // await api.cadastrarFuncionario(funcionario);
  final api_portao = ApiServicePortaoEmbarque();

  await api.fazerLogin(funcionario.senha, funcionario.email);

  final ApiServiceVoo apiVoo = ApiServiceVoo();
  // await apiVoo.cadastrarVoo(
  //   VooCadastro(
  //     numeroVoo: 778,
  //     origem: "Rio de Janeiro",
  //     destino: "São Paulo",
  //     dataHoraPartida: "2023-10-01T10:00:00Z",
  //     portaoEmbarqueId: PortaoEmbarque.somenteId(
  //       '6834697014b43f04c5b05f5b',
  //     ),
  //     statusVoo: StatusVoo.PROGRAMADO,
  //   ),
  // );
  await apiVoo.listarVoos();
  await apiVoo.excluirVoo('683dea9a42eb311012add846');
  // await apiVoo.atualizarVoo(
  //   VooEmbarque(
  //     id: '683ca5d8b9c6cf3383f1044e',
  //     numeroVoo: 777,
  //     origem: "Morrinhos",
  //     destino: "Mato Grosso",
  //     dataHoraPartida: "2023-10-01T10:00:00Z",
  //     portaoEmbarqueId: PortaoEmbarque.somenteId(
  //       '6834697014b43f04c5b05f5b',
  //     ),
  //     statusVoo: StatusVoo.PROGRAMADO,
  //     ativo: true,
  //   ),
  // );

  // apiVoo.cadastrarVoo(
  //   VooCadastro(
  //     numeroVoo: 778,
  //     origem: "Rio de Janeiro",
  //     destino: "São Paulo",
  //     dataHoraPartida: "2023-10-01T10:00:00Z",
  //     portaoEmbarqueId: PortaoEmbarque.somenteId(
  //       '6834697014b43f04c5b05f5b',
  //     ),
  //     statusVoo: StatusVoo.PROGRAMADO,
  //   ),
  // );

  // await api_portao.listarPortoesEmbarque();

  // await api_portao.atualizarPortaoEmbarque(
  //   PortaoEmbarque(
  //     id: '6834509a14b43f04c5b05f56',
  //     codigo: 'A&7',
  //     disponivel: true,
  //     ativo: true,
  //   ),
  // );
  // await api_portao.excluirPortaoEmbarque('683b48d2b4dfba64c008949e');

  // await api.cadastrarFuncionario(funcionario);

  // final funcionarios = await api.listarFuncionarios();
  // print('Lista de Funcionários:');

  // for (var f in funcionarios) {
  //   print(f);
  // }
  // await api.buscarFuncionarioPorId('6838d154f82c6f537cb7da45');
  // await api.excluirFuncionario('68360d9fbcd7a55663718494');

  // await api.atualizarFuncionario(
  //   CadastroFuncionario(
  //     id: '6839a88de29a8973c2386c56',
  //     nome: 'Wisley César',
  //     email: 'wisleycesar32@gmail.com',
  //     cargo: 'admin',
  //     senha: '1223123',
  //   ),
  // );
}
