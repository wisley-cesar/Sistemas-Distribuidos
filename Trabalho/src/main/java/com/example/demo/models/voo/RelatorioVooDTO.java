package com.example.demo.models.voo;

import java.util.List;
import com.example.demo.models.voo.StatusVoo;
import com.example.demo.models.passageiro.RelatorioPassageiroDTO;

public record RelatorioVooDTO(
    Integer numeroVoo,
    String origem,
    String destino,
    String dataHoraPartida,
    StatusVoo status,
    String portao,
    List<RelatorioPassageiroDTO> passageiros
) {} 