<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>${action == 'edit' ? 'Editar' : 'Novo'} Usuário</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/formularios.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>${action == 'edit' ? 'Editar Usuário' : 'Novo Usuário'}</h1>
        </div>
        <form action="${pageContext.request.contextPath}/admin/usuarios" method="post">
            <c:if test="${usuario != null}">
                <input type="hidden" name="idUsuario" value="${usuario.idUsuario}" />
            </c:if>

            <div class="form-section">
                <div class="form-group">
                    <label for="nomeCompleto">Nome Completo:</label>
                    <input type="text" id="nomeCompleto" name="nomeCompleto" value="${usuario.nomeCompleto}" required>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="${usuario.email}" required>
                </div>
                <div class="form-group">
                    <label for="senhaHash">Senha:</label>
                    <input type="password" id="senhaHash" name="senhaHash" placeholder="${action == 'edit' ? 'Deixe em branco para não alterar' : ''}" ${action == 'new' ? 'required' : ''}>
                </div>
                <div class="form-group">
                    <label for="tipoUsuario">Tipo de Usuário:</label>
                    <select id="tipoUsuario" name="tipoUsuario" required>
                        <c:forEach var="tipo" items="${tiposUsuario}">
                            <option value="${tipo}" ${usuario.tipoUsuario == tipo ? 'selected' : ''}>${tipo}</option>
                        </c:forEach>
                    </select>
                </div>
                 <div class="form-group">
                    <label for="permissaoId">Permissão:</label>
                    <select id="permissaoId" name="permissaoId" required>
                         <option value="">Selecione uma permissão...</option>
                        <c:forEach var="permissao" items="${listPermissoes}">
                            <option value="${permissao.idPermissao}" ${usuario.permissao.idPermissao == permissao.idPermissao ? 'selected' : ''}>${permissao.nomePermissao}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="matriculaRA">Matrícula/RA:</label>
                    <input type="text" id="matriculaRA" name="matriculaRA" value="${usuario.matriculaRA}">
                </div>
                <div class="form-group">
                    <label for="telefone">Telefone:</label>
                    <input type="text" id="telefone" name="telefone" value="${usuario.telefone}">
                </div>
                <div class="form-group">
                    <label for="periodoAtualAluno">Período (se aluno):</label>
                    <input type="text" id="periodoAtualAluno" name="periodoAtualAluno" value="${usuario.periodoAtualAluno}">
                </div>
                 <div class="form-group">
                    <label for="ativo">Ativo:</label>
                    <input type="checkbox" id="ativo" name="ativo" ${usuario.ativo or action == 'new' ? 'checked' : ''}>
                </div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Salvar</button>
                <a href="${pageContext.request.contextPath}/admin/usuarios" class="btn btn-secondary">Cancelar</a>
            </div>
        </form>
    </div>
</body>
</html>
