package com.example.demo.controller;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.models.funcionario.DadosCadastroFuncionario;
import com.example.demo.models.funcionario.DadosLogin;
import com.example.demo.models.funcionario.Funcionario;
import com.example.demo.security.JwtTokenProvider;
import com.example.demo.security.RequireAdmin;
import com.example.demo.service.funcionario.FuncionarioService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/funcionarios")
@RequiredArgsConstructor
@Slf4j
public class FuncionarioController {

    private final FuncionarioService funcionarioService;
    private final AuthenticationManager authenticationManager;
    private final JwtTokenProvider tokenProvider;

    @PostMapping("/cadastro")
    public ResponseEntity<?> cadastrarFuncionario(@Valid @RequestBody DadosCadastroFuncionario dados) {
        log.info("Recebendo requisição de cadastro para o email: {}", dados.email());
        try {
            Funcionario funcionario = funcionarioService.cadastrarFuncionario(dados);
            log.info("Funcionário cadastrado com sucesso: {}", dados.email());
            return ResponseEntity.ok().body(funcionario);
        } catch (RuntimeException e) {
            log.error("Erro ao cadastrar funcionário: {}", e.getMessage());
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@Valid @RequestBody DadosLogin dados) {
        log.info("Recebendo requisição de login para o email: {}", dados.email());
        try {
            log.info("Tentando autenticar usuário...");
            var authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(dados.email(), dados.senha())
            );
            
            log.info("Autenticação bem sucedida, gerando token...");
            String token = tokenProvider.generateToken(authentication);
            log.info("Login realizado com sucesso para: {}", dados.email());
            return ResponseEntity.ok().body(Map.of("token", token));
        } catch (Exception e) {
            log.error("Erro no login: {}", e.getMessage(), e);
            return ResponseEntity.badRequest().body("Credenciais inválidas: " + e.getMessage());
        }
    }

    @GetMapping("/listar")
    public ResponseEntity<?> listarFuncionarios() {
        return ResponseEntity.ok(funcionarioService.listarTodos());
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> buscarPorId(@PathVariable String id) {
        try {
            Funcionario funcionario = funcionarioService.loadUserById(id);
            return ResponseEntity.ok(funcionario);
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }

    @PutMapping("/{id}")
    @RequireAdmin
    public ResponseEntity<?> atualizarFuncionario(@PathVariable String id, @Valid @RequestBody DadosCadastroFuncionario dados) {
        try {
            Funcionario funcionario = funcionarioService.atualizarFuncionario(id, dados);
            return ResponseEntity.ok(funcionario);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    @RequireAdmin
    public ResponseEntity<?> deletarFuncionario(@PathVariable String id) {
        try {
            funcionarioService.deletarFuncionario(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
} 