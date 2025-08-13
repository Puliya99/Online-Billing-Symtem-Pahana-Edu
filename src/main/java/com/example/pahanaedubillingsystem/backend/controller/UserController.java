package com.example.pahanaedubillingsystem.backend.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.example.pahanaedubillingsystem.backend.bo.BOFactory;
import com.example.pahanaedubillingsystem.backend.bo.custom.UserBO;
import com.example.pahanaedubillingsystem.backend.dto.UserDTO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserModel", urlPatterns = "/UserModel", loadOnStartup = 4)
public class UserController extends HttpServlet {
    private final static Logger logger = LoggerFactory.getLogger(UserController.class);
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final UserBO userBO = (UserBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.USER);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        try {
            List<UserDTO> users = userBO.getAllUsers();
            objectMapper.writeValue(resp.getWriter(), users);
        } catch (Exception e) {
            logger.error("Error fetching users", e);
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("[]");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");
        try {
            UserDTO user = objectMapper.readValue(req.getInputStream(), UserDTO.class);
            boolean saved = userBO.saveUser(user);
            resp.getWriter().write(saved ? "saved" : "not saved");
            logger.info(saved ? "User Saved" : "User Save Failed");
        } catch (Exception e) {
            logger.error("User Save Error", e);
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("not saved");
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");
        try {
            UserDTO user = objectMapper.readValue(req.getInputStream(), UserDTO.class);
            boolean updated = userBO.updateUser(user);
            resp.getWriter().write(updated ? "updated" : "not updated");
            logger.info(updated ? "User Updated" : "User Update Failed");
        } catch (Exception e) {
            logger.error("User Update Error", e);
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("not updated");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");
        try {
            String username = req.getParameter("username");
            boolean deleted = username != null && userBO.deleteUser(username);
            resp.getWriter().write(deleted ? "deleted" : "not deleted");
            logger.info(deleted ? "User Deleted" : "User Delete Failed");
        } catch (Exception e) {
            logger.error("User Delete Error", e);
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("not deleted");
        }
    }
}