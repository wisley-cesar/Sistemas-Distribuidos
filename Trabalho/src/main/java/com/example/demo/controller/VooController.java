package com.example.demo.controller;
import org.springframework.web.bind.annotation.RestController;
import com.example.demo.models.voo.DadosAtualizacaoVoo;
import com.example.demo.models.voo.DadosCadastroVoo;
import com.example.demo.models.voo.ListagemVoo;
import com.example.demo.models.voo.StatusVoo;
import com.example.demo.models.voo.Voo;
import com.example.demo.repository.VooRepository;
import com.example.demo.service.voo.VooService;
import com.example.demo.models.voo.RelatorioVooDTO;

import jakarta.validation.Valid;

import java.util.Map;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;


@RestController
@RequestMapping("/voo")
public class VooController {

    @Autowired
    private VooRepository vooRepository;

    @Autowired
    private VooService vooService;

    @PostMapping
    public void cadastrarVoo(@RequestBody @Valid DadosCadastroVoo dadosVoo){
        Voo voo = new Voo(dadosVoo);
        vooService.cadastrarVoo(voo);
    }

    @PutMapping("/{id}")
    public void atualizar(@PathVariable String id, @RequestBody @Valid DadosAtualizacaoVoo dadosAtualizacaoVoo) {
        Voo voo = vooRepository.findById(id).orElseThrow(() -> new RuntimeException("Voo não encontrado"));
        voo.atualizarVoo(dadosAtualizacaoVoo);
        vooRepository.save(voo);
    }

    @DeleteMapping("/{id}")
    public void deletar(@PathVariable String id){
        Voo voo = vooRepository.findById(id).orElseThrow(() -> new RuntimeException("Voo não encontrado"));
        voo.setAtivo(false);
        vooRepository.save(voo);
    }

    @GetMapping
    public Page<ListagemVoo> listar(Pageable paginacao){
        return vooRepository.findAllByAtivoTrue(paginacao).map(ListagemVoo::new);
    }

    @PutMapping("/{id}/status")
    public ResponseEntity<Voo> atualizarStatus(@PathVariable String id, @RequestBody Map<String, String> body) {
        String statusStr = body.get("status");
        if (statusStr == null) {
            return ResponseEntity.badRequest().body(null);
        }
        
        try {
            StatusVoo novoStatus = StatusVoo.valueOf(statusStr.toUpperCase());
            Voo vooAtualizado = vooService.alterarStatus(id, novoStatus);
            if (vooAtualizado == null) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok(vooAtualizado);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(null);
        } catch (RuntimeException e) {
            System.out.println("RuntimeException no controller: " + e.getMessage());
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/relatorio")
    public List<RelatorioVooDTO> relatorioVoosHoje() {
        return vooService.gerarRelatorioVoosHoje();
    }

}
