import 'package:aeroporto/aeroporto_app.dart';
import 'package:aeroporto/models/funcionario/cadastro_funcionario.dart';
import 'package:aeroporto/models/portao/portao_embarque_cadastro.dart';
import 'package:aeroporto/service/api_service_funcionario.dart';
import 'package:aeroporto/service/api_service_portao_embarque.dart';
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

  await api_portao.cadastrarPortaoEmbarque(
    PortaoEmbarqueCadastro(codigo: 'T9', disponivel: true),
  );

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
