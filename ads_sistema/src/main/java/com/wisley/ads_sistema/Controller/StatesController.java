package com.wisley.ads_sistema.Controller;

import com.wisley.ads_sistema.Model.DadosCadastroStates;
import com.wisley.ads_sistema.Model.StatesModel;
import com.wisley.ads_sistema.Repository.StatesRepository;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
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
    public List<StatesModel> listar(){
        return statesRepository.findAll();
    }
}
