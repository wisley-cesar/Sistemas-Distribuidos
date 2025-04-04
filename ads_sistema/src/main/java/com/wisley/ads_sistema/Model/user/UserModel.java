package com.wisley.ads_sistema.Model.user;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "User")
public class UserModel {
    @Id
    private  String id;
    private String userName;

    private String email;

    private String password;

    private String token;

    public UserModel() {
    }

    public UserModel(DadosUser dadosUser) {
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void atualizarInformacoesUser(DadosUserAtualizacao dadosUser) {
        if (dadosUser.userName() != null) {
            this.userName = dadosUser.userName();
        }
        if (dadosUser.email() != null) {
            this.email = dadosUser.email();
        }
       
        
    }
    

}
