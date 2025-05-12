package com.example.demo.controller;
import org.springframework.web.bind.annotation.RestController;
import com.example.demo.models.voo.DadosAtualizacaoVoo;
import com.example.demo.models.voo.DadosCadastroVoo;
import com.example.demo.models.voo.ListagemVoo;
import com.example.demo.models.voo.Voo;
import com.example.demo.repository.VooRepository;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
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

    private  VooRepository vooRepository;

    @PostMapping
    public void cadastrarVoo( @RequestBody @Valid DadosCadastroVoo dadosVoo){
        Voo voo = new Voo(dadosVoo);
        vooRepository.save(voo);
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

    @GetMapping()
    public Page<ListagemVoo> listar(Pageable paginacao){
        return vooRepository.findAllByAtivoTrue(paginacao).map(ListagemVoo::new);
    }
}
