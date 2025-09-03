<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Gerenciamento de Turmas</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/formularios.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Gerenciamento de Turmas</h1>
        </div>
        <div class="actions menu">
             <a href="${pageContext.request.contextPath}/" class="btn">🏠 Voltar ao Início</a>
             <a href="${pageContext.request.contextPath}/admin/turmas?action=new" class="btn btn-primary">Nova Turma</a>
        </div>
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome da Turma</th>
                    <th>Código</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="turma" items="${listTurmas}">
                    <tr>
                        <td>${turma.idTurma}</td>
                        <td>${turma.nomeTurma}</td>
                        <td>${turma.codigoTurma}</td>
                        <td>
                            <a href="turmas?action=edit&id=${turma.idTurma}" class="btn">✏️ Editar</a>
                            <a href="turmas?action=delete&id=${turma.idTurma}" class="btn btn-danger" onclick="return confirm('Tem certeza que deseja excluir esta turma?')">🗑️ Excluir</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
