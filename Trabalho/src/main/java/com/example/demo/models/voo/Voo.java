package com.example.demo.models.voo;

import com.example.demo.models.portao_embarque.Portao;

import lombok.Data;

@Data
public class Voo {
    private String id;
    private Integer numeroVoo;
    private String origem;
    private String destino;
    private String dataHoraPartida;
    private Portao idPortao;
    private StatusVoo status;
    private boolean ativo = true;

    public Voo(String id, Integer numeroVoo, String origem, String destino, String dataHoraPartida, Portao idPortao, StatusVoo status) {
        this.id = id;
        this.numeroVoo = numeroVoo;
        this.origem = origem;
        this.destino = destino;
        this.dataHoraPartida = dataHoraPartida;
        this.idPortao = idPortao;
        this.status = status;
    }

    public Voo(DadosCadastroVoo dados) {
        this.numeroVoo = dados.numeroVoo();
        this.origem = dados.origem();
        this.destino = dados.destino();
        this.dataHoraPartida = dados.dataHoraPartida();
        this.idPortao = dados.idPortao();
        this.status = dados.status();
    }

    public Voo(ListagemVoo dados) {
        this.id = dados.id();
        this.numeroVoo = dados.numeroVoo();
        this.origem = dados.origem();
        this.destino = dados.destino();
        this.dataHoraPartida = dados.dataHoraPartida();
        this.idPortao = dados.idPortao();
        this.status = dados.status();
    }

    public Voo() {
        
    }

    public void atualizarVoo(DadosAtualizacaoVoo dados) {
        if (dados.numeroVoo() != null) {
            this.numeroVoo = dados.numeroVoo();
        }
        if (dados.origem() != null) {
            this.origem = dados.origem();
        }
        if (dados.destino() != null) {
            this.destino = dados.destino();
        }
        if (dados.dataHoraPartida() != null) {
            this.dataHoraPartida = dados.dataHoraPartida();
        }
        if (dados.idPortao() != null) {
            this.idPortao = dados.idPortao();
        }
        if (dados.status() != null) {
            this.status = dados.status();
        }
    }
}
