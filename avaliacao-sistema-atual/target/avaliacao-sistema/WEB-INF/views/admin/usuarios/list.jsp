<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Gerenciamento de Usuários</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/formularios.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Gerenciamento de Usuários</h1>
        </div>
        <div class="actions menu">
             <a href="${pageContext.request.contextPath}/" class="btn">🏠 Voltar ao Início</a>
             <a href="${pageContext.request.contextPath}/admin/usuarios?action=new" class="btn btn-primary">Novo Usuário</a>
        </div>
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome Completo</th>
                    <th>Email</th>
                    <th>Tipo</th>
                    <th>Status</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="usuario" items="${listUsuarios}">
                    <tr>
                        <td>${usuario.idUsuario}</td>
                        <td>${usuario.nomeCompleto}</td>
                        <td>${usuario.email}</td>
                        <td>${usuario.tipoUsuario}</td>
                        <td>${usuario.ativo ? '<span class="status realizada">Ativo</span>' : '<span class="status pendente">Inativo</span>'}</td>
                        <td>
                            <a href="usuarios?action=edit&id=${usuario.idUsuario}" class="btn">✏️ Editar</a>
                            <a href="usuarios?action=delete&id=${usuario.idUsuario}" class="btn btn-danger" onclick="return confirm('Tem certeza que deseja excluir este usuário?')">🗑️ Excluir</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
