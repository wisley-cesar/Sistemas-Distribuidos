package com.wisley.ads_sistema.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.wisley.ads_sistema.Model.user.DadosUser;
import com.wisley.ads_sistema.Model.user.DadosUserAtualizacao;
import com.wisley.ads_sistema.Model.user.UserModel;
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
   public List<UserModel> listar(){
        return userRepository.findAll();
   }


   @PutMapping
   @Transactional
   public void atualizarInformacoesUser(@RequestBody @Valid DadosUserAtualizacao dadosUser) {
        UserModel userModel = userRepository.findById(dadosUser.id()).orElseThrow(() -> new RuntimeException("Id não encontrado"));
        userModel.atualizarInformacoesUser(dadosUser);
        userRepository.save(userModel);
    }
}
