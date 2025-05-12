package com.example.demo.models.portao_embarque;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Portao {
    private String id;
    private String codigo;
    private Boolean disponivel;
    private boolean isAtivo = true;

    public Portao(String id, String codigo, Boolean disponivel) {
        this.id = id;
        this.codigo = codigo;
        this.disponivel = disponivel;
    }

    public void AtualizarPortao(DadosAtualizacaoPortao dados) {
        if (dados.codigo() != null) {
            this.codigo = dados.codigo();
        }
        if (dados.disponivel() != null) {
            this.disponivel = dados.disponivel();
        }
    }
    public Portao(){
        
    }

}
