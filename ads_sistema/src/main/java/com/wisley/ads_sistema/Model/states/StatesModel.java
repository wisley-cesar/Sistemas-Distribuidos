package com.wisley.ads_sistema.Model.states;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Document(collection = "States")
public class StatesModel {
    
    @Id
    private String id;

    private String nome;
    
    private boolean ativo;

    public StatesModel() {
    }

    public StatesModel(DadosCadastroStates dadosCadastroStates){
        this.nome = dadosCadastroStates.nome();
        this.id = dadosCadastroStates.id();
    }

    public StatesModel(ListagemStates dados) {

        this.id = dados.id();
        this.nome = dados.nome();

    }

    public void atualizarInformacoesStates(ListagemStates dados) {
        if (dados.nome() != null) {
            this.nome = dados.nome();
        }
    }

    public void excluir() {
        this.ativo = false;
    }
}