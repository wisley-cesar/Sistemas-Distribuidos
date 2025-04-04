package com.wisley.ads_sistema.Model.user;

import org.springframework.data.annotation.Id;

public record DadosUserAtualizacao(
        @Id        
        String id,
        String userName,
        String email
) {
    
}
