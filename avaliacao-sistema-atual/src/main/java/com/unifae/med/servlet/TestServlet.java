package com.unifae.med.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/test")
public class TestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Teste do Sistema</title>");
            out.println("<meta charset='UTF-8'>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>🧪 Teste do Sistema UNIFAE</h1>");
            out.println("<p>✅ Servlet funcionando corretamente!</p>");
            out.println("<p>✅ Jakarta EE ativo</p>");
            out.println("<p>✅ Tomcat 10.1.42 operacional</p>");
            out.println("<p>✅ JDK 21 funcionando</p>");

            // Teste básico de JPA
            try {
                out.println("<h2>🗄️ Teste de Conexão JPA</h2>");

                // Importar classes necessárias
                jakarta.persistence.EntityManagerFactory emf
                        = jakarta.persistence.Persistence.createEntityManagerFactory("unifae-med-pu");
                jakarta.persistence.EntityManager em = emf.createEntityManager();

                // Teste simples de query
                Long count = em.createQuery("SELECT COUNT(u) FROM Usuario u", Long.class).getSingleResult();

                out.println("<p>✅ Conexão JPA estabelecida</p>");
                out.println("<p>✅ Total de usuários no banco: " + count + "</p>");

                em.close();
                emf.close();

            } catch (Exception e) {
                out.println("<p>❌ Erro na conexão JPA: " + e.getMessage() + "</p>");
                out.println("<p>Detalhes: " + e.getClass().getSimpleName() + "</p>");
                e.printStackTrace();
            }

            out.println("<hr>");
            out.println("<p><a href='" + request.getContextPath() + "/'>🏠 Voltar ao Início</a></p>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}
