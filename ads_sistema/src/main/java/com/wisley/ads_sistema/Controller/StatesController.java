package com.wisley.ads_sistema.Controller;

import com.wisley.ads_sistema.Model.states.DadosCadastroStates;
import com.wisley.ads_sistema.Model.states.ListagemStates;
import com.wisley.ads_sistema.Model.states.StatesModel;
import com.wisley.ads_sistema.Repository.StatesRepository;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("states")
public class StatesController {
    @Autowired
    private StatesRepository statesRepository;

    @PostMapping
    @Transactional

    public void cadastrar(
            @RequestBody @Valid DadosCadastroStates dadosCadastroStates) {
        StatesModel statesModel = new StatesModel(dadosCadastroStates);
            statesRepository.save(statesModel);
    }

    @GetMapping
    public Page<ListagemStates> listar(Pageable paginacao) {
        return statesRepository.findAllByAtivoTrue(paginacao).map(ListagemStates::new);
    }

    @PutMapping
    @Transactional
    public void atualizarInformacoesStates(@Valid @RequestBody ListagemStates dados) {

        StatesModel statesModel = statesRepository.findById(dados.id()).orElseThrow(() -> new RuntimeException("Id não encontrado"));
        statesModel.atualizarInformacoesStates(dados);
        statesRepository.save(statesModel);
    }
    
    @DeleteMapping("/{id}")
    public void deletar(@PathVariable String id) {
        StatesModel statesModel = statesRepository.findById(id).orElseThrow(() -> new RuntimeException("Id não encontrado"));
        statesModel.excluir();
        statesRepository.save(statesModel);
    }
}
