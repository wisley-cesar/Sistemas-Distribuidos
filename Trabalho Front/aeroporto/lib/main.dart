import 'package:aeroporto/aeroporto_app.dart';
import 'package:aeroporto/models/funcionario/cadastro_funcionario.dart';
import 'package:aeroporto/models/passageiros/passageiro.dart';
import 'package:aeroporto/models/voo/voo_embarque.dart';
import 'package:aeroporto/service/api_service_funcionario.dart';
import 'package:aeroporto/service/api_service_passageiro.dart';
import 'package:aeroporto/service/api_service_portao_embarque.dart';
import 'package:aeroporto/service/api_service_voo.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

void main() async {
  Get.put(ApiServiceFuncionario());

  runApp(
    const AeroportoApp(),
  );

  // final api = Get.put(ApiServiceFuncionario());
  // final funcionario = CadastroFuncionario(
  //   nome: 'Wisley César',
  //   email: 'wisleycesar32@gmail.com',
  //   cargo: 'admin',
  //   senha: '1223123',
  //   id: '6839a88de29a8973c2386c56',
  // );

  // // final api = ApiServiceFuncionario();
  // // await api.cadastrarFuncionario(funcionario);
  // final api_portao = ApiServicePortaoEmbarque();

  // await api.fazerLogin(funcionario.senha, funcionario.email);

  // final ApiServiceVoo apiVoo = ApiServiceVoo();

  // final apiPassageiro = ApiServicePassageiro();
  // await apiPassageiro.cadastrarPassageiro(
  //   Passageiro.cadastro(
  //     nome: 'Wisley César',
  //     cpf: '71249189101',
  //     vooEmbarqueId: VooEmbarque.somenteId('683ca5d8b9c6cf3383f1044e'),
  //   ),
  // );
  // await apiPassageiro.listarPassageiros();
}
