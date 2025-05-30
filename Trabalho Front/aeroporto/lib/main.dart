import 'package:aeroporto/aeroporto_app.dart';
import 'package:aeroporto/models/funcionario/cadastro_funcionario.dart';
import 'package:aeroporto/models/funcionario/funcionario.dart';
import 'package:aeroporto/service/api_service_funcionario.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(
    const AeroportoApp(),
  );
  final funcionario = CadastroFuncionario(
    nome: 'João Silva',
    email: 'joao@gmail.com',
    telefone: '6499222222',
    cargo: 'ADMIN',
    senha: '123456',
  );

  final api = ApiServiceFuncionario();
  // await api.cadastrarFuncionario(funcionario);

  await api.fazerLogin(funcionario.senha, funcionario.email);
  // final funcionarios = await api.listarFuncionarios();
  // print('Lista de Funcionários:');

  // for (var f in funcionarios) {
  //   print(f);
  // }

  await api.atualizarFuncionario(
    Funcionario(
      id: '6838d154f82c6f537cb7da45',
      nome: 'César',
      email: 'Cesar@gmail.com',
      cargo: 'admin',
    ),
  );
}
