package com.example.demo.dto.passageiro;

import lombok.Data;

@Data
public class PassageiroResponseDTO {
    private Long id;
    private String nome;
    private String email;
    private String cpf;
    private String telefone;
    private String token;
} 