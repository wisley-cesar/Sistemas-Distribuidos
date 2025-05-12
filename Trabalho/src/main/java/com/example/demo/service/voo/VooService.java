package com.example.demo.service.voo;
import com.example.demo.models.voo.StatusVoo;
import com.example.demo.models.voo.Voo;
import com.example.demo.repository.VooRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class VooService {

    @Autowired
    private VooRepository vooRepository;

    // Atualiza o status do voo
    public void atualizarStatusVoo(String idVoo, StatusVoo novoStatus) {
        // Buscar o voo pelo ID
        Voo voo = vooRepository.findById(idVoo)
            .orElseThrow(() -> new RuntimeException("Voo não encontrado"));

        // Atualizar o status do voo
        voo.setStatus(novoStatus);

        // Salvar as alterações no banco
        vooRepository.save(voo);
    }
}
