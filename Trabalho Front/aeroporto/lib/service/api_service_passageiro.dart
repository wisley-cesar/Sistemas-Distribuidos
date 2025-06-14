import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:aeroporto/models/passageiros/passageiro.dart';
import 'package:aeroporto/models/passageiros/passageiro_login_response.dart';
import 'package:aeroporto/models/passageiros/voo_info.dart' as voo;
import 'package:aeroporto/service/api_service_funcionario.dart';

class ApiServicePassageiro {
  static const String _baseUrl = 'http://localhost:8080/passageiros';

  /// Realiza o login do passageiro
  Future<PassageiroLoginResponse> login({
    required String email,
    required String senha,
  }) async {
    print('Making login request to: $_baseUrl/login');
    final Map<String, dynamic> body = {
      'email': email,
      'senha': senha,
    };
    print('Request body: $body');

    try {
      final response = await http.post(
        Uri.parse('${_baseUrl}/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        // Salva o token usando o serviço de funcionário
        final authService = Get.find<ApiServiceFuncionario>();
        await authService.saveToken(data['token']);

        return PassageiroLoginResponse.fromJson(data);
      } else {
        final error = jsonDecode(response.body);
        final errorMessage =
            error['message'] ?? 'Erro ao fazer login. Tente novamente.';
        throw Exception(errorMessage);
      }
    } on http.ClientException {
      throw Exception(
          'Não foi possível conectar ao servidor. Verifique sua conexão.');
    } catch (e) {
      print('Error in login request: $e');
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Ocorreu um erro inesperado. Tente novamente.');
    }
  }

  /// Cadastra um passageiro na API.
  Future<void> cadastrarPassageiro({
    required String nome,
    required String cpf,
    required String email,
    required String senha,
    required String idVoo,
  }) async {
    final String? token = Get.find<ApiServiceFuncionario>().getToken();

    final Map<String, dynamic> body = {
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'senha': senha,
      'idVoo': {
        'id': idVoo,
      },
      'statusCheckIn': 'PENDENTE'
    };

    final response = await http.post(
      Uri.parse('$_baseUrl'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': "Bearer $token",
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Passageiro cadastrado com sucesso: $nome');
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Erro ao cadastrar passageiro');
    }
  }

  /// Busca todos os passageiros cadastrados
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

  /// Busca os dados do passageiro logado
  Future<PassageiroLoginResponse> getPassageiroData() async {
    final String? token = Get.find<ApiServiceFuncionario>().getToken();

    if (token == null) {
      throw Exception('Token não encontrado. Faça login novamente.');
    }

    try {
      // Extrai o ID do passageiro do token JWT
      final parts = token.split('.');
      if (parts.length != 3) {
        throw Exception('Token inválido');
      }

      // Adiciona padding se necessário
      String base64 = parts[1];
      switch (base64.length % 4) {
        case 0:
          break; // Sem padding necessário
        case 2:
          base64 += '==';
          break;
        case 3:
          base64 += '=';
          break;
        default:
          throw Exception('Token mal formatado');
      }

      // Substitui caracteres não seguros para URL
      base64 = base64.replaceAll('-', '+').replaceAll('_', '/');

      final payload = jsonDecode(utf8.decode(base64Decode(base64)));
      final passageiroId = payload['id'];

      print('Buscando dados do passageiro com ID: $passageiroId');
      print('URL: $_baseUrl/$passageiroId');

      final response = await http.get(
        Uri.parse('$_baseUrl/$passageiroId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Resposta da API - Status: ${response.statusCode}');
      print('Resposta da API - Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        // Converte a resposta para o formato esperado pelo PassageiroLoginResponse
        final Map<String, dynamic> formattedData = {
          'token': token,
          'nome': data['nome'],
          'cpf': data['cpf'],
          'idVoo': data['idVoo']['id'],
          'statusCheckIn': data['statusCheckIn'],
        };

        return PassageiroLoginResponse.fromJson(formattedData);
      } else {
        final error = jsonDecode(response.body);
        final errorMessage =
            error['message'] ?? 'Erro ao buscar dados do passageiro';
        print('Erro na API: $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Erro ao buscar dados do passageiro: $e');
      if (e is FormatException) {
        throw Exception('Erro ao processar o token. Faça login novamente.');
      }
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Erro ao buscar dados do passageiro: $e');
    }
  }

  /// Busca os detalhes de um voo específico
  Future<voo.VooInfo?> getVooDetails(String idVoo) async {
    final String? token = Get.find<ApiServiceFuncionario>().getToken();

    if (token == null) {
      throw Exception('Token não encontrado. Faça login novamente.');
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/voos/$idVoo'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return voo.VooInfo.fromJson(data);
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Erro ao buscar detalhes do voo');
    }
  }
}
