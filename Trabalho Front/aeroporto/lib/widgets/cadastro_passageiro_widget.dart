import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aeroporto/models/passageiros/passageiro.dart';
import 'package:aeroporto/models/voo/voo_embarque.dart';
import 'package:aeroporto/service/api_service_passageiro.dart';
import 'package:aeroporto/service/api_service_voo.dart';

class CadastroPassageiroWidget extends StatefulWidget {
  const CadastroPassageiroWidget({Key? key}) : super(key: key);

  @override
  State<CadastroPassageiroWidget> createState() =>
      _CadastroPassageiroWidgetState();
}

class _CadastroPassageiroWidgetState extends State<CadastroPassageiroWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  VooEmbarque? _selectedVoo;
  List<VooEmbarque> _voos = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _carregarVoos();
  }

  Future<void> _carregarVoos() async {
    setState(() => _isLoading = true);
    try {
      final apiVoo = Get.put(ApiServiceVoo());
      final voos = await apiVoo.listarVoos();
      setState(() {
        _voos = voos;
        _isLoading = false;
      });
    } catch (e) {
      print('Erro ao carregar voos: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _cadastrarPassageiro() async {
    if (_formKey.currentState!.validate() && _selectedVoo != null) {
      try {
        final apiPassageiro = Get.put(ApiServicePassageiro());
        await apiPassageiro.cadastrarPassageiro(
          nome: _nomeController.text,
          cpf: _cpfController.text,
          email: _emailController.text,
          senha: _senhaController.text,
          idVoo: _selectedVoo!.id,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passageiro cadastrado com sucesso!')),
        );

        _nomeController.clear();
        _cpfController.clear();
        _emailController.clear();
        _senhaController.clear();
        setState(() => _selectedVoo = null);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao cadastrar passageiro: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _nomeController,
            decoration: const InputDecoration(
              labelText: 'Nome',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o nome';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _cpfController,
            decoration: const InputDecoration(
              labelText: 'CPF',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o CPF';
              }
              if (value.length != 11) {
                return 'CPF deve conter 11 dígitos';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'E-mail',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o e-mail';
              }
              if (!value.contains('@')) {
                return 'Por favor, insira um e-mail válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _senhaController,
            decoration: const InputDecoration(
              labelText: 'Senha',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira a senha';
              }
              if (value.length < 6) {
                return 'A senha deve ter pelo menos 6 caracteres';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<VooEmbarque>(
            value: _selectedVoo,
            decoration: const InputDecoration(
              labelText: 'Voo',
              border: OutlineInputBorder(),
            ),
            items: _voos.map((voo) {
              return DropdownMenuItem(
                value: voo,
                child: Text(
                    'Voo ${voo.numeroVoo} - ${voo.origem} para ${voo.destino}'),
              );
            }).toList(),
            onChanged: (VooEmbarque? value) {
              setState(() {
                _selectedVoo = value;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Por favor, selecione um voo';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _isLoading ? null : _cadastrarPassageiro,
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text('Cadastrar Passageiro'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }
}
