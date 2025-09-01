<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Erro - Sistema UNIFAE</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/formularios.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                background-color: #f5f5f5;
            }
            .header {
                background-color: #dc3545;
                color: white;
                padding: 20px;
                margin-bottom: 20px;
                text-align: center;
                border-radius: 8px;
            }
            .container {
                max-width: 600px;
                margin: 0 auto;
            }
            .error-card {
                background: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                text-align: center;
            }
            .error-icon {
                font-size: 64px;
                margin-bottom: 20px;
            }
            .error-message {
                font-size: 18px;
                color: #495057;
                margin: 20px 0;
            }
            .error-details {
                background: #f8f9fa;
                padding: 15px;
                border-radius: 4px;
                margin: 20px 0;
                text-align: left;
            }
            .btn {
                background-color: #007bff;
                color: white;
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 5px;
                margin: 5px;
                display: inline-block;
            }
            .btn:hover {
                background-color: #0056b3;
            }
            .btn-secondary {
                background-color: #6c757d;
            }
            .btn-secondary:hover {
                background-color: #545b62;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h1>❌ Erro no Sistema</h1>
                <p>Sistema de Avaliação UNIFAE</p>
            </div>

            <div class="error-card">
                <div class="error-icon">🚫</div>

                <h2>Oops! Algo deu errado</h2>

                <div class="error-message">
                    <c:choose>
                        <c:when test="${not empty errorMessage}">
                            ${errorMessage}
                        </c:when>
                        <c:when test="${not empty exception}">
                            Ocorreu um erro interno no sistema. Por favor, tente novamente.
                        </c:when>
                        <c:otherwise>
                            Página não encontrada ou recurso indisponível.
                        </c:otherwise>
                    </c:choose>
                </div>

                <%
                    // Verificar se estamos em ambiente de desenvolvimento
                    boolean isDevelopment = "localhost".equals(request.getServerName()) || 
                                           "127.0.0.1".equals(request.getServerName());
                    if (exception != null && isDevelopment) {
                %>
                <div class="error-details">
                    <h4>Detalhes do Erro (Desenvolvimento):</h4>
                    <p><strong>Tipo:</strong> <%= exception.getClass().getSimpleName() %></p>
                    <p><strong>Mensagem:</strong> <%= exception.getMessage() != null ? exception.getMessage() : "N/A" %></p>
                </div>
                <% } %>

                <div style="margin-top: 30px;">
                    <a href="${pageContext.request.contextPath}/" class="btn">🏠 Voltar ao Início</a>
                    <a href="${pageContext.request.contextPath}/avaliacoes" class="btn btn-secondary">📋 Lista de Avaliações</a>
                </div>

                <div style="margin-top: 20px; color: #6c757d;">
                    <h4>💡 Possíveis Soluções:</h4>
                    <ul style="text-align: left; display: inline-block;">
                        <li>Verifique se o banco de dados está rodando</li>
                        <li>Execute o script de dados de teste</li>
                        <li>Verifique se todas as dependências estão instaladas</li>
                        <li>Reinicie o servidor Tomcat</li>
                    </ul>
                </div>
            </div>

            <div style="margin-top: 30px; text-align: center; color: #6c757d;">
                <p>Sistema de Avaliação UNIFAE - NetBeans 21 + Tomcat 10.1.42 + JDK21</p>
                <p>Se o problema persistir, verifique os logs do Tomcat para mais detalhes.</p>
            </div>
        </div>
    </body>
</html>

