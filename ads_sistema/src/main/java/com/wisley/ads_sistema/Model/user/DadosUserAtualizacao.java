package com.wisley.ads_sistema.Model.user;

import org.springframework.data.annotation.Id;

import com.wisley.ads_sistema.Model.ads.DadosModelAdsListagem;
import com.wisley.ads_sistema.Model.category.DadosCategory;
import com.wisley.ads_sistema.Model.states.DadosCadastroStates;

public record DadosUserAtualizacao(
        @Id        
        String id,
        String userName,
        DadosModelAdsListagem ads,
        String email,
        DadosCadastroStates states,
        DadosCategory category

) {
    
}
