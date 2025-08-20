package com.unifae.med.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "turmas")
public class Turma {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_turma")
    private Integer idTurma;
    
    @NotBlank(message = "Nome da turma é obrigatório")
    @Size(max = 255, message = "Nome da turma deve ter no máximo 255 caracteres")
    @Column(name = "nome_turma", nullable = false, length = 255)
    private String nomeTurma;
    
    @Size(max = 50, message = "Código da turma deve ter no máximo 50 caracteres")
    @Column(name = "codigo_turma", unique = true, length = 50)
    private String codigoTurma;
    
    // Construtores
    public Turma() {}
    
    public Turma(String nomeTurma, String codigoTurma) {
        this.nomeTurma = nomeTurma;
        this.codigoTurma = codigoTurma;
    }
    
    // Getters e Setters
    public Integer getIdTurma() {
        return idTurma;
    }
    
    public void setIdTurma(Integer idTurma) {
        this.idTurma = idTurma;
    }
    
    public String getNomeTurma() {
        return nomeTurma;
    }
    
    public void setNomeTurma(String nomeTurma) {
        this.nomeTurma = nomeTurma;
    }
    
    public String getCodigoTurma() {
        return codigoTurma;
    }
    
    public void setCodigoTurma(String codigoTurma) {
        this.codigoTurma = codigoTurma;
    }
    
    @Override
    public String toString() {
        return "Turma{" +
                "idTurma=" + idTurma +
                ", nomeTurma='" + nomeTurma + '\'' +
                ", codigoTurma='" + codigoTurma + '\'' +
                '}';
    }
}

