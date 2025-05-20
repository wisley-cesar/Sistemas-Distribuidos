package com.example.demo.controller;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.models.portao_embarque.DadosAtualizacaoPortao;
import com.example.demo.models.portao_embarque.DadosCadastroPortao;
import com.example.demo.models.portao_embarque.Portao;
import com.example.demo.models.portao_embarque.PortaoListagem;
import com.example.demo.repository.PortaoRepository;
import com.example.demo.service.portao_embarque.PortaoService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/portoes")
public class PortaoController {

    private final PortaoRepository portaoRepository;
    private final PortaoService portaoService;

    public PortaoController(PortaoRepository portaoRepository, PortaoService portaoService) {
        this.portaoRepository = portaoRepository;
        this.portaoService = portaoService;
    }

    // POST - Cadastrar portão
    @PostMapping
    public ResponseEntity<?> cadastrarPortao(@Valid @RequestBody DadosCadastroPortao dadosCadastro) {
        try {
            portaoService.cadastrarPortao(dadosCadastro);
            return ResponseEntity.ok().build();
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    // GET - Listar portões paginados
    @GetMapping
    public Page<PortaoListagem> listarPortoes(Pageable pageable) {
        return portaoRepository.findAll(pageable).map(PortaoListagem::new);
    }

    // PUT - Atualizar portão
    @PutMapping
    public void atualizarPortao(@Valid @RequestBody DadosAtualizacaoPortao dadosAtualizacao) {
        Portao portao = portaoRepository.findById(dadosAtualizacao.id())
            .orElseThrow(() -> new RuntimeException("Portão não encontrado"));
        portao.atualizarPortao(dadosAtualizacao);
        portaoRepository.save(portao);
    }

    // DELETE - Deletar portão (soft delete ou real, dependendo do modelo)
    @DeleteMapping("/{id}")
    public void deletarPortao(@PathVariable String id) {
        Portao portao = portaoRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Portão não encontrado"));
        
        portaoRepository.delete(portao); // ou um soft delete, se preferir
    }
}
