package com.example.demo.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;  
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.models.passageiro.Passageiro;

@Repository
public interface PassageiroRepository extends MongoRepository<Passageiro, String> {
    Page<Passageiro> findAllByAtivoTrue(Pageable paginacao);
}
