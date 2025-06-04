package com.example.demo.service.funcionario;

import java.util.List;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.demo.models.funcionario.DadosCadastroFuncionario;
import com.example.demo.models.funcionario.Funcionario;
import com.example.demo.repository.FuncionarioRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class FuncionarioService implements UserDetailsService {
    
    private final FuncionarioRepository funcionarioRepository;
    
    public Funcionario cadastrarFuncionario(DadosCadastroFuncionario dados) {
        log.info("Iniciando cadastro de funcionário com email: {}", dados.email());
        
        // Validação de email
        if (!isValidEmail(dados.email())) {
            log.error("Email inválido: {}", dados.email());
            throw new RuntimeException("Email inválido");
        }
        
        if (funcionarioRepository.existsByEmail(dados.email())) {
            log.error("Email já cadastrado: {}", dados.email());
            throw new RuntimeException("Email já cadastrado");
        }
        
        Funcionario funcionario = new Funcionario();
        funcionario.setNome(dados.nome());
        funcionario.setEmail(dados.email());
        funcionario.setSenha(dados.senha());
        funcionario.setCargo(dados.cargo());
        
        Funcionario saved = funcionarioRepository.save(funcionario);
        log.info("Funcionário cadastrado com sucesso. ID: {}", saved.getId());
        return saved;
    }

    private boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        return email != null && email.matches(emailRegex);
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        log.info("Tentando carregar usuário pelo email: {}", email);
        Funcionario funcionario = funcionarioRepository.findByEmail(email);
        if (funcionario == null) {
            log.error("Funcionário não encontrado com o email: {}", email);
            throw new UsernameNotFoundException("Funcionário não encontrado com o email: " + email);
        }
        log.info("Funcionário encontrado: {}", funcionario.getNome());
        return funcionario;
    }

    public Funcionario loadUserById(String id) {
        log.info("Tentando carregar usuário pelo ID: {}", id);
        Funcionario funcionario = funcionarioRepository.findById(id)
            .orElseThrow(() -> new UsernameNotFoundException("Funcionário não encontrado com o id: " + id));
        log.info("Funcionário encontrado: {}", funcionario.getNome());
        return funcionario;
    }

    public List<Funcionario> listarTodos() {
        return funcionarioRepository.findAll();
    }

    public Funcionario atualizarFuncionario(String id, DadosCadastroFuncionario dados) {
        log.info("Atualizando funcionário com ID: {}", id);
        Funcionario funcionario = loadUserById(id);
        
        // Se o email foi alterado, verificar se já existe
        if (!funcionario.getEmail().equals(dados.email()) && funcionarioRepository.existsByEmail(dados.email())) {
            throw new RuntimeException("Email já cadastrado");
        }
        
        funcionario.setNome(dados.nome());
        funcionario.setEmail(dados.email());
        if (dados.senha() != null && !dados.senha().isEmpty()) {
            funcionario.setSenha(dados.senha());
        }
        funcionario.setCargo(dados.cargo());
        
        Funcionario updated = funcionarioRepository.save(funcionario);
        log.info("Funcionário atualizado com sucesso. ID: {}", updated.getId());
        return updated;
    }

    public void deletarFuncionario(String id) {
        log.info("Deletando funcionário com ID: {}", id);
        Funcionario funcionario = loadUserById(id);
        funcionarioRepository.delete(funcionario);
        log.info("Funcionário deletado com sucesso. ID: {}", id);
    }
} 