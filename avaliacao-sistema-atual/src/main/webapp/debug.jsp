<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>Debug Radio Buttons</title>
</head>
<body>
    <h1>Debug - Radio Buttons</h1>
    
    <h2>Dados Recebidos:</h2>
    <p><strong>Respostas:</strong> ${respostas}</p>
    <p><strong>Tamanho da lista:</strong> ${fn:length(respostas)}</p>
    
    <h2>Iteração pelas Respostas:</h2>
    <c:if test="${respostas != null}">
        <c:forEach var="resposta" items="${respostas}" varStatus="status">
            <p><strong>Resposta ${status.index + 1}:</strong></p>
            <ul>
                <li>ID: ${resposta.idRespostaItem}</li>
                <li>Valor Numérico: ${resposta.respostaValorNumerico}</li>
                <li>Competência: ${resposta.competenciaQuestionario.nomeCompetencia}</li>
                <li>Competência (lowercase): ${fn:toLowerCase(resposta.competenciaQuestionario.nomeCompetencia)}</li>
                <li>Contém 'entrevista': ${fn:contains(fn:toLowerCase(resposta.competenciaQuestionario.nomeCompetencia), 'entrevista')}</li>
            </ul>
        </c:forEach>
    </c:if>
    
    <h2>Mapeamento de Variáveis:</h2>
    
    <%-- Lógica de mapeamento --%>
    <c:set var="respostaEntrevistaMedica" value="" />
    <c:set var="respostaExameFisico" value="" />
    <c:set var="respostaProfissionalismo" value="" />
    <c:set var="respostaJulgamentoClinico" value="" />
    <c:set var="respostaComunicacao" value="" />
    <c:set var="respostaOrganizacao" value="" />
    <c:set var="respostaAvaliacaoGeral" value="" />

    <c:if test="${respostas != null}">
        <c:forEach var="resposta" items="${respostas}">
            <c:choose>
                <c:when test="${fn:contains(fn:toLowerCase(resposta.competenciaQuestionario.nomeCompetencia), 'entrevista')}">
                    <c:set var="respostaEntrevistaMedica" value="${resposta.respostaValorNumerico}" />
                    <p>✅ Mapeou Entrevista Médica: ${resposta.respostaValorNumerico}</p>
                </c:when>
                <c:when test="${fn:contains(fn:toLowerCase(resposta.competenciaQuestionario.nomeCompetencia), 'exame')}">
                    <c:set var="respostaExameFisico" value="${resposta.respostaValorNumerico}" />
                    <p>✅ Mapeou Exame Físico: ${resposta.respostaValorNumerico}</p>
                </c:when>
                <c:when test="${fn:contains(fn:toLowerCase(resposta.competenciaQuestionario.nomeCompetencia), 'profissional')}">
                    <c:set var="respostaProfissionalismo" value="${resposta.respostaValorNumerico}" />
                    <p>✅ Mapeou Profissionalismo: ${resposta.respostaValorNumerico}</p>
                </c:when>
                <c:when test="${fn:contains(fn:toLowerCase(resposta.competenciaQuestionario.nomeCompetencia), 'julgamento') || fn:contains(fn:toLowerCase(resposta.competenciaQuestionario.nomeCompetencia), 'clínico')}">
                    <c:set var="respostaJulgamentoClinico" value="${resposta.respostaValorNumerico}" />
                    <p>✅ Mapeou Julgamento Clínico: ${resposta.respostaValorNumerico}</p>
                </c:when>
                <c:when test="${fn:contains(fn:toLowerCase(resposta.competenciaQuestionario.nomeCompetencia), 'comunicação')}">
                    <c:set var="respostaComunicacao" value="${resposta.respostaValorNumerico}" />
                    <p>✅ Mapeou Comunicação: ${resposta.respostaValorNumerico}</p>
                </c:when>
                <c:when test="${fn:contains(fn:toLowerCase(resposta.competenciaQuestionario.nomeCompetencia), 'organização')}">
                    <c:set var="respostaOrganizacao" value="${resposta.respostaValorNumerico}" />
                    <p>✅ Mapeou Organização: ${resposta.respostaValorNumerico}</p>
                </c:when>
                <c:when test="${fn:contains(fn:toLowerCase(resposta.competenciaQuestionario.nomeCompetencia), 'geral')}">
                    <c:set var="respostaAvaliacaoGeral" value="${resposta.respostaValorNumerico}" />
                    <p>✅ Mapeou Avaliação Geral: ${resposta.respostaValorNumerico}</p>
                </c:when>
                <c:otherwise>
                    <p>❌ Não mapeou: ${resposta.competenciaQuestionario.nomeCompetencia}</p>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </c:if>
    
    <h2>Valores Finais das Variáveis:</h2>
    <ul>
        <li><strong>respostaEntrevistaMedica:</strong> "${respostaEntrevistaMedica}"</li>
        <li><strong>respostaExameFisico:</strong> "${respostaExameFisico}"</li>
        <li><strong>respostaProfissionalismo:</strong> "${respostaProfissionalismo}"</li>
        <li><strong>respostaJulgamentoClinico:</strong> "${respostaJulgamentoClinico}"</li>
        <li><strong>respostaComunicacao:</strong> "${respostaComunicacao}"</li>
        <li><strong>respostaOrganizacao:</strong> "${respostaOrganizacao}"</li>
        <li><strong>respostaAvaliacaoGeral:</strong> "${respostaAvaliacaoGeral}"</li>
    </ul>
    
    <h2>Teste de Radio Buttons:</h2>
    <h3>Entrevista Médica (valor esperado: ${respostaEntrevistaMedica}):</h3>
    <c:forEach var="i" begin="1" end="9">
        <label>
            <input type="radio" name="test_entrevista" value="${i}"
                   <c:if test="${respostaEntrevistaMedica == i}">checked</c:if>>
            ${i} <c:if test="${respostaEntrevistaMedica == i}">✅ MARCADO</c:if>
        </label><br>
    </c:forEach>
    
    <h3>Teste de Comparação:</h3>
    <p>respostaEntrevistaMedica = "${respostaEntrevistaMedica}"</p>
    <p>Tipo: ${respostaEntrevistaMedica.class.name}</p>
    <p>Comparação com 7: ${respostaEntrevistaMedica == 7}</p>
    <p>Comparação com "7": ${respostaEntrevistaMedica == "7"}</p>
    <p>Comparação com 7.0: ${respostaEntrevistaMedica == 7.0}</p>
    <p>Comparação com "7.0": ${respostaEntrevistaMedica == "7.0"}</p>
    
</body>
</html>

