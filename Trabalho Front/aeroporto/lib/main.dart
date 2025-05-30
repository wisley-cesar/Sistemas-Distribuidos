import 'package:aeroporto/aeroporto_app.dart';
import 'package:aeroporto/models/funcionario/cadastro_funcionario.dart';
import 'package:aeroporto/service/api_service_funcionario.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(
    const AeroportoApp(),
  );
  final funcionario = CadastroFuncionario(
    nome: 'João Silva',
    email: 'joao@gmail.com',
    cargo: 'ADMIN',
    senha: '123456',
    id: '1234567890abcdef',
  );

  final api = ApiServiceFuncionario();
  // await api.cadastrarFuncionario(funcionario);

  await api.fazerLogin(funcionario.senha, funcionario.email);
  // final funcionarios = await api.listarFuncionarios();
  // print('Lista de Funcionários:');

  // for (var f in funcionarios) {
  //   print(f);
  // }
  // await api.buscarFuncionarioPorId('6838d154f82c6f537cb7da45');
  // await api.excluirFuncionario('68360d9fbcd7a55663718494');

  await api.atualizarFuncionario(
    CadastroFuncionario(
      id: '6839a88de29a8973c2386c56',
      nome: 'Wisley César',
      email: 'wisleycesar32@gmail.com',
      cargo: 'admin',
      senha: '1223123',
    ),
  );
}
