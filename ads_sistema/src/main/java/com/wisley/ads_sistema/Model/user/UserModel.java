package com.wisley.ads_sistema.Model.user;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Document(collection = "User")
public class UserModel {
    @Id
    private  String id;
    private String userName;

    private String email;

    private String password;

    private String token;

    private boolean ativo; 

    public UserModel() {
    }

    public UserModel(DadosUser dadosUser) {
        this.ativo = true;
        this.email = dadosUser.email();
        this.id = dadosUser.id();
        this.password = dadosUser.password();
        this.token = dadosUser.token();
        this.userName = dadosUser.userName();
    }
    
    public UserModel(DadosUserAtualizacao dadosUserAtualizacao) {
        this.id = dadosUserAtualizacao.id();
        this.userName = dadosUserAtualizacao.userName();
        this.email = dadosUserAtualizacao.email();
    }


    public void atualizarInformacoesUser(DadosUserAtualizacao dadosUser) {
        if (dadosUser.userName() != null) {
            this.userName = dadosUser.userName();
        }
        if (dadosUser.email() != null) {
            this.email = dadosUser.email();
        }
         
    }

    public void excluir() {
        this.ativo = false;
      
    }
    public boolean isAtivo() {
        return ativo;
    }
    public void setAtivo(boolean ativo) {
        this.ativo = ativo;
    }
    

}
