<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- Função para buscar valor da resposta por nome da competência --%>
<c:set var="respostaEntrevistaMedica" value="0" />
<c:set var="respostaExameFisico" value="0" />
<c:set var="respostaProfissionalismo" value="0" />
<c:set var="respostaJulgamentoClinico" value="0" />
<c:set var="respostaComunicacao" value="0" />
<c:set var="respostaOrganizacao" value="0" />
<c:set var="respostaAvaliacaoGeral" value="0" />

<c:if test="${respostas != null}">
    <c:forEach var="resposta" items="${respostas}">
        <c:choose>
            <c:when test="${fn:contains(fn:toLowerCase(resposta.competenciaQuestionario.nomeCompetencia), 'entrevista')}">
                <c:set var="respostaEntrevistaMedica" value="${resposta.respostaValorNumerico.intValue()}" />
            </c:when>
            <c:when test="${fn:contains(fn:toLowerCase(resposta.competenciaQuestionario.nomeCompetencia), 'exame')}">
                <c:set var="respostaExameFisico" value="${resposta.respostaValorNumerico.intValue()}" />
            </c:when>
            <c:when test="${fn:contains(fn:toLowerCase(resposta.competenciaQuestionario.nomeCompetencia), 'profissional')}">
                <c:set var="respostaProfissionalismo" value="${resposta.respostaValorNumerico.intValue()}" />
            </c:when>
            <c:when test="${fn:contains(fn:toLowerCase(resposta.competenciaQuestionario.nomeCompetencia), 'julgamento') || fn:contains(fn:toLowerCase(resposta.competenciaQuestionario.nomeCompetencia), 'clínico')}">
                <c:set var="respostaJulgamentoClinico" value="${resposta.respostaValorNumerico.intValue()}" />
            </c:when>
            <c:when test="${fn:contains(fn:toLowerCase(resposta.competenciaQuestionario.nomeCompetencia), 'comunicação')}">
                <c:set var="respostaComunicacao" value="${resposta.respostaValorNumerico.intValue()}" />
            </c:when>
            <c:when test="${fn:contains(fn:toLowerCase(resposta.competenciaQuestionario.nomeCompetencia), 'organização')}">
                <c:set var="respostaOrganizacao" value="${resposta.respostaValorNumerico.intValue()}" />
            </c:when>
            <c:when test="${fn:contains(fn:toLowerCase(resposta.competenciaQuestionario.nomeCompetencia), 'geral')}">
                <c:set var="respostaAvaliacaoGeral" value="${resposta.respostaValorNumerico.intValue()}" />
            </c:when>
        </c:choose>
    </c:forEach>
</c:if>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Avaliação 360 Formativa - Avaliação por Pares</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/formularios.css">
</head>
<body>
    <div class="formulario-container">
        <div class="formulario-header">
            <div class="formulario-titulo">AVALIAÇÃO 360 FORMATIVA (MEDICINA UNIFAE)</div>
            <div class="avaliacao360-tipo">AVALIAÇÃO POR PARES</div>
        </div>

        <form method="post" action="${pageContext.request.contextPath}/avaliacao/form">
            <input type="hidden" name="action" value="${action}">
            <input type="hidden" name="questionarioId" value="${questionarioIdSelecionado}">
            <input type="hidden" name="tipoAvaliadorNaoUsuario" value="Par Avaliador">
            <c:if test="${action == 'edit'}">
                <input type="hidden" name="avaliacaoId" value="${avaliacao.idAvaliacaoPreenchida}">
            </c:if>

            <!-- Dados Básicos -->
            <div class="dados-basicos">
                <table>
                    <tr>
                        <td>
                            <label>Aluno:</label>
                            <select name="alunoAvaliadoId" required style="width: 200px;">
                                <option value="0">Selecione o aluno</option>
                                <c:forEach var="aluno" items="${alunos}">
                                    <option value="${aluno.idUsuario}" 
                                            ${avaliacao != null && avaliacao.alunoAvaliado.idUsuario == aluno.idUsuario ? 'selected' : ''}>
                                        ${aluno.nomeCompleto}
                                    </option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>Par Avaliador:</label>
                            <select name="avaliadorId" style="width: 200px;">
                                <option value="0">Selecione o par avaliador</option>
                                <c:forEach var="aluno" items="${alunos}">
                                    <option value="${aluno.idUsuario}"
                                            ${avaliacao != null && avaliacao.avaliador != null && avaliacao.avaliador.idUsuario == aluno.idUsuario ? 'selected' : ''}>
                                        ${aluno.nomeCompleto}
                                    </option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>Local de realização:</label>
                            <select name="localRealizacao" style="width: 300px;">
                                <option value="0">Selecione o local</option>
                                <c:forEach var="local" items="${locaisEventos}">
                                    <option value="${local.nomeLocal}" 
                                            ${avaliacao != null && avaliacao.localRealizacao == local.nomeLocal ? 'selected' : ''}>
                                        ${local.nomeLocal} - ${local.tipoLocal}
                                    </option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>Horário de início:</label>
                            <input type="time" name="horarioInicio" 
                                   value="${avaliacao != null && avaliacao.horarioInicio != null ? avaliacao.horarioInicio : ''}">
                            
                            <label style="margin-left: 20px;">Horário de término:</label>
                            <input type="time" name="horarioFim" 
                                   value="${avaliacao != null && avaliacao.horarioFim != null ? avaliacao.horarioFim : ''}">
                            
                            <label style="margin-left: 20px;">Data da realização:</label>
                            <input type="date" name="dataRealizacao" required
                                   value="${avaliacao != null ? avaliacao.dataRealizacao : ''}">
                        </td>
                    </tr>
                </table>
            </div>

            <!-- Competências Simplificadas -->
            <div class="competencias-container">
                <div class="competencia-item">
                    <div class="competencia-header">Competências</div>
                    <div style="padding: 15px;">
                        <table style="width: 100%; border-collapse: collapse;">
                            <thead>
                                <tr style="background: #e0e0e0;">
                                    <th style="padding: 8px; border: 1px solid #000; text-align: left; width: 30%;">Competências</th>
                                    <th style="padding: 8px; border: 1px solid #000; text-align: center; width: 15%;">Insatisfatório</th>
                                    <th style="padding: 8px; border: 1px solid #000; text-align: center; width: 15%;">Satisfatório</th>
                                    <th style="padding: 8px; border: 1px solid #000; text-align: center; width: 15%;">Superior</th>
                                    <th style="padding: 8px; border: 1px solid #000; text-align: center; width: 25%;">Não avaliado</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td style="padding: 8px; border: 1px solid #000; font-weight: bold;">Anamnese</td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="1" end="3">
                                                <label><input type="radio" name="resposta_anamnese" value="${i}"> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="4" end="6">
                                                <label><input type="radio" name="resposta_anamnese" value="${i}"> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="7" end="9">
                                                <label><input type="radio" name="resposta_anamnese" value="${i}"> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <label><input type="checkbox" name="nao_avaliado_anamnese" value="true"> ☐</label>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td style="padding: 8px; border: 1px solid #000; font-weight: bold;">Exame Físico</td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="1" end="3">
                                                <label><input type="radio" name="resposta_exame_fisico" value="${i}"
                                               <c:if test="${respostaExameFisico == i}">checked</c:if>> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="4" end="6">
                                                <label><input type="radio" name="resposta_exame_fisico" value="${i}"
                                               <c:if test="${respostaExameFisico == i}">checked</c:if>> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="7" end="9">
                                                <label><input type="radio" name="resposta_exame_fisico" value="${i}"
                                               <c:if test="${respostaExameFisico == i}">checked</c:if>> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <label><input type="checkbox" name="nao_avaliado_exame_fisico" value="true"> ☐</label>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td style="padding: 8px; border: 1px solid #000; font-weight: bold;">Raciocínio Clínico</td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="1" end="3">
                                                <label><input type="radio" name="resposta_raciocinio_clinico" value="${i}"> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="4" end="6">
                                                <label><input type="radio" name="resposta_raciocinio_clinico" value="${i}"> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="7" end="9">
                                                <label><input type="radio" name="resposta_raciocinio_clinico" value="${i}"> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <label><input type="checkbox" name="nao_avaliado_raciocinio_clinico" value="true"> ☐</label>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td style="padding: 8px; border: 1px solid #000; font-weight: bold;">Profissionalismo</td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="1" end="3">
                                                <label><input type="radio" name="resposta_profissionalismo" value="${i}"
                                               <c:if test="${respostaProfissionalismo == i}">checked</c:if>> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="4" end="6">
                                                <label><input type="radio" name="resposta_profissionalismo" value="${i}"
                                               <c:if test="${respostaProfissionalismo == i}">checked</c:if>> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="7" end="9">
                                                <label><input type="radio" name="resposta_profissionalismo" value="${i}"
                                               <c:if test="${respostaProfissionalismo == i}">checked</c:if>> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <label><input type="checkbox" name="nao_avaliado_profissionalismo" value="true"> ☐</label>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td style="padding: 8px; border: 1px solid #000; font-weight: bold;">Comunicação</td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="1" end="3">
                                                <label><input type="radio" name="resposta_comunicacao" value="${i}"
                                               <c:if test="${respostaComunicacao == i}">checked</c:if>> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="4" end="6">
                                                <label><input type="radio" name="resposta_comunicacao" value="${i}"
                                               <c:if test="${respostaComunicacao == i}">checked</c:if>> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="7" end="9">
                                                <label><input type="radio" name="resposta_comunicacao" value="${i}"
                                               <c:if test="${respostaComunicacao == i}">checked</c:if>> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <label><input type="checkbox" name="nao_avaliado_comunicacao" value="true"> ☐</label>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td style="padding: 8px; border: 1px solid #000; font-weight: bold;">Organização e eficiência</td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="1" end="3">
                                                <label><input type="radio" name="resposta_organizacao" value="${i}"
                                               <c:if test="${respostaOrganizacao == i}">checked</c:if>> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="4" end="6">
                                                <label><input type="radio" name="resposta_organizacao" value="${i}"
                                               <c:if test="${respostaOrganizacao == i}">checked</c:if>> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="7" end="9">
                                                <label><input type="radio" name="resposta_organizacao" value="${i}"
                                               <c:if test="${respostaOrganizacao == i}">checked</c:if>> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <label><input type="checkbox" name="nao_avaliado_organizacao" value="true"> ☐</label>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td style="padding: 8px; border: 1px solid #000; font-weight: bold;">Competência Profissional Global</td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="1" end="3">
                                                <label><input type="radio" name="resposta_competencia_global" value="${i}"> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="4" end="6">
                                                <label><input type="radio" name="resposta_competencia_global" value="${i}"> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="7" end="9">
                                                <label><input type="radio" name="resposta_competencia_global" value="${i}"> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <label><input type="checkbox" name="nao_avaliado_competencia_global" value="true"> ☐</label>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Atitudes -->
                <div class="competencia-item">
                    <div class="competencia-header">Atitudes</div>
                    <div style="padding: 15px;">
                        <table style="width: 100%; border-collapse: collapse;">
                            <tbody>
                                <tr>
                                    <td style="padding: 8px; border: 1px solid #000; font-weight: bold; width: 30%;">Atitude de compaixão e respeito</td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center; width: 15%;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="1" end="3">
                                                <label><input type="radio" name="resposta_compaixao" value="${i}"> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center; width: 15%;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="4" end="6">
                                                <label><input type="radio" name="resposta_compaixao" value="${i}"> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center; width: 15%;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="7" end="9">
                                                <label><input type="radio" name="resposta_compaixao" value="${i}"> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center; width: 25%;">
                                        <label><input type="checkbox" name="nao_avaliado_compaixao" value="true"> ☐</label>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td style="padding: 8px; border: 1px solid #000; font-weight: bold;">Abordagem suave e sensível ao paciente</td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="1" end="3">
                                                <label><input type="radio" name="resposta_abordagem_suave" value="${i}"> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="4" end="6">
                                                <label><input type="radio" name="resposta_abordagem_suave" value="${i}"> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="7" end="9">
                                                <label><input type="radio" name="resposta_abordagem_suave" value="${i}"> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <label><input type="checkbox" name="nao_avaliado_abordagem_suave" value="true"> ☐</label>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td style="padding: 8px; border: 1px solid #000; font-weight: bold;">Comunicação e interação respeitosa com a equipe</td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="1" end="3">
                                                <label><input type="radio" name="resposta_interacao_equipe" value="${i}"> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="4" end="6">
                                                <label><input type="radio" name="resposta_interacao_equipe" value="${i}"> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <div class="escala-simples">
                                            <c:forEach var="i" begin="7" end="9">
                                                <label><input type="radio" name="resposta_interacao_equipe" value="${i}"> ${i}</label>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td style="padding: 8px; border: 1px solid #000; text-align: center;">
                                        <label><input type="checkbox" name="nao_avaliado_interacao_equipe" value="true"> ☐</label>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Feedback -->
            <div class="feedback-section">
                <div class="feedback-title">Feedback (preenchido pelo Par Avaliador)</div>
                
                <div class="feedback-item">
                    <label>O que foi bom? (Fortalezas no desempenho do estudante)</label>
                    <textarea name="feedbackPositivo">${avaliacao != null ? avaliacao.feedbackPositivo : ''}</textarea>
                </div>
                
                <div class="feedback-item">
                    <label>O que poderia ter sido melhor? (Fragilidades no desempenho do estudante)</label>
                    <textarea name="feedbackMelhoria">${avaliacao != null ? avaliacao.feedbackMelhoria : ''}</textarea>
                </div>
            </div>

            <!-- Assinaturas -->
            <div class="assinaturas">
                <div class="assinatura-campo">
                    <div class="assinatura-linha"></div>
                    <div class="assinatura-label">Assinatura e carimbo do Aluno</div>
                </div>
                <div class="assinatura-campo">
                    <div class="assinatura-linha"></div>
                    <div class="assinatura-label">Assinatura e carimbo do Par Avaliador</div>
                </div>
            </div>

            <!-- Botões de Ação -->
            <div class="botoes-acao">
                <button type="submit" class="btn btn-primary">Salvar Avaliação</button>
                <button type="button" class="btn" onclick="window.print()">Imprimir</button>
                <a href="${pageContext.request.contextPath}/avaliacoes" class="btn">Cancelar</a>
            </div>
        </form>
    </div>
</body>
</html>

