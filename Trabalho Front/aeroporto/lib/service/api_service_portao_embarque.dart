import 'dart:convert';

import 'package:aeroporto/models/portao/portao_embarque.dart';
import 'package:aeroporto/models/portao/portao_embarque_cadastro.dart';
import 'package:aeroporto/service/api_service_funcionario.dart';
import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;

class ApiServicePortaoEmbarque {
  static const String _baseUrl = 'http://localhost:8080/portoes';

  ApiServiceFuncionario apiServiceFuncionario = Get.find();

  Future<void> cadastrarPortaoEmbarque(PortaoEmbarqueCadastro portao) async {
    String? token = Get.find<ApiServiceFuncionario>().getToken();
    print('esse é token $token');

    final url = Uri.parse("$_baseUrl");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(portao.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Portão de embarque cadastrado com sucesso: ${portao.codigo}');
    } else {
      print('Erro ao cadastrar portão de embarque: ${response.statusCode}');
      print('Resposta: ${response.body}');
    }
  }

  Future<List<PortaoEmbarqueCadastro>> listarPortoesEmbarque() async {
    String? token = Get.find<ApiServiceFuncionario>().getToken();
    final url = Uri.parse("$_baseUrl");

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic> && decoded.containsKey('portoes')) {
        final List<dynamic> data = decoded['portoes'];
        return data
            .map((portao) => PortaoEmbarqueCadastro.fromJson(portao))
            .toList();
      } else {
        print('Formato inesperado da resposta: $decoded');
        return [];
      }
    } else {
      print('Erro ao listar portões de embarque: ${response.statusCode}');
      print('Resposta: ${response.body}');
      return [];
    }
  }

  Future<void> atualizarPortaoEmbarque(PortaoEmbarque portao) async {
    String? token = Get.find<ApiServiceFuncionario>().getToken();

    final url = Uri.parse("$_baseUrl/${portao.id}");
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': "Bearer $token",
      },
      body: jsonEncode(portao.toJson()),
    );
    if (response.statusCode == 200) {
      print('Portão de embarque atualizado com sucesso: ${portao.codigo}');
    } else {
      print('Erro ao atualizar portão de embarque: ${response.statusCode}');
      print('Resposta: ${response.body}');
    }
  }
}
