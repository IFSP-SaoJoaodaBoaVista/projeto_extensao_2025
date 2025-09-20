<%-- ====================================================================== --%>
<%-- DOCUMENTAÇÃO calendar.jsp                                              --%>
<%-- ====================================================================== --%>
<%-- Este arquivo JSP exibe um calendário de eventos. Ele combina:          --%>
<%--   - HTML: Para a estrutura da página.                                  --%>
<%--   - CSS: Para a estilização visual.                                    --%>
<%--   - JavaScript: Para interatividade (mudar de mês, etc.).              --%>
<%--   - JSTL (JavaServer Pages Standard Tag Library): Para lógica dinâmica.--%>
<%-- ====================================================================== --%>

<%-- Diretivas da Página: Configuram o comportamento do arquivo JSP. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%-- Define o tipo de conteúdo como HTML com codificação UTF-8 (para acentos). --%>

<%-- Bibliotecas de Tags (Taglibs): Importam funcionalidades do JSTL para usar no HTML. --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- 'c' (core): Para lógica como laços (forEach) e condicionais (if). --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%-- 'fmt' (format): Para formatar datas e números. --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> <%-- 'fn' (functions): Para funções úteis, como contar itens em uma lista. --%>

<%-- Importações Java: Traz classes Java para serem usadas na página. --%>
<%@ page import="java.time.format.DateTimeFormatter" %> <%-- Para formatar datas e horas. --%>
<%@ page import="java.time.LocalDate" %> <%-- Para trabalhar com datas (ano, mês, dia). --%>
<html>
    <head>
        <title>Calendário de Eventos</title>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/formularios.css">

        <style>
            .header {
                background-color: #2c3e50;
                color: white;
                padding: 20px;
                margin-bottom: 20px;
                text-align: center;
                border-radius: 8px;
            }
            /* A caixa principal que envolve todo o calendário. */
            .calendar-container {
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                overflow: hidden;
            }
            .calendar-header {
                background: #007bff;
                color: white;
                padding: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            /* ... outros estilos ... */

            /* Define o layout em grade com 7 colunas para os dias da semana. */
            .calendar-grid {
                display: grid;
                grid-template-columns: repeat(7, 1fr);
            }
            /* Estilo de cada célula/dia do calendário. */
            .calendar-day {
                min-height: 120px;
                border-right: 1px solid #dee2e6;
                border-bottom: 1px solid #dee2e6;
                padding: 8px;
                position: relative;
                transition: background 0.2s ease;
            }
            .calendar-day.today {
                background: #fff3cd; /* Destaque para o dia de hoje */
            }
            /* Estilo para as "etiquetas" coloridas que representam os eventos. */
            .event-item-compact {
                padding: 3px 5px;
                margin: 2px 0;
                border-radius: 3px;
                font-size: 11px;
                cursor: pointer; /* Muda o cursor para uma "mãozinha" para indicar que é clicável. */
                display: flex;
                color: white;
            }
            .event-item-compact:hover {
                filter: brightness(110%); /* Efeito visual ao passar o mouse. */
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h1>? Calendário de Eventos</h1>
            </div>

            <div class="view-toggle">
                <a href="${pageContext.request.contextPath}/agenda" class="btn">📋 Lista</a>
                <a href="${pageContext.request.contextPath}/agenda?action=calendar" class="btn btn-primary">📅 Calendário</a>
            </div>

            <div class="actions menu">
                <a href="${pageContext.request.contextPath}/" class="btn">🏠 Voltar ao Início</a>
                <a href="${pageContext.request.contextPath}/agenda?action=new" class="btn btn-primary">➕ Novo Evento</a>
            </div>

            <div class="month-selector">
                <label for="mesSelect">Mês:</label>
                <select id="mesSelect" onchange="changeMonth()">
                    <option value="1" ${mes == 1 ? 'selected' : ''}>Janeiro</option>
                    <option value="12" ${mes == 12 ? 'selected' : ''}>Dezembro</option>
                </select>

                <label for="anoSelect">Ano:</label>
                <select id="anoSelect" onchange="changeMonth()">
                    <c:forEach var="i" begin="${ano - 2}" end="${ano + 2}">
                        <option value="${i}" ${ano == i ? 'selected' : ''}>${i}</option>
                    </c:forEach>
                </select>

                <button onclick="goToToday()" class="btn">📍 Hoje</button>
            </div>

            <div class="legend">
                <div class="legend-item"><div class="legend-color" style="background: #007bff;"></div><span>Aula</span></div>
            </div>

            <div class="calendar-container">
                <div class="calendar-header">
                    <div class="calendar-nav">
                        <a href="?action=calendar&mes=${mes == 1 ? 12 : mes - 1}&ano=${mes == 1 ? ano - 1 : ano}">‹ Anterior</a>
                    </div>
                    <div class="calendar-title">
                        <%-- Usamos a tag <c:choose> para exibir o nome do mês com base no número do mês. --%>
                        <c:choose>
                            <c:when test="${mes == 1}">Janeiro</c:when>
                            <%-- ... outros meses ... --%>
                            <c:when test="${mes == 12}">Dezembro</c:when>
                        </c:choose>
                        ${ano}
                    </div>
                    <div class="calendar-nav">
                        <a href="?action=calendar&mes=${mes == 12 ? 1 : mes + 1}&ano=${mes == 12 ? ano + 1 : ano}">Próximo ›</a>
                    </div>
                </div>

                <div class="calendar-grid">
                    <div class="calendar-day-header">Dom</div>
                    <div class="calendar-day-header">Seg</div>
                    <div class="calendar-day-header">Ter</div>
                    <div class="calendar-day-header">Qua</div>
                    <div class="calendar-day-header">Qui</div>
                    <div class="calendar-day-header">Sex</div>
                    <div class="calendar-day-header">Sáb</div>

                    <%-- Lógica JSTL para calcular e exibir os dias no grid. --%>
                    <%-- Guarda em variáveis o dia da semana em que o mês começa e o total de dias do mês. --%>
                    <c:set var="primeiroDiaSemana" value="${primeiroDia.dayOfWeek.value % 7}" />
                    <c:set var="diasNoMes" value="${ultimoDia.dayOfMonth}" />

                    <%-- ETAPA 1: Renderiza os dias do final do mês anterior para preencher o início do calendário. --%>
                    <c:if test="${primeiroDiaSemana > 0}">
                        <c:set var="ultimoDiaMesAnterior" value="${primeiroDia.minusDays(1)}" />
                        <c:forEach var="i" begin="1" end="${primeiroDiaSemana}">
                            <c:set var="dia" value="${ultimoDiaMesAnterior.dayOfMonth - primeiroDiaSemana + i}" />
                            <div class="calendar-day other-month">
                                <div class="day-number">${dia}</div>
                            </div>
                        </c:forEach>
                    </c:if>

                    <%-- ETAPA 2: Laço principal que renderiza cada dia do mês atual. --%>
                    <c:forEach var="dia" begin="1" end="${diasNoMes}">
                        <%-- Para cada dia, criamos um objeto de data e buscamos seus eventos. --%>
                        <c:set var="dataAtualObj" value="${LocalDate.of(ano, mes, dia)}" />
                        <c:set var="eventosDoDia" value="${eventosPorDia[dataAtualObj]}" />
                        <c:set var="temEventos" value="${not empty eventosDoDia}" />
                        <c:set var="isToday" value="${dataAtualObj.isEqual(LocalDate.now())}" />

                        <div class="calendar-day ${isToday ? 'today' : ''}">
                            <div class="day-number">
                                ${dia}
                                <%-- Se houver eventos no dia, exibe um contador. --%>
                                <c:if test="${temEventos}">
                                    <span class="event-count">${fn:length(eventosDoDia)}</span>
                                </c:if>
                            </div>

                            <div class="day-events">
                                <%-- Laço interno que cria uma "etiqueta" para cada evento do dia. --%>
                                <c:forEach var="evento" items="${eventosDoDia}">
                                    <%-- 
                                      FUNCIONALIDADE PRINCIPAL DE EDIÇÃO:
                                      O atributo 'onclick' usa JavaScript para redirecionar o usuário.
                                      A URL de edição é construída dinamicamente aqui no servidor,
                                      inserindo o ID do evento (`${evento.idEvento}`) diretamente no link.
                                      Isso garante que, ao clicar, o sistema saiba qual evento editar.
                                    --%>
                                    <div class="event-item-compact tipo-${evento.tipoEvento.name().toLowerCase()} status-${evento.statusEvento.name().toLowerCase()}"
                                         title="Clique para editar: ${fn:escapeXml(evento.titulo)}"
                                         onclick="window.location.href = '${pageContext.request.contextPath}/agenda?action=edit&idEvento=${evento.idEvento}'">
                                        <div class="event-time">${evento.dataInicio.format(DateTimeFormatter.ofPattern('HH:mm'))}</div>
                                        <div class="event-title">${evento.titulo}</div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>

                    <%-- ETAPA 3: Renderiza os dias do início do próximo mês para completar a última semana. --%>
                    <c:set var="totalCells" value="${primeiroDiaSemana + diasNoMes}" />
                    <c:if test="${totalCells % 7 != 0}">
                        <c:forEach var="i" begin="1" end="${7 - (totalCells % 7)}">
                            <div class="calendar-day other-month">
                                <div class="day-number">${i}</div>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
            </div>

            <div style="margin-top: 20px; padding: 15px; background: #f8f9fa; border-radius: 8px; color: #666;">
                📊 Total de eventos no mês: <strong>${totalEventos}</strong>
            </div>
        </div>

        <script>
            /**
             * Função chamada quando o usuário altera o mês ou o ano.
             * Ela pega os valores selecionados e recarrega a página com a nova data na URL.
             */
            function changeMonth() {
                const mes = document.getElementById('mesSelect').value;
                const ano = document.getElementById('anoSelect').value;
                window.location.href = `?action=calendar&mes=${mes}&ano=${ano}`;
            }

            /**
             * Função chamada pelo botão "Hoje".
             * Ela pega a data atual do sistema do usuário e recarrega a página
             * para exibir o calendário do mês e ano correntes.
             */
            function goToToday() {
                const hoje = new Date();
                const mes = hoje.getMonth() + 1; // getMonth() é base 0 (Jan=0), então somamos 1.
                const ano = hoje.getFullYear();
                window.location.href = `?action=calendar&mes=${mes}&ano=${ano}`;
            }
        </script>
    </body>
</html>