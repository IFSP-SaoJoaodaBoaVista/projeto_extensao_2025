package com.unifae.med.dao;

import com.unifae.med.entity.Turma;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import java.util.List;
import java.util.Optional;

/**
 * TURMADAO - DATA ACCESS OBJECT PARA A ENTIDADE TURMA
 * ===================================================
 * * Especializa o GenericDAO para a entidade Turma.
 * Implementa consultas específicas para buscar turmas por nome, código ou ano letivo.
 * * @author Sistema de Avaliação UNIFAE
 * @version 1.0
 */
public class TurmaDAO extends GenericDAO<Turma, Integer> {

    /**
     * Construtor padrão que define a classe da entidade para o GenericDAO.
     */
    public TurmaDAO() {
        super(Turma.class);
    }

    /**
     * Busca turmas cujo nome contenha o termo pesquisado.
     * A busca é case-insensitive.
     *
     * @param nomeTurma Parte do nome da turma a ser buscada.
     * @return Uma lista de turmas que correspondem ao critério.
     */
    public List<Turma> findByNomeContaining(String nomeTurma) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT t FROM Turma t WHERE LOWER(t.nomeTurma) LIKE LOWER(:nomeTurma) ORDER BY t.nomeTurma";
            TypedQuery<Turma> query = em.createQuery(jpql, Turma.class);
            query.setParameter("nomeTurma", "%" + nomeTurma + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Busca uma turma pelo seu código exato.
     * O código da turma é um identificador único.
     *
     * @param codigoTurma O código exato da turma.
     * @return Um Optional contendo a turma se encontrada.
     */
    public Optional<Turma> findByCodigo(String codigoTurma) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT t FROM Turma t WHERE t.codigoTurma = :codigoTurma";
            TypedQuery<Turma> query = em.createQuery(jpql, Turma.class);
            query.setParameter("codigoTurma", codigoTurma);
            return Optional.of(query.getSingleResult());
        } catch (NoResultException e) {
            return Optional.empty();
        } finally {
            em.close();
        }
    }
}
