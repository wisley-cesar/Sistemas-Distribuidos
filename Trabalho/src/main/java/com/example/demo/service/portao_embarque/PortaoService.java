package com.example.demo.service.portao_embarque;

import com.example.demo.models.portao_embarque.DadosCadastroPortao;
import com.example.demo.models.portao_embarque.Portao;
import com.example.demo.repository.PortaoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PortaoService {

    private final PortaoRepository portaoRepository;

    @Autowired
    public PortaoService(PortaoRepository portaoRepository) {
        this.portaoRepository = portaoRepository;
    }

    public Portao cadastrarPortao(DadosCadastroPortao dados) {
        // Validação: código de portão deve ser único
        if (portaoRepository.findByCodigo(dados.codigo()).isPresent()) {
            throw new RuntimeException("Já existe um portão com este código.");
        }
        Portao portao = new Portao(null, dados.codigo(), dados.disponivel());
        return portaoRepository.save(portao);
    }
} 