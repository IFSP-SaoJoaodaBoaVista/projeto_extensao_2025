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

@WebServlet("/avaliacao/view")
public class AvaliacaoViewServlet extends HttpServlet {
    
    private AvaliacaoPreenchidaDAO avaliacaoDAO;
    private RespostaItemAvaliacaoDAO respostaDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        this.avaliacaoDAO = new AvaliacaoPreenchidaDAO();
        this.respostaDAO = new RespostaItemAvaliacaoDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String avaliacaoId = request.getParameter("id");
            
            if (avaliacaoId == null || avaliacaoId.isEmpty()) {
                throw new RuntimeException("ID da avaliação não fornecido");
            }
            
            // Buscar avaliação
            AvaliacaoPreenchida avaliacao = avaliacaoDAO.findById(Integer.parseInt(avaliacaoId))
                .orElseThrow(() -> new RuntimeException("Avaliação não encontrada"));
            
            // Buscar respostas
            List<RespostaItemAvaliacao> respostas = respostaDAO.findByAvaliacaoPreenchida(avaliacao);
            
            // Definir atributos para a JSP
            request.setAttribute("avaliacao", avaliacao);
            request.setAttribute("respostas", respostas);
            
            // Encaminhar para a JSP de visualização genérica
            request.getRequestDispatcher("/WEB-INF/views/avaliacoes/view.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao carregar avaliação: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }
}

