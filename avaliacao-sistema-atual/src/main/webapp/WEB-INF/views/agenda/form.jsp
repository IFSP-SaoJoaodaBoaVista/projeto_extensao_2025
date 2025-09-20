<%--
    FORM.JSP - VIEW PARA CRIAÇÃO E EDIÇÃO DE EVENTOS
    ================================================
    Esta página JSP serve como a interface de usuário para criar um novo evento
    ou editar um evento já existente. Ela é dinâmica e se adapta dependendo se
    um objeto 'evento' é passado a ela pelo AgendaServlet.

    Funcionalidades Principais:
    ---------------------------
    - Renderiza um formulário HTML com campos para todos os atributos de um EventoAgenda.
    - Se estiver editando, pré-preenche os campos com os dados do evento existente.
    - Exibe mensagens de erro ou de status (ex: "Evento finalizado").
    - Utiliza JSTL para renderizar dinamicamente as opções dos menus <select>.
    - Inclui JavaScript para validações no lado do cliente (client-side), como
      verificar se a data de fim é posterior à de início, melhorando a experiência do usuário.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<html>
    <head>
        <%-- O título da página é dinâmico: "Novo Evento" ou "Editar Evento" --%>
        <title>${not empty evento ? 'Editar' : 'Novo'} Evento</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/formularios.css">
        <%--
            CSS EMBUTIDO (INLINE STYLE)
            ===========================
            Define os estilos visuais específicos para este formulário, organizando-o
            em seções e melhorando a legibilidade dos campos e mensagens.
        --%>
        <style>
            .header {
                background-color: #2c3e50;
                color: white;
                padding: 20px;
                margin-bottom: 20px;
                text-align: center;
                border-radius: 8px;
            }
            .form-section { /* Estilo para cada bloco de campos (Ex: Informações Básicas) */
                background: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                margin-bottom: 20px;
            }
            .form-section h3 {
                margin-top: 0;
                color: #495057;
                border-bottom: 2px solid #dee2e6;
                padding-bottom: 10px;
            }
            .form-row { /* Para alinhar campos lado a lado */
                display: flex;
                gap: 20px;
                margin-bottom: 15px;
            }
            .form-row .form-group {
                flex: 1; /* Faz com que os campos na mesma linha ocupem espaço igual */
            }
            .datetime-input { /* Estilo para campos de data para melhor legibilidade */
                font-family: monospace;
            }
            .error-message { /* Bloco de destaque para mensagens de erro */
                background: #f8d7da;
                color: #721c24;
                padding: 10px;
                border-radius: 4px;
                margin-bottom: 20px;
                border: 1px solid #f5c6cb;
            }
            .help-text { /* Texto de ajuda abaixo dos campos do formulário */
                font-size: 12px;
                color: #6c757d;
                margin-top: 4px;
            }
            .required { /* Estilo para o asterisco (*) de campos obrigatórios */
                color: #dc3545;
            }
            .status-info { /* Bloco de destaque para informações de status */
                background: #d1ecf1;
                color: #0c5460;
                padding: 10px;
                border-radius: 4px;
                margin-bottom: 20px;
                border: 1px solid #bee5eb;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <%-- O título principal também é dinâmico --%>
                <h1>📅 ${not empty evento ? 'Editar Evento' : 'Novo Evento'}</h1>
            </div>

            <%--
                BLOCO DE MENSAGEM DE ERRO
                =========================
                A tag <c:if> da JSTL verifica se o atributo 'erro' existe na requisição.
                Se existir (ou seja, se o Servlet enviou uma mensagem de erro),
                este bloco de HTML será renderizado.
            --%>
            <c:if test="${not empty erro}">
                <div class="error-message">
                    ❌ ${erro}
                </div>
            </c:if>

            <%-- Bloco de informação de status, exibido apenas no modo de edição --%>
            <c:if test="${not empty evento}">
                <div class="status-info">
                    ℹ️ <strong>Status atual:</strong> ${evento.statusEvento.descricao}
                    <%-- Adiciona um aviso se o evento já estiver concluído ou cancelado --%>
                    <c:if test="${evento.statusEvento == 'CONCLUIDO' || evento.statusEvento == 'CANCELADO'}">
                        - Este evento está finalizado e algumas alterações podem ser limitadas.
                    </c:if>
                </div>
            </c:if>

            <%--
                FORMULÁRIO PRINCIPAL
                ====================
                action: URL para onde os dados do formulário serão enviados (/agenda).
                method="post": Usa o método HTTP POST, que é o correto para enviar dados que modificam o estado no servidor.
            --%>
            <form action="${pageContext.request.contextPath}/agenda" method="post">
                <%-- Campo oculto para o ID do evento, enviado apenas no modo de edição para que o Servlet saiba qual evento atualizar --%>
                <c:if test="${not empty evento}">
                    <input type="hidden" name="idEvento" value="${evento.idEvento}" />
                </c:if>

                <%-- Seção de Informações Básicas do Evento --%>
                <div class="form-section">
                    <h3>📋 Informações Básicas</h3>

                    <div class="form-group">
                        <label for="titulo">Título <span class="required">*</span>:</label>
                        <input type="text" id="titulo" name="titulo" value="${evento.titulo}" required
                               placeholder="Ex: Aula de Anatomia - Sistema Cardiovascular">
                        <div class="help-text">Título descritivo do evento</div>
                    </div>

                    <div class="form-group">
                        <label for="descricao">Descrição:</label>
                        <textarea id="descricao" name="descricao" placeholder="Descrição detalhada do evento (opcional)">${evento.descricao}</textarea>
                        <div class="help-text">Informações adicionais sobre o evento</div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="tipoEvento">Tipo de Evento <span class="required">*</span>:</label>
                            <select id="tipoEvento" name="tipoEvento" required>
                                <option value="">Selecione o tipo...</option>
                                <%-- A tag <c:forEach> itera sobre a lista 'tiposEvento' enviada pelo Servlet para criar as opções --%>
                                <c:forEach var="tipo" items="${tiposEvento}">
                                    <%-- O operador ternário seleciona a opção correta no modo de edição --%>
                                    <option value="${tipo}" ${evento.tipoEvento == tipo ? 'selected' : ''}>${tipo.descricao}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="statusEvento">Status <span class="required">*</span>:</label>
                            <select id="statusEvento" name="statusEvento" required>
                                <c:forEach var="status" items="${statusEvento}">
                                    <option value="${status}" ${evento.statusEvento == status ? 'selected' : ''}>${status.descricao}</option>
                                </c:forEach>
                            </select>
                            <div class="help-text">Status atual do evento</div>
                        </div>
                    </div>
                </div>

                <%-- Seção de Data e Horário --%>
                <div class="form-section">
                    <h3>🕐 Data e Horário</h3>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="dataInicio">Data/Hora de Início <span class="required">*</span>:</label>
                            <%--
                                Ponto Didático: Formatação de Data com Caracteres Literais
                                -----------------------------------------------------------
                                1. O valor é preenchido usando EL 3.0 para formatar o objeto LocalDateTime.
                                2. O formato 'yyyy-MM-dd''T''HH:mm' é necessário para o input <input type="datetime-local">.
                                3. O 'T' é um caractere literal, não um símbolo de formatação. Para que o DateTimeFormatter
                                   do Java o entenda como texto, ele precisa ser colocado entre aspas simples ('T').
                                4. Como a expressão inteira já está dentro de aspas simples para o EL, precisamos "escapar"
                                   as aspas internas, resultando na sintaxe com aspas duplas: ''T''.
                                5. Uma verificação '!= null' previne erros no modo de criação de novo evento.
                            --%>
                            <input type="datetime-local" id="dataInicio" name="dataInicio"
                                   class="datetime-input" required
                                   value="${evento.dataInicio != null ? evento.dataInicio.format(DateTimeFormatter.ofPattern('yyyy-MM-dd\'T\'HH:mm')) : ''}">
                            <div class="help-text">Data e horário de início do evento</div>
                        </div>

                        <div class="form-group">
                            <label for="dataFim">Data/Hora de Fim:</label>
                            <input type="datetime-local" id="dataFim" name="dataFim"
                                   class="datetime-input"
                                   value="${evento.dataFim != null ? evento.dataFim.format(DateTimeFormatter.ofPattern('yyyy-MM-dd\'T\'HH:mm')) : ''}">
                            <div class="help-text">Data e horário de término (opcional)</div>
                        </div>
                    </div>
                </div>

                <%-- Seção de Local, Disciplina, Turma e Responsável (com menus <select> populados dinamicamente) --%>
                <div class="form-section">
                    <h3>📍 Local</h3>
                    <div class="form-group">
                        <label for="localEventoId">Local do Evento:</label>
                        <select id="localEventoId" name="localEventoId">
                            <option value="">Selecione o local...</option>
                            <c:forEach var="local" items="${locaisEvento}">
                                <option value="${local.idLocalEvento}"
                                        ${not empty evento.localEvento && evento.localEvento.idLocalEvento == local.idLocalEvento ? 'selected' : ''}>
                                    ${local.nomeLocal}
                                    <c:if test="${not empty local.tipoLocal}"> - ${local.tipoLocal}</c:if>
                                </option>
                            </c:forEach>
                        </select>
                        <div class="help-text">Local onde o evento será realizado</div>
                    </div>
                </div>

                <div class="form-section">
                    <h3>🎓 Relacionamentos Acadêmicos</h3>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="disciplinaId">Disciplina:</label>
                            <select id="disciplinaId" name="disciplinaId">
                                <option value="">Selecione a disciplina...</option>
                                <c:forEach var="disciplina" items="${disciplinas}">
                                    <option value="${disciplina.idDisciplina}"
                                            ${not empty evento.disciplina && evento.disciplina.idDisciplina == disciplina.idDisciplina ? 'selected' : ''}>
                                        ${disciplina.nomeDisciplina}
                                        <c:if test="${not empty disciplina.siglaDisciplina}"> (${disciplina.siglaDisciplina})</c:if>
                                    </option>
                                </c:forEach>
                            </select>
                            <div class="help-text">Disciplina relacionada ao evento</div>
                        </div>
                        <div class="form-group">
                            <label for="turmaId">Turma:</label>
                            <select id="turmaId" name="turmaId">
                                <option value="">Selecione a turma...</option>
                                <c:forEach var="turma" items="${turmas}">
                                    <option value="${turma.idTurma}"
                                            ${not empty evento.turma && evento.turma.idTurma == turma.idTurma ? 'selected' : ''}>
                                        ${turma.nomeTurma}
                                        <c:if test="${not empty turma.codigoTurma}"> (${turma.codigoTurma})</c:if>
                                    </option>
                                </c:forEach>
                            </select>
                            <div class="help-text">Turma participante do evento</div>
                        </div>
                    </div>
                </div>

                <div class="form-section">
                    <h3>👤 Responsável</h3>
                    <div class="form-group">
                        <label for="responsavelId">Responsável pelo Evento:</label>
                        <select id="responsavelId" name="responsavelId">
                            <option value="">Selecione o responsável...</option>
                            <c:forEach var="usuario" items="${usuarios}">
                                <option value="${usuario.idUsuario}"
                                        ${not empty evento.responsavel && evento.responsavel.idUsuario == usuario.idUsuario ? 'selected' : ''}>
                                    ${usuario.nomeCompleto} (${usuario.tipoUsuario})
                                </option>
                            </c:forEach>
                        </select>
                        <div class="help-text">Usuário responsável pela organização do evento</div>
                    </div>
                </div>

                <%-- Botões de Ação do Formulário --%>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">💾 Salvar Evento</button>
                    <a href="${pageContext.request.contextPath}/agenda" class="btn btn-secondary">❌ Cancelar</a>
                    <%-- O botão de excluir só aparece no modo de edição --%>
                    <c:if test="${not empty evento}">
                        <a href="${pageContext.request.contextPath}/agenda?action=delete&id=${evento.idEvento}"
                           class="btn btn-danger"
                           onclick="return confirm('Tem certeza que deseja excluir este evento?\\n\\nEsta ação não pode ser desfeita.')"
                           style="margin-left: auto;">🗑️ Excluir</a>
                    </c:if>
                </div>
            </form>
        </div>

        <%--
            SCRIPT JAVASCRIPT
            =================
            Contém a lógica de validação no lado do cliente (client-side).
            Isso oferece um feedback rápido ao usuário sem a necessidade de enviar
            o formulário ao servidor, melhorando a usabilidade.
        --%>
        <script>
            // Adiciona um "ouvinte" de eventos que dispara a função sempre que a data de início é alterada.
            document.getElementById('dataInicio').addEventListener('change', function () {
                const dataInicio = new Date(this.value);
                const dataFimInput = document.getElementById('dataFim');

                // Se a data de fim já estiver preenchida, verifica se ela é anterior à nova data de início.
                if (dataFimInput.value) {
                    const dataFim = new Date(dataFimInput.value);
                    if (dataFim <= dataInicio) {
                        alert('A data de fim deve ser posterior à data de início.');
                        dataFimInput.value = ''; // Limpa o campo inválido.
                    }
                }
            });

            // Faz a mesma verificação quando o campo de data de fim é alterado.
            document.getElementById('dataFim').addEventListener('change', function () {
                const dataFim = new Date(this.value);
                const dataInicioInput = document.getElementById('dataInicio');

                if (dataInicioInput.value) {
                    const dataInicio = new Date(dataInicioInput.value);
                    if (dataFim <= dataInicio) {
                        alert('A data de fim deve ser posterior à data de início.');
                        this.value = '';
                    }
                }
            });

            // Lógica para pré-preencher o status como "AGENDADO" ao criar um novo evento.
            document.getElementById('tipoEvento').addEventListener('change', function () {
                const statusSelect = document.getElementById('statusEvento');
                // Verifica se NÃO estamos no modo de edição (procurando pelo input oculto do ID).
                if (!document.querySelector('input[name="idEvento"]')) {
                    statusSelect.value = 'AGENDADO';
                }
            });

            // Validação final antes de submeter o formulário.
            document.querySelector('form').addEventListener('submit', function (e) {
                const dataInicio = document.getElementById('dataInicio').value;
                const dataFim = document.getElementById('dataFim').value;

                if (dataInicio && dataFim) {
                    const inicio = new Date(dataInicio);
                    const fim = new Date(dataFim);

                    if (fim <= inicio) {
                        e.preventDefault(); // Impede o envio do formulário.
                        alert('A data de fim deve ser posterior à data de início.');
                        return false;
                    }
                }
            });
        </script>
    </body>
</html>