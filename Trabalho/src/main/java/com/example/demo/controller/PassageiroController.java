package com.example.demo.controller;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

import com.example.demo.models.passageiro.DadosAtualizacaoPassageiro;
import com.example.demo.models.passageiro.DadosCadastroPassageiro;
import com.example.demo.models.passageiro.Passageiro;
import com.example.demo.models.passageiro.PassageiroListagem;
import com.example.demo.models.passageiro.StatusCheckIn;
import com.example.demo.repository.PassageiroRepository;
import com.example.demo.service.passageiro.PassageiroService;

import jakarta.validation.Valid;

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
    public void cadastrarPassageiro(@Valid @RequestBody DadosCadastroPassageiro dadosCadastro) {
        Passageiro passageiro = new Passageiro(dadosCadastro);
        passageiroRepository.save(passageiro);
    }

    @GetMapping
    public Page<PassageiroListagem> listarPage(Pageable pageable) {
        return passageiroRepository.findAll(pageable).map(PassageiroListagem::new);
    }

    @PatchMapping("/{id}/status-check-in")
    public Passageiro atualizarStatusCheckIn(@PathVariable String id, @RequestParam StatusCheckIn statusCheckIn) {
        return passageiroService.atualizarStatusCheckIn(id, statusCheckIn);
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
