<%--
    INDEX.JSP - PÁGINA INICIAL DO SISTEMA DE AVALIAÇÃO UNIFAE
    ==========================================================
    
    Esta é a página inicial (landing page) do Sistema de Avaliação UNIFAE.
    Combina tecnologias JSP, HTML5 e CSS3 para criar uma interface que serve
    como ponto de entrada para todas as funcionalidades.
    
    RESPONSABILIDADES:
    - Apresentar status do sistema e informações técnicas
    - Fornecer navegação principal para funcionalidades
    - Exibir menu dropdown para criação de avaliações
    - Mostrar informações de configuração e ambiente
    - Servir como dashboard inicial para usuários
    
    TECNOLOGIAS UTILIZADAS:
    - JSP (JavaServer Pages): Geração dinâmica de conteúdo
    - HTML5: Estrutura semântica da página
    - CSS3: Estilização moderna e responsiva
    - JavaScript: Interatividade (menu dropdown)
    
    RELACIONAMENTO COM OUTROS ARQUIVOS:
    - css/formularios.css: Estilos compartilhados do sistema
    - Servlets: Links para controladores (test, avaliacoes, avaliacao/form)
    - web.xml: Configuração de context path e encoding
    - Outras JSPs: Navegação para formulários e listagens
    
    PADRÃO MVC:
    - View: Esta página JSP (apresentação)
    - Controller: Servlets referenciados nos links
    - Model: Dados do sistema exibidos dinamicamente
    
    FUNCIONALIDADES:
    - Menu de navegação principal
    - Menu dropdown para tipos de avaliação
    - Informações técnicas do ambiente
    - Status de configuração do sistema
    - Links para funcionalidades principais
--%>

<%--
    DIRETIVA PAGE
    =============
    Define configurações básicas da página JSP.
    - contentType: Tipo MIME e encoding da resposta
    - language: Linguagem de script (Java)
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
    <head>
        <%-- META INFORMAÇÕES E CONFIGURAÇÕES --%>
        <title>Sistema de Avaliação UNIFAE</title>
        <meta charset="UTF-8">
        <%-- Viewport para responsividade mobile --%>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <%-- 
            IMPORTAÇÃO DE CSS EXTERNO
            =========================
            Importa estilos compartilhados do sistema.
            Caminho relativo ao context root da aplicação.
        --%>
        <link rel="stylesheet" href="css/formularios.css">
        
        <%--
            ESTILOS CSS INTERNOS
            ====================
            Estilos específicos para esta página.
            Inclui layout responsivo, cores do tema e componentes.
        --%>
        <style>
            /* ===== ESTILOS GLOBAIS ===== */
            body {
                font-family: Arial, sans-serif;    /* Fonte padrão do sistema */
                margin: 20px;                      /* Margem externa */
                background-color: #f5f5f5;        /* Cor de fundo neutra */
            }
            
            /* ===== CABEÇALHO PRINCIPAL ===== */
            .header {
                background-color: #007bff;         /* Azul tema UNIFAE */
                color: white;                      /* Texto branco */
                padding: 20px;                     /* Espaçamento interno */
                margin-bottom: 20px;               /* Espaço abaixo */
                text-align: center;                /* Centralização */
                border-radius: 8px;                /* Bordas arredondadas */
            }
            
            /* ===== MENSAGENS DE SUCESSO ===== */
            .success {
                background-color: #d4edda;         /* Verde claro */
                border: 1px solid #c3e6cb;         /* Borda verde */
                color: #155724;                    /* Texto verde escuro */
                padding: 15px;                     /* Espaçamento interno */
                border-radius: 5px;                /* Bordas arredondadas */
                margin: 10px 0;                    /* Margem vertical */
            }
            
            /* ===== MENU PRINCIPAL ===== */
            .menu {
                display: flex;                     /* Layout flexível */
                gap: 20px;                         /* Espaço entre itens */
                justify-content: center;           /* Centralização horizontal */
                margin: 20px 0;                    /* Margem vertical */
                flex-wrap: wrap;                   /* Quebra linha se necessário */
            }
            
            /* Links do menu principal */
            .menu a {
                background-color: #007bff;         /* Cor de fundo azul */
                color: white;                      /* Texto branco */
                padding: 12px 24px;                /* Espaçamento interno */
                text-decoration: none;             /* Remove sublinhado */
                border-radius: 5px;                /* Bordas arredondadas */
                transition: background-color 0.3s; /* Animação suave */
            }
            
            /* Efeito hover nos links */
            .menu a:hover {
                background-color: #0056b3;         /* Azul mais escuro */
            }

            /* ===== MENU DROPDOWN ===== */
            /* Container do dropdown */
            .dropdown {
                position: relative;                /* Posicionamento relativo */
                display: inline-block;             /* Display inline-block */
            }

            /* Botão principal do dropdown */
            .dropdown .btn-menu {
                background-color: #28a745;         /* Verde para diferenciar */
                color: white;                      /* Texto branco */
                padding: 12px 24px;                /* Espaçamento interno */
                text-decoration: none;             /* Remove sublinhado */
                border-radius: 5px;                /* Bordas arredondadas */
                border: none;                      /* Remove borda padrão */
                cursor: pointer;                   /* Cursor de clique */
                font-family: Arial, sans-serif;    /* Fonte consistente */
                font-size: 14px;                   /* Tamanho da fonte */
                transition: background-color 0.3s; /* Animação suave */
            }

            /* Efeito hover no botão dropdown */
            .dropdown:hover .btn-menu {
                background-color: #218838;         /* Verde mais escuro */
            }

            /* Container do conteúdo dropdown */
            .dropdown-content {
                display: none;                     /* Oculto por padrão */
                position: absolute;                /* Posicionamento absoluto */
                background-color: #f1f1f1;        /* Fundo cinza claro */
                min-width: 260px;                  /* Largura mínima */
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); /* Sombra */
                z-index: 1;                        /* Camada superior */
                border-radius: 5px;                /* Bordas arredondadas */
                overflow: hidden;                  /* Oculta overflow */
            }

            /* Links dentro do dropdown */
            .dropdown-content a {
                color: black;                      /* Texto preto */
                padding: 12px 16px;                /* Espaçamento interno */
                text-decoration: none;             /* Remove sublinhado */
                display: block;                    /* Display em bloco */
                background-color: #f1f1f1;        /* Fundo cinza */
                text-align: left;                  /* Alinhamento à esquerda */
                border-radius: 0;                  /* Remove bordas arredondadas */
            }

            /* Efeito hover nos links do dropdown */
            .dropdown-content a:hover {
                background-color: #ddd;            /* Cinza mais escuro */
            }

            /* Mostra dropdown no hover */
            .dropdown:hover .dropdown-content {
                display: block;                    /* Exibe conteúdo */
            }

            /* ===== MENSAGENS INFORMATIVAS ===== */
            .info {
                background-color: #d1ecf1;         /* Azul claro */
                border: 1px solid #bee5eb;         /* Borda azul */
                color: #0c5460;                    /* Texto azul escuro */
                padding: 15px;                     /* Espaçamento interno */
                border-radius: 5px;                /* Bordas arredondadas */
                margin: 10px 0;                    /* Margem vertical */
            }
            
            /* ===== LAYOUT GRID RESPONSIVO ===== */
            .grid {
                display: grid;                     /* Layout grid */
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); /* Colunas responsivas */
                gap: 20px;                         /* Espaço entre itens */
                margin: 20px 0;                    /* Margem vertical */
            }
            
            /* ===== CARDS DE CONTEÚDO ===== */
            .card {
                background: white;                 /* Fundo branco */
                padding: 20px;                     /* Espaçamento interno */
                border-radius: 8px;                /* Bordas arredondadas */
                box-shadow: 0 2px 4px rgba(0,0,0,0.1); /* Sombra sutil */
            }
            
            /* ===== INDICADORES DE STATUS ===== */
            .status {
                display: inline-block;             /* Display inline-block */
                padding: 4px 8px;                  /* Espaçamento interno */
                border-radius: 4px;                /* Bordas arredondadas */
                font-size: 12px;                   /* Fonte pequena */
                font-weight: bold;                 /* Texto em negrito */
            }
            
            /* Status OK (verde) */
            .status.ok {
                background-color: #d4edda;         /* Fundo verde claro */
                color: #155724;                    /* Texto verde escuro */
            }
            
            /* Status Info (azul) */
            .status.info {
                background-color: #007bff;         /* Fundo azul */
                color: #0c5460;                    /* Texto azul escuro */
            }
        </style>
    </head>
    <body>
        <%--
            CABEÇALHO PRINCIPAL
            ===================
            Seção de apresentação do sistema com informações básicas.
        --%>
        <div class="header">
            <h1>🎓 Sistema de Avaliação UNIFAE</h1>
            <p>NetBeans 21 + Tomcat 10.1.42 + JDK21 + Jakarta EE</p>
            <span class="status ok">✅ SISTEMA FUNCIONANDO</span>
        </div>

        <%--
            SEÇÃO DE STATUS DO SISTEMA
            ==========================
            Exibe informações dinâmicas sobre o ambiente e configuração.
            Usa scriptlets JSP para obter dados do servidor.
        --%>
        <div class="success">
            <h2>🚀 Sistema Configurado e Funcionando!</h2>
            <div class="grid">
                <div>
                    <strong>Informações do Sistema:</strong>
                    <ul>
                        <%-- 
                            SCRIPTLETS JSP
                            ==============
                            Código Java executado no servidor para obter informações dinâmicas.
                        --%>
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

        <%--
            MENU PRINCIPAL DE NAVEGAÇÃO
            ===========================
            Links para as principais funcionalidades do sistema.
            Inclui menu dropdown para tipos de avaliação.
        --%>
        <div class="menu">
            <%-- Link para servlet de teste --%>
            <a href="test">🧪 Teste do Sistema</a>
            
            <%-- Link para listagem de avaliações --%>
            <a href="avaliacoes">📋 Lista de Avaliações</a>

            <%--
                MENU DROPDOWN PARA NOVA AVALIAÇÃO
                ==================================
                Menu suspenso com diferentes tipos de avaliação.
                Cada link passa parâmetros específicos para o servlet.
            --%>
            <div class="dropdown">
                <button class="btn-menu">📝 Nova Avaliação ▼</button>
                <div class="dropdown-content">
                    <%-- 
                        LINKS PARA FORMULÁRIOS ESPECÍFICOS
                        ==================================
                        Cada link inclui parâmetros para identificar:
                        - action=new: Indica criação de nova avaliação
                        - questionarioId: ID do tipo de questionário
                    --%>
                    <a href="avaliacao/form?action=new&questionarioId=1">📝 Nova Mini CEX</a>
                    <a href="avaliacao/form?action=new&questionarioId=2">🎯 Avaliação 360 - Professor</a>
                    <a href="avaliacao/form?action=new&questionarioId=3">👥 Avaliação 360 - Pares</a>
                    <a href="avaliacao/form?action=new&questionarioId=4">⚕️ Avaliação 360 - Equipe</a>
                    <a href="avaliacao/form?action=new&questionarioId=5">🩺 Avaliação 360 - Paciente</a>
                </div>
            </div>
        </div>
        
        <%--
            GRID DE CARDS INFORMATIVOS
            ==========================
            Layout responsivo com informações organizadas em cards.
        --%>
        <div class="grid">
            <%-- Card com tipos de formulários disponíveis --%>
            <div class="card">
                <h3>📚 Formulários Disponíveis</h3>
                <ul>
                    <li><strong>Mini CEX:</strong> Avaliação clínica estruturada</li>
                    <li><strong>Avaliação 360 - Professor:</strong> Avaliação por professor/preceptor</li>
                    <li><strong>Avaliação 360 - Pares:</strong> Avaliação por colegas de turma</li>
                    <li><strong>Avaliação 360 - Equipe:</strong> Avaliação por profissionais não médicos</li>
                    <li><strong>Avaliação 360 - Paciente:</strong> Avaliação do paciente ou da família</li>
                </ul>
            </div>

            <%-- Card com configurações do NetBeans --%>
            <div class="card">
                <h3>🔧 Configurações NetBeans</h3>
                <ul>
                    <li><span class="status ok">✅</span> Deploy automático ativo</li>
                    <li><span class="status ok">✅</span> Hot reload configurado</li>
                    <li><span class="status ok">✅</span> Debug integrado</li>
                    <li><span class="status ok">✅</span> Context path: /avaliacao-sistema</li>
                </ul>
            </div>

            <%-- Card com informações do banco de dados --%>
            <div class="card">
                <h3>🗄️ Banco de Dados</h3>
                <ul>
                    <li><strong>SGBD:</strong> MariaDB 10.4.32+</li>
                    <li><strong>Database:</strong> unifae_med_app</li>
                    <li><strong>JPA:</strong> Hibernate 6.4.4</li>
                    <li><strong>Driver:</strong> MariaDB Connector/J</li>
                </ul>
            </div>

            <%-- Card com próximos passos --%>
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

        <%--
            SEÇÃO DE INFORMAÇÕES TÉCNICAS
            ==============================
            Dados técnicos da sessão e requisição atual.
            Útil para debug e monitoramento.
        --%>
        <div class="info">
            <h3>📖 Informações Técnicas</h3>
            <%-- Data/hora atual do servidor --%>
            <p><strong>Data/Hora:</strong> <%= new java.util.Date() %></p>
            <%-- ID da sessão HTTP --%>
            <p><strong>Sessão ID:</strong> <%= session.getId() %></p>
            <%-- URI da requisição atual --%>
            <p><strong>Request URI:</strong> <%= request.getRequestURI() %></p>
            <%-- Nome e porta do servidor --%>
            <p><strong>Server Name:</strong> <%= request.getServerName() %>:<%= request.getServerPort() %></p>
        </div>
    </body>
</html>

