package com.wisley.ads_sistema.Model.user;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import com.wisley.ads_sistema.Model.ads.DadosModelAdsListagem;
import com.wisley.ads_sistema.Model.category.DadosCategory;
import com.wisley.ads_sistema.Model.states.StatesModel;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Document(collection = "User")
public class UserModel {
    @Id
    private String id;
    private String userName;
    private String email;
    private String password;
    private String token;
    private boolean ativo; 
    private StatesModel states;  // Usando StatesModel no lugar de DadosCadastroStates
    private DadosCategory category;
    private DadosModelAdsListagem ads;

    public UserModel() {}

    // Construtor que agora converte DadosCadastroStates para StatesModel
    public UserModel(DadosUser dadosUser) {
        this.ativo = true;
        this.email = dadosUser.email();
        this.id = dadosUser.id();
        this.password = dadosUser.password();
        this.token = dadosUser.token();
        this.userName = dadosUser.userName();
        this.category = dadosUser.category();
        this.states = new StatesModel(dadosUser.states()); // Conversão para StatesModel
        this.ads = dadosUser.ads();
    }
    
    public UserModel(DadosUserAtualizacao dadosUserAtualizacao) {
        this.id = dadosUserAtualizacao.id();
        this.userName = dadosUserAtualizacao.userName();
        this.email = dadosUserAtualizacao.email();
        this.states = new StatesModel(dadosUserAtualizacao.states()); // Conversão para StatesModel
        this.category = dadosUserAtualizacao.category();
        this.ads = dadosUserAtualizacao.ads();
    }

    public void atualizarInformacoesUser(DadosUserAtualizacao dadosUser) {
        if (dadosUser.userName() != null) {
            this.userName = dadosUser.userName();
        }
        if (dadosUser.email() != null) {
            this.email = dadosUser.email();
        }
        if (dadosUser.states() != null) {
            this.states = new StatesModel(dadosUser.states()); // Conversão para StatesModel
        }
        if (dadosUser.category() != null) {
            this.category = dadosUser.category();
        }
        if (dadosUser.ads() != null) {
            this.ads = dadosUser.ads();
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
