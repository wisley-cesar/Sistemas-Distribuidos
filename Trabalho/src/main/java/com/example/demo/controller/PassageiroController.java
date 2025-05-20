package com.example.demo.controller;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.example.demo.models.passageiro.DadosAtualizacaoPassageiro;
import com.example.demo.models.passageiro.DadosCadastroPassageiro;
import com.example.demo.models.passageiro.Passageiro;
import com.example.demo.models.passageiro.PassageiroListagem;
import com.example.demo.models.passageiro.StatusCheckIn;
import com.example.demo.repository.PassageiroRepository;
import com.example.demo.service.passageiro.PassageiroService;

import jakarta.validation.Valid;
import java.util.Map;

@RestController
@RequestMapping("/passageiros")
public class PassageiroController {

    private final PassageiroRepository passageiroRepository;
    private final PassageiroService passageiroService;

    public PassageiroController(PassageiroRepository passageiroRepository, PassageiroService passageiroService) {
        this.passageiroRepository = passageiroRepository;
        this.passageiroService = passageiroService;
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

    @PatchMapping("/{id}/status-check-in")
    public Passageiro atualizarStatusCheckIn(@PathVariable String id, @RequestParam StatusCheckIn statusCheckIn) {
        return passageiroService.atualizarStatusCheckIn(id, statusCheckIn);
    }

    @PutMapping("/{id}/status-check-in")
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
    public void deletarPassageiro(@PathVariable String id) {
        Passageiro passageiro = passageiroRepository.findById(id).orElseThrow(() -> new RuntimeException("Passageiro não encontrado"));
        passageiro.setAtivo(false);
        passageiroRepository.save(passageiro);
    }

    public void atulizarPassageiro(DadosAtualizacaoPassageiro atualizacaoPassageiro) {
        Passageiro passageiro = passageiroRepository.findById(atualizacaoPassageiro.id()).orElseThrow(() -> new RuntimeException("Passageiro não encontrado"));
        passageiro.atualizarInformacoes(atualizacaoPassageiro);
        passageiroRepository.save(passageiro);
    }
}
