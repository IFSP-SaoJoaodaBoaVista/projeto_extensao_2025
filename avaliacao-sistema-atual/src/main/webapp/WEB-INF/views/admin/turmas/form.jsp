<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>${action == 'edit' ? 'Editar' : 'Nova'} Turma</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/formularios.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>${action == 'edit' ? 'Editar Turma' : 'Nova Turma'}</h1>
        </div>
        <form action="${pageContext.request.contextPath}/admin/turmas" method="post">
            <c:if test="${turma != null}">
                <input type="hidden" name="idTurma" value="${turma.idTurma}" />
            </c:if>

            <div class="form-section">
                <div class="form-group">
                    <label for="nomeTurma">Nome da Turma:</label>
                    <input type="text" id="nomeTurma" name="nomeTurma" value="${turma.nomeTurma}" required>
                </div>
                <div class="form-group">
                    <label for="codigoTurma">Código da Turma:</label>
                    <input type="text" id="codigoTurma" name="codigoTurma" value="${turma.codigoTurma}">
                </div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Salvar</button>
                <a href="${pageContext.request.contextPath}/admin/turmas" class="btn btn-secondary">Cancelar</a>
            </div>
        </form>
    </div>
</body>
</html>
