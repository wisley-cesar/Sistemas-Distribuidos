package com.wisley.ads_sistema.Model.ads;

import java.time.LocalDateTime;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import com.wisley.ads_sistema.Model.states.StatesModel;

import jakarta.validation.constraints.NotNull;

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

    // Getters e Setters

    public String getIdUser() {
        return idUser;
    }

    public void setIdUser(String idUser) {
        this.idUser = idUser;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public LocalDateTime getCreatAt() {
        return creatAt;
    }

    public void setCreatAt(LocalDateTime creatAt) {
        this.creatAt = creatAt;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Boolean getPriceNegotiable() {
        return priceNegotiable;
    }

    public void setPriceNegotiable(Boolean priceNegotiable) {
        this.priceNegotiable = priceNegotiable;
    }

    public StatesModel getStates() {
        return states;
    }

    public void setStates(StatesModel states) {
        this.states = states;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }
}
// Compare this snippet from src/main/java/com/wisley/ads_sistema/Model/DadosCadastroStates.java: