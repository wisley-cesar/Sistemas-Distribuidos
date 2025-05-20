package com.example.demo.models.portao_embarque;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Portao {
    private String id;
    private String codigo;
    private boolean disponivel = true;
    private boolean ativo = true;

    public Portao(String id, String codigo, boolean disponivel) {
        this.id = id;
        this.codigo = codigo;
        this.disponivel = disponivel;
    }

    public Portao(DadosCadastroPortao dados) {
        this.codigo = dados.codigo();
        this.disponivel = dados.disponivel();
    }

    public Portao() {
        
    }

    public void atualizarPortao(DadosAtualizacaoPortao dados) {
        if (dados.codigo() != null) {
            this.codigo = dados.codigo();
        }
        if (dados.disponivel() != null) {
            this.disponivel = dados.disponivel();
        }
    }

    // Getters e Setters manuais
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public boolean isDisponivel() {
        return disponivel;
    }

    public void setDisponivel(boolean disponivel) {
        this.disponivel = disponivel;
    }

    public boolean isAtivo() {
        return ativo;
    }

    public void setAtivo(boolean ativo) {
        this.ativo = ativo;
    }
}
