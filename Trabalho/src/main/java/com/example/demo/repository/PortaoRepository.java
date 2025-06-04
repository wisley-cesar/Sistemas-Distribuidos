package com.example.demo.repository;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.repository.MongoRepository;

import com.example.demo.models.portao_embarque.Portao;

public interface PortaoRepository extends MongoRepository<Portao, String> {
    Page<Portao> findAllByAtivoTrue(Pageable paginacao);
    Optional<Portao> findByCodigo(String codigo);
}
