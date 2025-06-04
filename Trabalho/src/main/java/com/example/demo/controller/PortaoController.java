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
import com.example.demo.models.voo.Voo;
import com.example.demo.repository.PortaoRepository;
import com.example.demo.repository.VooRepository;
import com.example.demo.security.RequireAdmin;
import com.example.demo.service.portao_embarque.PortaoService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/portoes")
@RequiredArgsConstructor
public class PortaoController {

    private final PortaoRepository portaoRepository;
    private final PortaoService portaoService;
    private final VooRepository vooRepository;

    // POST - Cadastrar portão
    @PostMapping
    @RequireAdmin
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
        return portaoRepository.findAllByAtivoTrue(pageable).map(PortaoListagem::new);
    }

    // PUT - Atualizar portão
    @PutMapping("/{id}")
    @RequireAdmin
    public void atualizarPortao(@PathVariable String id, @Valid @RequestBody DadosAtualizacaoPortao dadosAtualizacao) {
        Portao portao = portaoRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Portão não encontrado"));
        portao.atualizarPortao(dadosAtualizacao);
        portaoRepository.save(portao);
    }

    // DELETE - Deletar portão
    @DeleteMapping("/{id}")
    @RequireAdmin
    public ResponseEntity<?> deletarPortao(@PathVariable String id) {
        try {
            Portao portao = portaoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Portão não encontrado"));
            
            // Verifica se existem voos associados a este portão
            List<Voo> voosComPortao = vooRepository.findAll().stream()
                .filter(v -> v.getIdPortao() != null && 
                           v.getIdPortao().getId().equals(portao.getId()) && 
                           v.isAtivo())
                .collect(Collectors.toList());

            if (!voosComPortao.isEmpty()) {
                return ResponseEntity.badRequest()
                    .body("Não é possível excluir o portão pois existem voos ativos associados a ele.");
            }

            // Se não houver voos associados, exclui o portão do banco
            portaoRepository.delete(portao);
            return ResponseEntity.ok().body("Portão excluído com sucesso");
        } catch (RuntimeException e) {
            return ResponseEntity.status(404).body(e.getMessage());
        }
    }
}
