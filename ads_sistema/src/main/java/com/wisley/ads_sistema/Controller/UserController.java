package com.wisley.ads_sistema.Controller;

import com.wisley.ads_sistema.Model.DadosUser;
import com.wisley.ads_sistema.Model.UserModel;
import com.wisley.ads_sistema.Repository.UserRepository;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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
}
