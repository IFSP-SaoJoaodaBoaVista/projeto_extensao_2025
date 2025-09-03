package com.unifae.med.dao;

import com.unifae.med.entity.Permissao;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import java.util.Optional;

/**
 * PERMISSAODAO - DATA ACCESS OBJECT PARA A ENTIDADE PERMISSAO
 * ============================================================
 * * Especializa o GenericDAO para a entidade Permissao.
 * Implementa consultas específicas para buscar permissões por nome.
 * * @author Sistema de Avaliação UNIFAE
 * @version 1.0
 */
public class PermissaoDAO extends GenericDAO<Permissao, Integer> {

    /**
     * Construtor padrão que define a classe da entidade para o GenericDAO.
     */
    public PermissaoDAO() {
        super(Permissao.class);
    }

    /**
     * Busca uma permissão pelo seu nome exato.
     * Como o nome da permissão é único, este método retorna um único resultado.
     *
     * @param nomePermissao O nome da permissão a ser buscada.
     * @return Um Optional contendo a permissão se encontrada, caso contrário, um Optional vazio.
     * @throws RuntimeException se ocorrer um erro durante a consulta.
     */
    public Optional<Permissao> findByNome(String nomePermissao) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT p FROM Permissao p WHERE p.nomePermissao = :nomePermissao";
            TypedQuery<Permissao> query = em.createQuery(jpql, Permissao.class);
            query.setParameter("nomePermissao", nomePermissao);
            return Optional.of(query.getSingleResult());
        } catch (NoResultException e) {
            // Retorna vazio se nenhuma permissão for encontrada, o que é um resultado esperado.
            return Optional.empty();
        } catch (Exception e) {
            // Lança uma exceção para outros erros inesperados do banco de dados.
            throw new RuntimeException("Erro ao buscar permissão por nome: " + e.getMessage(), e);
        } finally {
            // Garante que o EntityManager seja sempre fechado.
            em.close();
        }
    }
}
