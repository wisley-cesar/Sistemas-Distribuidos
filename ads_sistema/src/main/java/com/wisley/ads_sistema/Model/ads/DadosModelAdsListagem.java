package com.wisley.ads_sistema.Model.ads;

import java.time.LocalDateTime;

import org.springframework.data.annotation.Id;

import com.wisley.ads_sistema.Model.states.StatesModel;


public record DadosModelAdsListagem(
        @Id
     String id,
     String image,
     String idUser, // Agora apenas uma String
     LocalDateTime creatAt,
     StatesModel states,
     String title,
     String description,
     String category,
     Boolean priceNegotiable,
     int views,
     boolean ativo
) {
    public DadosModelAdsListagem(ModelAds dados) {
        this(dados.getId(), dados.getImage(), dados.getIdUser(), dados.getCreatAt(), dados.getStates(),
                dados.getTitle(), dados.getDescription(), dados.getCategory(), dados.getPriceNegotiable(),dados.getViews(), dados.isAtivo());
    }
}
