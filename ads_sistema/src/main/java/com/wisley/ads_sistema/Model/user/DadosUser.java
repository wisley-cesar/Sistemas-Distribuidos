package com.wisley.ads_sistema.Model.user;

import org.springframework.data.annotation.Id;

import com.wisley.ads_sistema.Model.ads.DadosModelAdsListagem;
import com.wisley.ads_sistema.Model.category.DadosCategory;
import com.wisley.ads_sistema.Model.states.ListagemStates;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public record DadosUser(
        @Id
        String id,

        @NotBlank(message = "O nome de usuário é obrigatório")
        String userName,

        @NotBlank(message = "O e-mail é obrigatório")
        @Email(message = "Formato de e-mail inválido")
        String email,

        @NotBlank(message = "A senha é obrigatória")
        @Size(min = 8, message = "A senha deve ter no mínimo 8 caracteres")
        String password,

        @NotBlank(message = "O endereço é obrigatório")
        String address,

        String token,

        @NotNull(message = "O estado é obrigatório")
        ListagemStates states,

        @NotNull(message = "A categoria é obrigatória")
        DadosCategory category,

        @NotNull(message = "O ativo é obrigatório")
        boolean ativo,

        DadosModelAdsListagem ads
) {}
