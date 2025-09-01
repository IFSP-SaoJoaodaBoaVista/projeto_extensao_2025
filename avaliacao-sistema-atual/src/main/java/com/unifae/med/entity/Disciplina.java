package com.unifae.med.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "disciplinas")
public class Disciplina {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_disciplina")
    private Integer idDisciplina;

    @NotBlank(message = "Nome da disciplina é obrigatório")
    @Size(max = 255, message = "Nome da disciplina deve ter no máximo 255 caracteres")
    @Column(name = "nome_disciplina", nullable = false, unique = true, length = 255)
    private String nomeDisciplina;

    @Size(max = 10, message = "Sigla da disciplina deve ter no máximo 10 caracteres")
    @Column(name = "sigla_disciplina", unique = true, length = 10)
    private String siglaDisciplina;

    @Column(name = "ativa", nullable = false)
    private Boolean ativa = true;

    // Construtores
    public Disciplina() {
    }

    public Disciplina(String nomeDisciplina, String siglaDisciplina) {
        this.nomeDisciplina = nomeDisciplina;
        this.siglaDisciplina = siglaDisciplina;
        this.ativa = true;
    }

    // Getters e Setters
    public Integer getIdDisciplina() {
        return idDisciplina;
    }

    public void setIdDisciplina(Integer idDisciplina) {
        this.idDisciplina = idDisciplina;
    }

    public String getNomeDisciplina() {
        return nomeDisciplina;
    }

    public void setNomeDisciplina(String nomeDisciplina) {
        this.nomeDisciplina = nomeDisciplina;
    }

    public String getSiglaDisciplina() {
        return siglaDisciplina;
    }

    public void setSiglaDisciplina(String siglaDisciplina) {
        this.siglaDisciplina = siglaDisciplina;
    }

    public Boolean getAtiva() {
        return ativa;
    }

    public void setAtiva(Boolean ativa) {
        this.ativa = ativa;
    }

    @Override
    public String toString() {
        return "Disciplina{"
                + "idDisciplina=" + idDisciplina
                + ", nomeDisciplina='" + nomeDisciplina + '\''
                + ", siglaDisciplina='" + siglaDisciplina + '\''
                + ", ativa=" + ativa
                + '}';
    }
}
