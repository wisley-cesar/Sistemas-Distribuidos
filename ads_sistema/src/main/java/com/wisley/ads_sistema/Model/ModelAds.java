package com.wisley.ads_sistema.Model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;
import java.util.function.BinaryOperator;

@Document(collection = "ads")
public class ModelAds {

    @Id
    private String id;
    private String image;
    private UserModel idUser;

    private LocalDateTime creatAt = LocalDateTime.now();
    private StatesModel states;
    private String title;
    private  String description;
    private String category;
    private Boolean priceNegotiable;
    private  int views = 0;

    public ModelAds() {
    }



    public  ModelAds(DadosModelAds dados){
        this.category = dados.category();
        this.creatAt = dados.createdAt();
        this.description = dados.description();
        this.idUser = dados.iduser();
        this.image = dados.image();
        this.states = dados.statesModel();
        this.title = dados.title();
        this.views = dados.views();
        this.priceNegotiable = dados.preciNegoTiable();

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

    public UserModel getIdUser() {
        return idUser;
    }

    public void setIdUser(UserModel idUser) {
        this.idUser = idUser;
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
