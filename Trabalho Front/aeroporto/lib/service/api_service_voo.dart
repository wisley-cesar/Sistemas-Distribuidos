import 'dart:convert';
import 'package:aeroporto/models/voo/voo_cadastro.dart';
import 'package:aeroporto/models/voo/voo_embarque.dart';
import 'package:aeroporto/service/api_service_funcionario.dart';
import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;

class ApiServiceVoo {
  static const String baseUrl = 'http://localhost:8080/voo';

  Future<void> cadastrarVoo(VooCadastro voo) async {
    final url = Uri.parse("$baseUrl");
    final String? token = Get.find<ApiServiceFuncionario>().getToken();

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(voo.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Voo cadastrado com sucesso: ${voo.numeroVoo}');
    } else {
      print('Erro ao cadastrar voo: ${response.statusCode}');
      print('Resposta: ${response.body}');
    }
  }

  Future<void> listarVoos() async {
    final url = Uri.parse("$baseUrl");
    final String? token = Get.find<ApiServiceFuncionario>().getToken();

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('Voos listados com sucesso');
        final decoded = jsonDecode(response.body);
        print('Resposta da API: $decoded'); // Para debug
      } else {
        print('Erro ao listar voos: ${response.statusCode}');
        print('Resposta: ${response.body}');
      }
    } catch (e) {
      print('Erro ao processar resposta: $e');
    }
  }
}
