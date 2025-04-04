package com.wisley.ads_sistema.Model.user;

import org.springframework.data.annotation.Id;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public record DadosUser(
        @Id
        String id,
        @NotBlank(message = "O nome de usuário é obrigatório")
        String userName,
        @NotBlank(message = "O emeil é obrigatorio")
        @Email(message = "Formato de e-mail inválido")
        String email,
        @NotBlank(message = "A senha é obrigatorio")
        @Size(min = 8, message = "A senha deve ter no minimo 8 carateres")
        String password,

        @NotBlank(message = "O endereço é obrigatório")
        String address,

        String token,
        
        @NotNull(message = "O ativo é obrigatorio")
        boolean ativo
){

}
