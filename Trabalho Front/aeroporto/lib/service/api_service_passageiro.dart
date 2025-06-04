import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:aeroporto/models/passageiros/passageiro.dart';
import 'package:aeroporto/service/api_service_funcionario.dart';

class ApiServicePassageiro {
  static const String _baseUrl = 'http://localhost:8080/passageiros';

  /// Cadastra um passageiro na API.
  Future<void> cadastrarPassageiro(Passageiro passageiro) async {
    final String? token = Get.find<ApiServiceFuncionario>().getToken();

    final response = await http.post(
      Uri.parse('$_baseUrl'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': "Bearer $token",
      },
      body: jsonEncode(passageiro.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Passageiro cadastrado com sucesso: ${passageiro.nome}');
    } else {
      print('Erro ao cadastrar passageiro: ${response.statusCode}');
      print('Resposta: ${response.body}');
    }
  }

  /// (Opcional) Busca todos os passageiros cadastrados
  Future<List<Passageiro>> listarPassageiros() async {
    final String? token = Get.find<ApiServiceFuncionario>().getToken();
    final response = await http.get(
      Uri.parse('$_baseUrl'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      print('Resposta da API: $decoded'); // Para debug

      if (decoded is Map && decoded.containsKey('content')) {
        // Trata resposta paginada
        final List<dynamic> data = decoded['content'] as List<dynamic>;
        return data.map((json) => Passageiro.fromJson(json)).toList();
      } else if (decoded is List) {
        // Se a resposta for uma lista direta
        return decoded.map((json) => Passageiro.fromJson(json)).toList();
      } else {
        print('Formato de resposta inválido: $decoded');
        return [];
      }
    } else {
      print('Erro ao listar passageiros: ${response.statusCode}');
      print('Resposta: ${response.body}');
      return [];
    }
  }
}
