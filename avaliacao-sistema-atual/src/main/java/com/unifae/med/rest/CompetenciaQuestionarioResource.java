/**
 * =================================================================================================
 * ENTENDIMENTO DO CÓDIGO
 * =================================================================================================
 * Esta classe, `CompetenciaQuestionarioResource`, é um recurso JAX-RS que define os
 * endpoints de uma API REST para gerenciar "Competências de Questionário". Uma "competência"
 * neste contexto representa um item, uma pergunta ou um critério a ser avaliado dentro de
 * um questionário.
 *
 * A classe implementa um CRUD (Criar, Ler, Atualizar, Deletar) completo para as competências,
 * seguindo as melhores práticas de design de APIs RESTful:
 * 1.  **Camada de API (@Path):** Define o caminho base "/competencias" e utiliza os verbos
 * HTTP (GET, POST, PUT, DELETE) para mapear as operações. A comunicação é feita em JSON.
 * 2.  **Camada de Acesso a Dados (DAO):** Interage com o banco de dados através do
 * `CompetenciaQuestionarioDAO` para realizar as operações de persistência.
 * 3.  **Camada de Transferência de Dados (DTO):** Utiliza o `CompetenciaQuestionarioDTO`
 * para expor os dados na API, garantindo que o modelo interno da entidade
 * (`CompetenciaQuestionario`) seja desacoplado da representação externa, o que é
 * fundamental para a segurança e flexibilidade do sistema.
 * =================================================================================================
 */
package com.unifae.med.rest;

import com.unifae.med.dao.CompetenciaQuestionarioDAO;
import com.unifae.med.entity.CompetenciaQuestionario;
import com.unifae.med.rest.dto.CompetenciaQuestionarioDTO;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.util.List;
import java.util.stream.Collectors;

/**
 * Define o caminho base para todos os endpoints desta classe como
 * "/competencias". Especifica que, por padrão, todos os métodos produzirão
 * respostas em formato JSON. Especifica que, por padrão, todos os métodos
 * consumirão dados em formato JSON.
 */
@Path("/competencias")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class CompetenciaQuestionarioResource {

    // Instância do DAO para interagir com a tabela de competências no banco de dados.
    private final CompetenciaQuestionarioDAO competenciaDAO = new CompetenciaQuestionarioDAO();

    /**
     * Endpoint para listar todas as competências de questionários. Mapeado
     * para: GET /competencias
     *
     * @return Uma lista de CompetenciaQuestionarioDTO.
     */
    @GET
    public List<CompetenciaQuestionarioDTO> getAllCompetencias() {
        return competenciaDAO.findAll().stream()
                .map(this::toDTO) // Converte cada entidade para seu DTO correspondente
                .collect(Collectors.toList());
    }

    /**
     * Endpoint para buscar uma competência pelo seu ID. Mapeado para: GET
     * /competencias/{id}
     *
     * @param id O ID da competência a ser buscada, vindo da URL.
     * @return Uma Resposta HTTP. 200 OK com o DTO se encontrado, 404 Not Found
     * caso contrário.
     */
    @GET
    @Path("/{id}")
    public Response getCompetenciaById(@PathParam("id") Integer id) {
        return competenciaDAO.findById(id)
                .map(this::toDTO)
                .map(dto -> Response.ok(dto).build())
                .orElse(Response.status(Response.Status.NOT_FOUND).build());
    }

    /**
     * Endpoint para criar uma nova competência. Mapeado para: POST
     * /competencias
     *
     * @param competencia A entidade CompetenciaQuestionario recebida no corpo
     * da requisição.
     * @return Uma Resposta HTTP 201 Created com o DTO da competência
     * recém-criada.
     */
    @POST
    public Response createCompetencia(CompetenciaQuestionario competencia) {
        CompetenciaQuestionario novaCompetencia = competenciaDAO.save(competencia);
        return Response.status(Response.Status.CREATED).entity(toDTO(novaCompetencia)).build();
    }

    /**
     * Endpoint para atualizar uma competência existente. Mapeado para: PUT
     * /competencias/{id}
     *
     * @param id O ID da competência a ser atualizada.
     * @param competencia Os dados atualizados da competência.
     * @return Uma Resposta HTTP. 200 OK com o DTO atualizado se bem-sucedido,
     * 400 Bad Request se os IDs não coincidirem.
     */
    @PUT
    @Path("/{id}")
    public Response updateCompetencia(@PathParam("id") Integer id, CompetenciaQuestionario competencia) {
        // Validação para garantir consistência entre o ID da URL e o do corpo da requisição.
        if (!id.equals(competencia.getIdCompetenciaQuestionario())) {
            return Response.status(Response.Status.BAD_REQUEST).entity("ID da competência no corpo não corresponde ao ID na URL").build();
        }
        CompetenciaQuestionario competenciaAtualizada = competenciaDAO.save(competencia);
        return Response.ok(toDTO(competenciaAtualizada)).build();
    }

    /**
     * Endpoint para deletar uma competência. Mapeado para: DELETE
     * /competencias/{id}
     *
     * @param id O ID da competência a ser deletada.
     * @return Uma Resposta HTTP 204 No Content, indicando sucesso na remoção.
     */
    @DELETE
    @Path("/{id}")
    public Response deleteCompetencia(@PathParam("id") Integer id) {
        competenciaDAO.deleteById(id);
        return Response.noContent().build();
    }

    /**
     * Método utilitário privado que converte uma entidade
     * CompetenciaQuestionario em seu DTO. Este método centraliza a lógica de
     * mapeamento, promovendo o desacoplamento e a reutilização de código.
     *
     * @param competencia A entidade JPA a ser convertida.
     * @return O DTO correspondente preenchido.
     */
    private CompetenciaQuestionarioDTO toDTO(CompetenciaQuestionario competencia) {
        // Utiliza o construtor do DTO para uma conversão mais limpa e direta.
        return new CompetenciaQuestionarioDTO(
                competencia.getIdCompetenciaQuestionario(),
                competencia.getNomeCompetencia(),
                competencia.getTipoItem(),
                competencia.getDescricaoPrompt(),
                // Verifica se o questionário associado não é nulo antes de obter seu ID.
                competencia.getQuestionario() != null ? competencia.getQuestionario().getIdQuestionario() : null
        );
    }
}
