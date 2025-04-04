package com.wisley.ads_sistema.Model.ads;

import java.time.LocalDateTime;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import com.wisley.ads_sistema.Model.states.ListagemStates;
import com.wisley.ads_sistema.Model.states.StatesModel;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
@Document(collection = "ads")
public class ModelAds {

    @Id
    private String id;
    private String image;
    @NotNull
    private String idUser; // Agora apenas uma String
    private LocalDateTime creatAt = LocalDateTime.now();
    private StatesModel states;
    private String title;
    private String description;
    private String category;
    private Boolean priceNegotiable;
    private int views = 0;
    private boolean ativo;
    public ModelAds() {
    }

    public ModelAds(DadosModelAds dados){
        this.category = dados.category();
        this.creatAt = dados.createdAt();
        this.description = dados.description();
        this.idUser = dados.iduser().getId(); // Salvando apenas o ID do usuário
        this.image = dados.image();
        this.states = dados.statesModel();
        this.title = dados.title();
        this.views = dados.views();
        this.priceNegotiable = dados.preciNegoTiable();
    }

    public void atualizarInformacoesAds(DadadosAtualizacaoAds dadadosAtualizacaoAds){
        if (dadadosAtualizacaoAds.title() != null){
            this.title = dadadosAtualizacaoAds.title();
        }
        if (dadadosAtualizacaoAds.description() != null){
            this.description = dadadosAtualizacaoAds.description();
        }   
        if (dadadosAtualizacaoAds.category() != null) {
            this.category = dadadosAtualizacaoAds.category();
        }
        if (dadadosAtualizacaoAds.image() != null) {
            this.image = dadadosAtualizacaoAds.image();
        }
        if (dadadosAtualizacaoAds.states() != null) {
            this.states.atualizarInformacoesStates(dadadosAtualizacaoAds.states());
        }

    }


    public void excluir() {
        this.ativo = false;
    }


    
}
// Compare this snippet from src/main/java/com/wisley/ads_sistema/Model/DadosCadastroStates.java: