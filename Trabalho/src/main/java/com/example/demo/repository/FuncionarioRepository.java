package com.example.demo.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.models.funcionario.Funcionario;

@Repository
public interface FuncionarioRepository extends MongoRepository<Funcionario, String> {
    boolean existsByEmail(String email);
    Funcionario findByEmail(String email);
} 