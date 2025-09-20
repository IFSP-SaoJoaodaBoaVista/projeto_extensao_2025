<%-- ====================================================================== --%>
<%-- DOCUMENTAÇÃO list.jsp                                                  --%>
<%-- ====================================================================== --%>
<%-- Este arquivo JSP exibe uma lista de eventos em formato de tabela.      --%>
<%-- Ele permite filtrar os eventos por vários critérios e realizar ações   --%>
<%-- como editar, excluir e alterar o status de cada evento.                --%>
<%-- ====================================================================== --%>

<%-- Diretivas da Página: Configuram o comportamento do arquivo JSP. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%-- Define o tipo de conteúdo como HTML com codificação UTF-8 (para acentos). --%>

<%-- Bibliotecas de Tags (Taglibs): Importam funcionalidades do JSTL. --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- 'c' (core): Para lógica como laços (forEach) e condicionais (if/choose). --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%-- 'fmt' (format): Para formatar datas e números. --%>

<%-- Importações Java: Traz classes Java para serem usadas na página. --%>
<%@ page import="java.time.format.DateTimeFormatter" %> <%-- Essencial para formatar as datas dos eventos. --%>
<html>
    <head>
        <title>Agenda de Eventos</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/formularios.css">
        <style>
            /* Estilo do cabeçalho principal da página */
            .header {
                background-color: #2c3e50;
                color: white;
                padding: 20px;
                margin-bottom: 20px;
                text-align: center;
                border-radius: 8px;
            }
            /* Container para a seção de filtros */
            .filters {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                margin-bottom: 20px;
            }
            /* Organiza os campos de filtro em linha */
            .filter-row {
                display: flex;
                gap: 15px;
                align-items: end;
                flex-wrap: wrap;
            }
            /* Agrupa cada label e seu campo de formulário */
            .filter-group {
                display: flex;
                flex-direction: column;
                min-width: 150px;
            }
            /* Estilo base para as "etiquetas" (badges) de status */
            .status-badge {
                padding: 4px 8px;
                border-radius: 12px;
                font-size: 12px;
                font-weight: bold;
                text-transform: uppercase;
            }
            /* Cores específicas para cada status */
            .status-agendado {
                background: #007bff;
                color: white;
            }
            .status-em_andamento {
                background: #ffc107;
                color: #212529;
            }
            .status-concluido {
                background: #28a745;
                color: white;
            }
            .status-cancelado {
                background: #dc3545;
                color: white;
            }

            /* Estilo para a "etiqueta" do tipo de evento */
            .tipo-badge {
                padding: 2px 6px;
                border-radius: 4px;
                font-size: 11px;
                background: #e9ecef;
                color: #495057;
            }
            /* Adiciona uma borda colorida à esquerda da linha da tabela, baseada no tipo de evento */
            .event-row {
                border-left: 4px solid #007bff;
            } /* Aula (Padrão) */
            .event-row.tipo-prova {
                border-left-color: #dc3545;
            }
            .event-row.tipo-avaliacao {
                border-left-color: #fd7e14;
            }
            .event-row.tipo-seminario {
                border-left-color: #6f42c1;
            }
            .event-row.tipo-reuniao {
                border-left-color: #20c997;
            }
            .event-row.tipo-evento {
                border-left-color: #ffc107;
            }

            /* Estilo para as mensagens de sucesso (salvo, excluído, etc.) */
            .success-message {
                background: #d4edda;
                color: #155724;
                padding: 10px;
                border-radius: 4px;
                margin-bottom: 20px;
                border: 1px solid #c3e6cb;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h1>📅 Agenda de Eventos</h1>
            </div>

            <%-- Mensagens de feedback para o usuário. Elas aparecem com base em parâmetros na URL. --%>
            <%-- Exemplo: Se a URL for ".../agenda?success=1", a mensagem de sucesso será exibida. --%>
            <c:if test="${param.success == '1'}">
                <div class="success-message">✅ Evento salvo com sucesso!</div>
            </c:if>
            <c:if test="${param.deleted == '1'}">
                <div class="success-message">🗑️ Evento excluído com sucesso!</div>
            </c:if>
            <c:if test="${param.statusChanged == '1'}">
                <div class="success-message">🔄 Status do evento alterado com sucesso!</div>
            </c:if>

            <div class="view-toggle">
                <a href="${pageContext.request.contextPath}/agenda" class="btn btn-primary">📋 Lista</a>
                <a href="${pageContext.request.contextPath}/agenda?action=calendar" class="btn">📅 Calendário</a>
            </div>

            <div class="actions menu">
                <a href="${pageContext.request.contextPath}/" class="btn">🏠 Voltar ao Início</a>
                <a href="${pageContext.request.contextPath}/agenda?action=new" class="btn btn-primary">➕ Novo Evento</a>
            </div>

            <div class="filters">
                <form method="get" action="${pageContext.request.contextPath}/agenda">
                    <div class="filter-row">
                        <div class="filter-group">
                            <label for="data">Data:</label>
                            <input type="date" id="data" name="data" value="${param.data}">
                        </div>
                        <div class="filter-group">
                            <label for="tipoEvento">Tipo:</label>
                            <select id="tipoEvento" name="tipoEvento">
                                <option value="">Todos os tipos</option>
                                <%-- O laço <c:forEach> preenche as opções dinamicamente com dados vindos do servidor. --%>
                                <c:forEach var="tipo" items="${tiposEvento}">
                                    <%-- A lógica ${param.tipoEvento == tipo ? 'selected' : ''} mantém o filtro selecionado após a página recarregar. --%>
                                    <option value="${tipo}" ${param.tipoEvento == tipo ? 'selected' : ''}>${tipo.descricao}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label for="statusEvento">Status:</label>
                            <select id="statusEvento" name="statusEvento">
                                <option value="">Todos os status</option>
                                <c:forEach var="status" items="${statusEvento}">
                                    <option value="${status}" ${param.statusEvento == status ? 'selected' : ''}>${status.descricao}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label>&nbsp;</label>
                            <button type="submit" class="btn">🔍 Filtrar</button>
                        </div>
                        <div class="filter-group">
                            <label>&nbsp;</label>
                            <a href="${pageContext.request.contextPath}/agenda" class="btn btn-secondary">🗑️ Limpar</a>
                        </div>
                    </div>
                </form>
            </div>

            <table class="table">
                <thead>
                    <tr>
                        <th>Data/Hora</th>
                        <th>Título</th>
                        <th>Tipo</th>
                        <th>Status</th>
                        <th>Local</th>
                        <th>Responsável</th>
                        <th>Disciplina</th>
                        <th>Turma</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <%-- A tag <c:choose> funciona como um if/else. --%>
                    <c:choose>
                        <%-- Caso 1: Se a lista de eventos estiver vazia... --%>
                        <c:when test="${empty eventos}">
                            <tr>
                                <%-- Exibe uma mensagem amigável ocupando todas as colunas (colspan="9"). --%>
                                <td colspan="9" style="text-align: center; padding: 40px; color: #666;">
                                    📭 Nenhum evento encontrado com os filtros aplicados.
                                </td>
                            </tr>
                        </c:when>
                        <%-- Caso 2: Se houver eventos na lista... --%>
                        <c:otherwise>
                            <%-- Itera sobre cada 'evento' na lista de 'eventos'. --%>
                            <c:forEach var="evento" items="${eventos}">
                                <%-- A classe da linha é definida dinamicamente para aplicar a borda colorida. --%>
                                <tr class="event-row tipo-${evento.tipoEvento.name().toLowerCase()}">
                                    <td>
                                        <%-- Formata e exibe a data e a hora de início/fim do evento. --%>
                                        <div>${evento.dataInicio.format(DateTimeFormatter.ofPattern('dd/MM/yyyy'))}</div>
                                        <div>
                                            ${evento.dataInicio.format(DateTimeFormatter.ofPattern('HH:mm'))}
                                            <c:if test="${evento.dataFim != null}">
                                                - ${evento.dataFim.format(DateTimeFormatter.ofPattern('HH:mm'))}
                                            </c:if>
                                        </div>
                                    </td>
                                    <td>
                                        <strong>${evento.titulo}</strong>
                                        <%-- Se a descrição for longa, ela é cortada para não quebrar o layout. --%>
                                        <c:if test="${not empty evento.descricao}">
                                            <div style="font-size: 12px; color: #666; margin-top: 4px;">
                                                ${evento.descricao.length() > 50 ? evento.descricao.substring(0, 50).concat('...') : evento.descricao}
                                            </div>
                                        </c:if>
                                    </td>
                                    <td><span class="tipo-badge">${evento.tipoEvento.descricao}</span></td>
                                    <td><span class="status-badge status-${evento.statusEvento.name().toLowerCase()}">${evento.statusEvento.descricao}</span></td>
                                        <%-- Para colunas como Local, Responsável, etc., usamos <c:choose> para exibir um hífen (-) se o valor for nulo. --%>
                                    <td>
                                        <c:choose>
                                            <c:when test="${evento.localEvento != null}">${evento.localEvento.nomeLocal}</c:when>
                                            <c:otherwise><span style="color: #999;">-</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${evento.responsavel != null}">${evento.responsavel.nomeCompleto}</c:when>
                                            <c:otherwise><span style="color: #999;">-</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${evento.disciplina != null}">${evento.disciplina.nomeDisciplina}</c:when>
                                            <c:otherwise><span style="color: #999;">-</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${evento.turma != null}">${evento.turma.nomeTurma}</c:when>
                                            <c:otherwise><span style="color: #999;">-</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div style="display: flex; gap: 5px; flex-wrap: wrap;">
                                            <a href="agenda?action=edit&idEvento=${evento.idEvento}" class="btn" title="Editar">✏️</a>

                                            <%-- Os botões de mudança de status são exibidos condicionalmente. --%>
                                            <c:if test="${evento.statusEvento == 'AGENDADO'}">
                                                <a href="agenda?action=changeStatus&idEvento=${evento.idEvento}&status=EM_ANDAMENTO" class="btn" title="Iniciar Evento" onclick="return confirm('Iniciar este evento?')">▶️</a>
                                            </c:if>
                                            <c:if test="${evento.statusEvento == 'EM_ANDAMENTO'}">
                                                <a href="agenda?action=changeStatus&idEvento=${evento.idEvento}&status=CONCLUIDO" class="btn" title="Concluir Evento" onclick="return confirm('Concluir este evento?')">✅</a>
                                            </c:if>
                                            <c:if test="${evento.statusEvento == 'AGENDADO' || evento.statusEvento == 'EM_ANDAMENTO'}">
                                                <a href="agenda?action=changeStatus&idEvento=${evento.idEvento}&status=CANCELADO" class="btn" title="Cancelar Evento" onclick="return confirm('Cancelar este evento?')">❌</a>
                                            </c:if>

                                            <a href="agenda?action=delete&idEvento=${evento.idEvento}" class="btn btn-danger" title="Excluir" onclick="return confirm('Tem certeza que deseja excluir este evento?\n\nEsta ação não pode ser desfeita.')">🗑️</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

            <%-- Se a lista de eventos não estiver vazia, exibe um rodapé com o total de eventos encontrados. --%>
            <c:if test="${not empty eventos}">
                <div style="margin-top: 20px; padding: 15px; background: #f8f9fa; border-radius: 8px; color: #666;">
                    📊 Total de eventos: <strong>${eventos.size()}</strong>
                </div>
            </c:if>
        </div>
    </body>
</html>