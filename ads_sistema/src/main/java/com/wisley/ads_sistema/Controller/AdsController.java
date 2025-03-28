package com.wisley.ads_sistema.Controller;

import com.wisley.ads_sistema.Model.DadosModelAds;
import com.wisley.ads_sistema.Model.DadosModelAdsListagem;
import com.wisley.ads_sistema.Model.ModelAds;
import com.wisley.ads_sistema.Repository.AdsRepository;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("ads")
public class AdsController {
    @Autowired
    private AdsRepository adsRepository;


    @PostMapping
    @Transactional
    public void cadastrar(@RequestBody @Valid DadosModelAds dadosModelAds){
        ModelAds ads = new ModelAds(dadosModelAds);
        adsRepository.save(ads);
    }

    @GetMapping
    public List<ModelAds> listar(){
        return  adsRepository.findAll();
    }



}