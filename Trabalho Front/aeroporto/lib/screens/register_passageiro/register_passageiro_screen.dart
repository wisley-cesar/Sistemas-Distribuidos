import 'package:aeroporto/screens/login_funcionario/widgets/button_login.dart';
import 'package:aeroporto/screens/login_funcionario/widgets/login_background.dart';
import 'package:aeroporto/util/app_routes.dart';
import 'package:aeroporto/widgets/my_icon.dart';
import 'package:aeroporto/widgets/my_text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aeroporto/models/voo/voo_embarque.dart';
import 'package:aeroporto/service/api_service_passageiro.dart';

class RegisterPassageiroScreen extends StatelessWidget {
  RegisterPassageiroScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _apiServicePassageiro = Get.put(ApiServicePassageiro());
  final RxBool _isLoading = false.obs;
  final Rx<VooEmbarque?> _selectedVoo = Rx<VooEmbarque?>(null);

  Future<void> _cadastrarPassageiro() async {
    if (_formKey.currentState!.validate() && _selectedVoo.value != null) {
      _isLoading.value = true;
      try {
        await _apiServicePassageiro.cadastrarPassageiro(
          nome: _nameController.text,
          cpf: _cpfController.text,
          email: _emailController.text,
          senha: _passwordController.text,
          idVoo: _selectedVoo.value!.id,
        );

        Get.snackbar(
          'Sucesso',
          'Passageiro cadastrado com sucesso!',
          snackPosition: SnackPosition.BOTTOM,
        );

        // Navegar para a tela de login
        Get.offAllNamed(AppRoutes.loginPassageiro);
      } catch (e) {
        Get.snackbar(
          'Erro',
          'Não foi possível cadastrar o passageiro. Tente novamente.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } finally {
        _isLoading.value = false;
      }
    } else if (_selectedVoo.value == null) {
      Get.snackbar(
        'Atenção',
        'Selecione um voo para continuar',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Receber o voo selecionado
    final voo = Get.arguments as VooEmbarque?;
    if (voo != null) {
      _selectedVoo.value = voo;
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade900,
              Colors.white,
            ],
            stops: const [0.0, 0.9],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cadastro de Passageiro',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Complete seus dados para finalizar o cadastro',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (_selectedVoo.value != null) ...[
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.flight_takeoff,
                                  color: Colors.blue.shade700,
                                  size: 24,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Voo Selecionado',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _buildInfoRow(
                              'Número do Voo',
                              'Voo ${_selectedVoo.value!.numeroVoo}',
                            ),
                            const SizedBox(height: 12),
                            _buildInfoRow(
                              'Rota',
                              '${_selectedVoo.value!.origem} → ${_selectedVoo.value!.destino}',
                            ),
                            const SizedBox(height: 12),
                            _buildInfoRow(
                              'Data e Hora',
                              _selectedVoo.value!.dataHoraPartida,
                            ),
                            const SizedBox(height: 12),
                            _buildInfoRow(
                              'Portão',
                              _selectedVoo.value!.portaoEmbarqueId.codigo,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dados Pessoais',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade700,
                              ),
                            ),
                            const SizedBox(height: 24),
                            MyTextInput(
                              label: 'Nome Completo',
                              prefixIcon: Icons.person,
                              hintText: 'Digite seu nome completo',
                              textInputAction: TextInputAction.next,
                              controller: _nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira seu nome';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            MyTextInput(
                              label: 'Email',
                              prefixIcon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                              hintText: 'Digite seu email',
                              textInputAction: TextInputAction.next,
                              controller: _emailController,
                              isEmail: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira seu email';
                                }
                                if (!value.contains('@')) {
                                  return 'Por favor, insira um email válido';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            MyTextInput(
                              label: 'CPF',
                              prefixIcon: Icons.badge,
                              keyboardType: TextInputType.number,
                              hintText: 'Digite seu CPF',
                              textInputAction: TextInputAction.next,
                              controller: _cpfController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira seu CPF';
                                }
                                if (value.length != 11) {
                                  return 'CPF deve conter 11 dígitos';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Dados de Acesso',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade700,
                              ),
                            ),
                            const SizedBox(height: 24),
                            MyTextInput(
                              label: 'Senha',
                              prefixIcon: Icons.lock,
                              obscureText: true,
                              hintText: 'Digite sua senha',
                              textInputAction: TextInputAction.next,
                              controller: _passwordController,
                              isPassword: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira sua senha';
                                }
                                if (value.length < 6) {
                                  return 'A senha deve ter pelo menos 6 caracteres';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            MyTextInput(
                              label: 'Confirmar Senha',
                              prefixIcon: Icons.lock_outline,
                              obscureText: true,
                              hintText: 'Confirme sua senha',
                              textInputAction: TextInputAction.done,
                              controller: _confirmPasswordController,
                              validator: (value) {
                                if (value != _passwordController.text) {
                                  return 'As senhas não coincidem';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 32),
                            Obx(() => ButtonLogin(
                                  title: _isLoading.value
                                      ? 'Cadastrando...'
                                      : 'Cadastrar',
                                  backgroundColor: Colors.blue.shade700,
                                  foregroundColor: Colors.white,
                                  shadowColor: Colors.blue.shade900,
                                  onPressed: _isLoading.value
                                      ? null
                                      : _cadastrarPassageiro,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.blue.shade700,
          ),
        ),
      ],
    );
  }
}
