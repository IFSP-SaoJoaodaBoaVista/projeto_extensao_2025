package com.unifae.med.servlet;

import com.unifae.med.dao.AvaliacaoPreenchidaDAO;
import com.unifae.med.dao.RespostaItemAvaliacaoDAO;
import com.unifae.med.entity.AvaliacaoPreenchida;
import com.unifae.med.entity.RespostaItemAvaliacao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/debug")
public class DebugServlet extends HttpServlet {
    
    private AvaliacaoPreenchidaDAO avaliacaoDAO = new AvaliacaoPreenchidaDAO();
    private RespostaItemAvaliacaoDAO respostaDAO = new RespostaItemAvaliacaoDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String avaliacaoId = request.getParameter("id");
            if (avaliacaoId == null) {
                avaliacaoId = "1"; // padrão
            }
            
            // Carregar avaliação
            AvaliacaoPreenchida avaliacao = avaliacaoDAO.findById(Integer.parseInt(avaliacaoId))
                .orElseThrow(() -> new RuntimeException("Avaliação não encontrada"));
            
            // Carregar respostas
            List<RespostaItemAvaliacao> respostas = respostaDAO.findByAvaliacaoPreenchida(avaliacao);
            
            // Passar para JSP
            request.setAttribute("avaliacao", avaliacao);
            request.setAttribute("respostas", respostas);
            
            request.getRequestDispatcher("/debug.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Erro: " + e.getMessage());
        }
    }
}

