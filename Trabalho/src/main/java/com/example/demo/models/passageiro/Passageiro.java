package com.example.demo.models.passageiro;

import org.springframework.data.mongodb.core.mapping.Document;

import com.example.demo.models.voo.Voo;

import lombok.Getter;
import lombok.Setter;

@Document(collection = "passageiro")
@Getter
@Setter
public class Passageiro {
    private String id;
    private String nome;
    private String cpf;
    private Voo idVoo;
    private StatusCheckIn statusCheckIn;
    private boolean ativo = true;
    

    

    public Passageiro(String id, String nome, String cpf, Voo idVoo, StatusCheckIn statusCheckIn) {
        this.id = id;
        this.nome = nome;
        this.cpf = cpf;
        this.idVoo = idVoo;
        this.statusCheckIn = statusCheckIn;
    }
    public Passageiro(DadosCadastroPassageiro dados) {
        this.nome = dados.nome();
        this.cpf = dados.cpf();
        this.idVoo = dados.idVoo();
        this.statusCheckIn = dados.statusCheckIn();
    }

    public Passageiro(PassageiroListagem passageiroListagem){
        this.id = passageiroListagem.id();
        this.nome = passageiroListagem.nome();
        this.cpf = passageiroListagem.cpf();
        this.idVoo = passageiroListagem.idVoo();
        this.statusCheckIn = passageiroListagem.statusCheckIn();
    }
    public Passageiro() {}
    

    public void atualizarInformacoes(DadosAtualizacaoPassageiro dados) {
        if (dados.nome() != null) {
            this.nome = dados.nome();
        }
        if (dados.cpf() != null) {
            this.cpf = dados.cpf();
        }
        if (dados.idVoo() != null) {
            this.idVoo = dados.idVoo();
        }
        if (dados.statusCheckIn() != null) {
            this.statusCheckIn = dados.statusCheckIn();
        }
    }

}
