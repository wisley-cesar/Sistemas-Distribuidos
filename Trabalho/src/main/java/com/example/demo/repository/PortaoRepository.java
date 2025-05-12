package com.example.demo.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.repository.MongoRepository;

import com.example.demo.models.passageiro.Passageiro;
import com.example.demo.models.portao_embarque.Portao;

public interface PortaoRepository extends MongoRepository<Portao, String> {
    Page<Passageiro> findAllByAtivoTrue(Pageable paginacao);

    
}
