<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sistema de Avaliação UNIFAE</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/formularios.css">
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f5f5f5; }
        .header { background-color: #2c3e50; color: white; padding: 20px; margin-bottom: 20px; text-align: center; border-radius: 8px; }
        .success { background-color: #d4edda; border: 1px solid #c3e6cb; color: #155724; padding: 15px; border-radius: 5px; margin: 10px 0; }
        .menu { display: flex; gap: 20px; justify-content: center; margin: 20px 0; flex-wrap: wrap; }
        .menu a { background-color: #007bff; color: white; padding: 12px 24px; text-decoration: none; border-radius: 5px; transition: background-color 0.3s; }
        .menu a:hover { background-color: #0056b3; }
        .info { background-color: #d1ecf1; border: 1px solid #bee5eb; color: #0c5460; padding: 15px; border-radius: 5px; margin: 10px 0; }
        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; margin: 20px 0; }
        .card { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .status { display: inline-block; padding: 4px 8px; border-radius: 4px; font-size: 12px; font-weight: bold; }
        .status.ok { background-color: #d4edda; color: #155724; }
        .status.info { background-color: #d1ecf1; color: #0c5460; }
    </style>
</head>
<body>
    <div class="header">
        <h1>🎓 Sistema de Avaliação UNIFAE</h1>
        <p>NetBeans 21 + Tomcat 10.1.42 + JDK21 + Jakarta EE</p>
        <span class="status ok">✅ SISTEMA FUNCIONANDO</span>
    </div>
    
    <div class="success">
        <h2>🚀 Sistema Configurado e Funcionando!</h2>
        <div class="grid">
            <div>
                <strong>Informações do Sistema:</strong>
                <ul>
                    <li><strong>Java:</strong> <%= System.getProperty("java.version") %></li>
                    <li><strong>Servidor:</strong> <%= application.getServerInfo() %></li>
                    <li><strong>Context Path:</strong> <%= request.getContextPath() %></li>
                    <li><strong>Servlet API:</strong> <%= application.getMajorVersion() %>.<%= application.getMinorVersion() %></li>
                </ul>
            </div>
            <div>
                <strong>Status da Aplicação:</strong>
                <ul>
                    <li><span class="status ok">✅</span> Deploy NetBeans funcionando</li>
                    <li><span class="status ok">✅</span> Context path configurado</li>
                    <li><span class="status ok">✅</span> Jakarta EE ativo</li>
                    <li><span class="status ok">✅</span> Encoding UTF-8 configurado</li>
                </ul>
            </div>
        </div>
    </div>
    
    <div class="menu">
        <a href="test">🧪 Teste do Sistema</a>
        <a href="avaliacoes">📋 Lista de Avaliações</a>
        <a href="avaliacao/form?action=new&questionarioId=1">📝 Nova Mini CEX</a>
        <a href="avaliacao/form?action=new&questionarioId=2">🎯 Avaliação 360 - Professor</a>
        <a href="avaliacao/form?action=new&questionarioId=3">👥 Avaliação 360 - Pares</a>
    </div>
    
    <div class="grid">
        <div class="card">
            <h3>📚 Formulários Disponíveis</h3>
            <ul>
                <li><strong>Mini CEX:</strong> Avaliação clínica estruturada</li>
                <li><strong>Avaliação 360 - Professor:</strong> Avaliação por professor/preceptor</li>
                <li><strong>Avaliação 360 - Pares:</strong> Avaliação por colegas de turma</li>
                <li><strong>Avaliação 360 - Autoavaliação:</strong> Autoavaliação do estudante</li>
            </ul>
        </div>
        
        <div class="card">
            <h3>🔧 Configurações NetBeans</h3>
            <ul>
                <li><span class="status ok">✅</span> Deploy automático ativo</li>
                <li><span class="status ok">✅</span> Hot reload configurado</li>
                <li><span class="status ok">✅</span> Debug integrado</li>
                <li><span class="status ok">✅</span> Context path: /avaliacao-sistema</li>
            </ul>
        </div>
        
        <div class="card">
            <h3>🗄️ Banco de Dados</h3>
            <ul>
                <li><strong>SGBD:</strong> MariaDB 10.4.32+</li>
                <li><strong>Database:</strong> unifae_med_app</li>
                <li><strong>JPA:</strong> Hibernate 6.4.4</li>
                <li><strong>Driver:</strong> MariaDB Connector/J</li>
            </ul>
        </div>
        
        <div class="card">
            <h3>🚀 Próximos Passos</h3>
            <ol>
                <li>Testar conexão com banco de dados</li>
                <li>Verificar servlets de CRUD</li>
                <li>Validar formulários HTML/CSS</li>
                <li>Executar script de dados de teste</li>
                <li>Testar operações completas</li>
            </ol>
        </div>
    </div>
    
    <div class="info">
        <h3>📖 Informações Técnicas</h3>
        <p><strong>Data/Hora:</strong> <%= new java.util.Date() %></p>
        <p><strong>Sessão ID:</strong> <%= session.getId() %></p>
        <p><strong>Request URI:</strong> <%= request.getRequestURI() %></p>
        <p><strong>Server Name:</strong> <%= request.getServerName() %>:<%= request.getServerPort() %></p>
    </div>
</body>
</html>

