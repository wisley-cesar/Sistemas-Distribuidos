package com.wisley.ads_sistema.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.wisley.ads_sistema.Model.user.DadosUser;
import com.wisley.ads_sistema.Model.user.DadosUserAtualizacao;
import com.wisley.ads_sistema.Model.user.UserModel;
import com.wisley.ads_sistema.Model.user.UserModelListagem;
import com.wisley.ads_sistema.Repository.UserRepository;

import jakarta.validation.Valid;

@RestController
@RequestMapping("user")
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @Transactional
    @PostMapping
    public  void cadastrar(@RequestBody @Valid DadosUser dadosUser){
        UserModel userModel = new UserModel(dadosUser);
        userRepository.save(userModel);
    }


    @GetMapping
    public Page<UserModelListagem> listar(Pageable pageable){
        return userRepository.findAllByAtivoTrue(pageable).map(UserModelListagem::new);
    }


   @PutMapping
   @Transactional
   public void atualizarInformacoesUser(@RequestBody @Valid DadosUserAtualizacao dadosUser) {
        UserModel userModel = userRepository.findById(dadosUser.id()).orElseThrow(() -> new RuntimeException("Id não encontrado"));
        userModel.atualizarInformacoesUser(dadosUser);
        userRepository.save(userModel);
    }

    @DeleteMapping("/{id}")
    public void deletar( @PathVariable String id){
        UserModel userModel = userRepository.findById(id).orElseThrow(() -> new RuntimeException("Id não encontrado"));
        userModel.excluir();
        userRepository.save(userModel);
    }
    
}
