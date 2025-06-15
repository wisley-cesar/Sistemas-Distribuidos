package com.example.demo.controller;

import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.models.passageiro.DadosAtualizacaoPassageiro;
import com.example.demo.models.passageiro.DadosCadastroPassageiro;
import com.example.demo.models.passageiro.DadosLoginPassageiro;
import com.example.demo.models.passageiro.Passageiro;
import com.example.demo.models.passageiro.PassageiroListagem;
import com.example.demo.models.passageiro.RespostaLoginPassageiro;
import com.example.demo.models.passageiro.StatusCheckIn;
import com.example.demo.repository.PassageiroRepository;
import com.example.demo.security.RequireAdmin;
import com.example.demo.service.passageiro.PassageiroAuthService;
import com.example.demo.service.passageiro.PassageiroService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/passageiros")
@RequiredArgsConstructor
public class PassageiroController {

    private final PassageiroRepository passageiroRepository;
    private final PassageiroService passageiroService;
    private final PassageiroAuthService passageiroAuthService;

    @PostMapping("/login")
    public ResponseEntity<?> login(@Valid @RequestBody DadosLoginPassageiro dados) {
        try {
            RespostaLoginPassageiro resposta = passageiroAuthService.login(dados);
            return ResponseEntity.ok(resposta);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping
    public ResponseEntity<?> cadastrarPassageiro(@Valid @RequestBody DadosCadastroPassageiro dadosCadastro) {
        try {
            passageiroService.cadastrarPassageiro(dadosCadastro);
            return ResponseEntity.ok().build();
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping
    public Page<PassageiroListagem> listarPage(Pageable pageable) {
        return passageiroRepository.findAll(pageable).map(PassageiroListagem::new);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> buscarPorId(@PathVariable String id) {
        try {
            Passageiro passageiro = passageiroRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Passageiro não encontrado"));
            return ResponseEntity.ok(new PassageiroListagem(passageiro));
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PatchMapping("/{id}/status-check-in")
    @RequireAdmin
    public Passageiro atualizarStatusCheckIn(@PathVariable String id, @RequestParam StatusCheckIn statusCheckIn) {
        return passageiroService.atualizarStatusCheckIn(id, statusCheckIn);
    }

    @PutMapping("/{id}/status-check-in")
    @RequireAdmin
    public ResponseEntity<?> atualizarStatusCheckInPut(@PathVariable String id, @RequestBody Map<String, String> body) {
        String statusStr = body.get("statusCheckIn");
        if (statusStr == null) {
            return ResponseEntity.badRequest().body("Status de Check-in não informado no body.");
        }
        try {
            StatusCheckIn novoStatus = StatusCheckIn.valueOf(statusStr.toUpperCase());
            Passageiro passageiroAtualizado = passageiroService.atualizarStatusCheckIn(id, novoStatus);
            return ResponseEntity.ok(passageiroAtualizado);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body("Status de Check-in inválido.");
        } catch (RuntimeException e) {
             return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    @RequireAdmin
    public void deletarPassageiro(@PathVariable String id) {
        Passageiro passageiro = passageiroRepository.findById(id).orElseThrow(() -> new RuntimeException("Passageiro não encontrado"));
        passageiro.setAtivo(false);
        passageiroRepository.save(passageiro);
    }

    @PutMapping("/{id}")
    @RequireAdmin
    public void atulizarPassageiro(@PathVariable String id, @RequestBody DadosAtualizacaoPassageiro atualizacaoPassageiro) {
        Passageiro passageiro = passageiroRepository.findById(id).orElseThrow(() -> new RuntimeException("Passageiro não encontrado"));
        passageiro.atualizarInformacoes(atualizacaoPassageiro);
        passageiroRepository.save(passageiro);
    }
}
