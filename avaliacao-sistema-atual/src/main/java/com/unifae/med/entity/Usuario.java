package com.unifae.med.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import java.time.LocalDate;

@Entity
@Table(name = "usuarios")
public class Usuario {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_usuario")
    private Integer idUsuario;
    
    @NotBlank(message = "Nome completo é obrigatório")
    @Size(max = 100, message = "Nome completo deve ter no máximo 100 caracteres")
    @Column(name = "nome_completo", nullable = false, length = 100)
    private String nomeCompleto;
    
    @NotBlank(message = "Email é obrigatório")
    @Email(message = "Email deve ter formato válido")
    @Size(max = 254, message = "Email deve ter no máximo 254 caracteres")
    @Column(name = "email", nullable = false, unique = true, length = 254)
    private String email;
    
    @Size(max = 11, message = "Telefone deve ter no máximo 11 caracteres")
    @Column(name = "telefone", length = 11)
    private String telefone;
    
    @Size(max = 6, message = "Matrícula/RA deve ter no máximo 6 caracteres")
    @Column(name = "matricula_RA", unique = true, length = 6)
    private String matriculaRA;
    
    @NotBlank(message = "Senha é obrigatória")
    @Column(name = "senha_hash", nullable = false)
    private String senhaHash;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "tipo_usuario", nullable = false)
    private TipoUsuario tipoUsuario;
    
    @Column(name = "foto_perfil_path")
    private String fotoPerfilPath;
    
    @Size(max = 2, message = "Período atual deve ter no máximo 2 caracteres")
    @Column(name = "periodo_atual_aluno", length = 2)
    private String periodoAtualAluno;
    
    @Column(name = "observacoes_gerais_aluno", columnDefinition = "TEXT")
    private String observacoesGeraisAluno;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_permissao")
    private Permissao permissao;
    
    @Column(name = "ativo", nullable = false)
    private Boolean ativo = true;
    
    // Construtores
    public Usuario() {}
    
    public Usuario(String nomeCompleto, String email, String senhaHash, TipoUsuario tipoUsuario) {
        this.nomeCompleto = nomeCompleto;
        this.email = email;
        this.senhaHash = senhaHash;
        this.tipoUsuario = tipoUsuario;
        this.ativo = true;
    }
    
    // Getters e Setters
    public Integer getIdUsuario() {
        return idUsuario;
    }
    
    public void setIdUsuario(Integer idUsuario) {
        this.idUsuario = idUsuario;
    }
    
    public String getNomeCompleto() {
        return nomeCompleto;
    }
    
    public void setNomeCompleto(String nomeCompleto) {
        this.nomeCompleto = nomeCompleto;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getTelefone() {
        return telefone;
    }
    
    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }
    
    public String getMatriculaRA() {
        return matriculaRA;
    }
    
    public void setMatriculaRA(String matriculaRA) {
        this.matriculaRA = matriculaRA;
    }
    
    public String getSenhaHash() {
        return senhaHash;
    }
    
    public void setSenhaHash(String senhaHash) {
        this.senhaHash = senhaHash;
    }
    
    public TipoUsuario getTipoUsuario() {
        return tipoUsuario;
    }
    
    public void setTipoUsuario(TipoUsuario tipoUsuario) {
        this.tipoUsuario = tipoUsuario;
    }
    
    public String getFotoPerfilPath() {
        return fotoPerfilPath;
    }
    
    public void setFotoPerfilPath(String fotoPerfilPath) {
        this.fotoPerfilPath = fotoPerfilPath;
    }
    
    public String getPeriodoAtualAluno() {
        return periodoAtualAluno;
    }
    
    public void setPeriodoAtualAluno(String periodoAtualAluno) {
        this.periodoAtualAluno = periodoAtualAluno;
    }
    
    public String getObservacoesGeraisAluno() {
        return observacoesGeraisAluno;
    }
    
    public void setObservacoesGeraisAluno(String observacoesGeraisAluno) {
        this.observacoesGeraisAluno = observacoesGeraisAluno;
    }
    
    public Permissao getPermissao() {
        return permissao;
    }
    
    public void setPermissao(Permissao permissao) {
        this.permissao = permissao;
    }
    
    public Boolean getAtivo() {
        return ativo;
    }
    
    public void setAtivo(Boolean ativo) {
        this.ativo = ativo;
    }
    
    @Override
    public String toString() {
        return "Usuario{" +
                "idUsuario=" + idUsuario +
                ", nomeCompleto='" + nomeCompleto + '\'' +
                ", email='" + email + '\'' +
                ", tipoUsuario=" + tipoUsuario +
                ", ativo=" + ativo +
                '}';
    }
}

