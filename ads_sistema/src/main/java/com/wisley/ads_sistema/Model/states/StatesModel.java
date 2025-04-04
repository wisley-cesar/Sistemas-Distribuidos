package com.wisley.ads_sistema.Model.states;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "States")
public class StatesModel {
    
    @Id
    private String id;

    private String nome;

    public StatesModel() {
    }

    public StatesModel(DadosCadastroStates dadosCadastroStates){
        this.nome = dadosCadastroStates.nome();
        this.id = dadosCadastroStates.id();
    }


    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void atualizarInformacoesStates(StatesModel statesModel) {
        if (statesModel.nome != null) {
            this.nome = statesModel.nome;
        }
    }
}