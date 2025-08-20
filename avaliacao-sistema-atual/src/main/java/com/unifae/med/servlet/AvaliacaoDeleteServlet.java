package com.unifae.med.servlet;

import com.unifae.med.dao.AvaliacaoPreenchidaDAO;
import com.unifae.med.dao.RespostaItemAvaliacaoDAO;
import com.unifae.med.entity.AvaliacaoPreenchida;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/avaliacao/delete")
public class AvaliacaoDeleteServlet extends HttpServlet {
    
    private AvaliacaoPreenchidaDAO avaliacaoDAO;
    private RespostaItemAvaliacaoDAO respostaDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        this.avaliacaoDAO = new AvaliacaoPreenchidaDAO();
        this.respostaDAO = new RespostaItemAvaliacaoDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String avaliacaoId = request.getParameter("id");
            
            if (avaliacaoId == null || avaliacaoId.isEmpty()) {
                throw new RuntimeException("ID da avaliação não fornecido");
            }
            
            // Buscar avaliação
            AvaliacaoPreenchida avaliacao = avaliacaoDAO.findById(Integer.parseInt(avaliacaoId))
                .orElseThrow(() -> new RuntimeException("Avaliação não encontrada"));
            
            // Deletar respostas primeiro (devido às foreign keys)
            respostaDAO.deleteByAvaliacaoPreenchida(avaliacao);
            
            // Deletar avaliação
            avaliacaoDAO.delete(avaliacao);
            
            // Redirecionar com sucesso
            response.sendRedirect(request.getContextPath() + "/avaliacoes?deleted=true");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/avaliacoes?error=" + e.getMessage());
        }
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
            
            // Deletar respostas primeiro (devido às foreign keys)
            respostaDAO.deleteByAvaliacaoPreenchida(avaliacao);
            
            // Deletar avaliação
            avaliacaoDAO.delete(avaliacao);
            
            // Redirecionar com sucesso
            response.sendRedirect(request.getContextPath() + "/avaliacoes?deleted=true");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/avaliacoes?error=" + e.getMessage());
        }
    }
}

