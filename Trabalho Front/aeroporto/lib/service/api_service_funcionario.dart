import 'dart:convert';

import 'package:aeroporto/models/funcionario/cadastro_funcionario.dart';
import 'package:aeroporto/models/funcionario/funcionario.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ApiServiceFuncionario extends GetxController {
  static const String _baseUrl = "http://localhost:8080/funcionarios";

  String? token;

  String? getToken() {
    return token;
  }

  Future<void> cadastrarFuncionario(CadastroFuncionario funcionario) async {
    final url = Uri.parse("$_baseUrl/cadastro");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(funcionario.toJson()),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Funcionário cadastrado com sucesso: ${funcionario.nome}');
      } else {
        print('Erro ao cadastrar funcionário: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao cadastrar funcionário: $e');
    }
  }

  Future<void> fazerLogin(String password, String email) async {
    final url = Uri.parse("$_baseUrl/login");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'senha': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      token = jsonDecode(response.body)['token'];
      // print('Esse é o token: $token');
      print('Login realizado com sucesso');
      final data = jsonDecode(response.body);
      print('Dados do funcionário: $data');
    } else {
      print('Erro ao fazer login: ${response.statusCode}');
    }
  }

  Future<List<Funcionario>> listarFuncionarios() async {
    final url = Uri.parse("$_baseUrl/listar");

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Funcionario.fromJson(json)).toList();
    } else {
      print('Erro ao listar funcionários: ${response.statusCode}');
      return [];
    }
  }

  Future<Funcionario> buscarFuncionarioPorId(String id) async {
    final url = Uri.parse('$_baseUrl/$id');

    final response = await http.get(
      url,

      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Funcionario.fromJson(json);
    } else {
      print('Erro ao buscar funcionário: ${response.statusCode}');
      throw Exception('Erro ao buscar funcionário');
    }
  }

  Future<void> atualizarFuncionario(
    CadastroFuncionario cadastroFuncionario,
  ) async {
    final url = Uri.parse("$_baseUrl/${cadastroFuncionario.id}");

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(cadastroFuncionario.toJson()),
    );
    if (response.statusCode == 200) {
      print('Funcionário atualizado com sucesso: ${cadastroFuncionario.nome}');
    } else {
      print('Erro ao atualizar funcionário: ${response.statusCode}');
      print('Resposta: ${response.body}');
    }
  }

  Future<void> excluirFuncionario(String id) async {
    final url = Uri.parse("$_baseUrl/$id");

    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 204) {
      print('Funcionário excluído com sucesso');
    } else {
      print('Erro ao excluir funcionário: ${response.statusCode}');
      print('Resposta: ${response.body}');
    }
  }
}
