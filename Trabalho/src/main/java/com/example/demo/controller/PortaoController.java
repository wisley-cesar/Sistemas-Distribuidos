package com.example.demo.controller;

import com.example.demo.models.portao_embarque.DadosAtualizacaoPortao;
import com.example.demo.models.portao_embarque.DadosCadastroPortao;
import com.example.demo.models.portao_embarque.Portao;
import com.example.demo.models.portao_embarque.PortaoListagem;
import com.example.demo.repository.PortaoRepository;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/portoes")
public class PortaoController {

    private final PortaoRepository portaoRepository;

    public PortaoController(PortaoRepository portaoRepository) {
        this.portaoRepository = portaoRepository;
    }

    // POST - Cadastrar portão
    @PostMapping
    public void cadastrarPortao(@Valid @RequestBody DadosCadastroPortao dadosCadastro) {
        Portao portao = new Portao(null, dadosCadastro.codigo(), dadosCadastro.disponivel());
        portaoRepository.save(portao);
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
        portao.AtualizarPortao(dadosAtualizacao);
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
