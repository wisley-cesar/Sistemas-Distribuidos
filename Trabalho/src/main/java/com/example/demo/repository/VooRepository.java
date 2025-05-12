package com.example.demo.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.repository.MongoRepository;

import com.example.demo.models.voo.Voo;

public interface VooRepository extends MongoRepository<Voo, String> {

    Page<Voo> findAllByAtivoTrue(Pageable paginacao);


    
}