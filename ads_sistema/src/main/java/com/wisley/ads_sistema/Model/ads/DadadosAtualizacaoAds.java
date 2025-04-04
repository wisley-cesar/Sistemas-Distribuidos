package com.wisley.ads_sistema.Model.ads;

import com.mongodb.lang.NonNull;
import com.wisley.ads_sistema.Model.states.StatesModel;

public record DadadosAtualizacaoAds(
    @NonNull       
        String id,
        String title,
        String description,
        String category,
        String userName,
        String email,
        String image,
        StatesModel states
) {
    

}
