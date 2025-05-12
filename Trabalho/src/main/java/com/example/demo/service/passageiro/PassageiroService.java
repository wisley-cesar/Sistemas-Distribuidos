package com.example.demo.service.passageiro;
import org.springframework.stereotype.Service;
import com.example.demo.models.passageiro.Passageiro;
import com.example.demo.models.passageiro.StatusCheckIn;
import com.example.demo.repository.PassageiroRepository;
@Service
public class PassageiroService {

    private final PassageiroRepository passageiroRepository;

    public PassageiroService(PassageiroRepository passageiroRepository) {
        this.passageiroRepository = passageiroRepository;
    }

    public Passageiro atualizarStatusCheckIn(String idPassageiro, StatusCheckIn novoStatus) {
        Passageiro passageiro = passageiroRepository.findById(idPassageiro)
            .orElseThrow(() -> new RuntimeException("Passageiro não encontrado"));

        passageiro.setStatusCheckIn(novoStatus);
        return passageiroRepository.save(passageiro);
    }
}
