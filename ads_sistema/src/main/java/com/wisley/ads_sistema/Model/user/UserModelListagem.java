package com.wisley.ads_sistema.Model.user;

import com.wisley.ads_sistema.Model.states.ListagemStates;
import com.wisley.ads_sistema.Model.ads.DadosModelAdsListagem;
import com.wisley.ads_sistema.Model.category.DadosCategory;
public record UserModelListagem(
    String id,
    String userName,
    String email,
    String password,
    String token,
    boolean ativo,
    ListagemStates states,
    DadosCategory category, 
    DadosModelAdsListagem ads
) {
    public UserModelListagem(UserModel userModel) {
        this(
            userModel.getId(), 
            userModel.getUserName(), 
            userModel.getEmail(), 
            userModel.getPassword(), 
            userModel.getToken(), 
            userModel.isAtivo(), 
            userModel.getStates(),
            userModel.getCategory(),
            userModel.getAds()
        );
    }
}



