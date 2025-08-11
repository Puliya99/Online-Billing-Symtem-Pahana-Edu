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

@WebServlet(name = "UserModel", urlPatterns = "/UserModel", loadOnStartup = 4)
public class UserController extends HttpServlet {
    private final static Logger logger = LoggerFactory.getLogger(UserController.class);
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final UserBO userBO = (UserBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.USER);

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");
        try {
            UserDTO user = objectMapper.readValue(req.getInputStream(), UserDTO.class);
            boolean isValid = userBO.validateUser(user.getUsername(), user.getPassword());
            if (isValid) {
                req.getSession(true).setAttribute("username", user.getUsername());
            }
            resp.getWriter().write(isValid ? "valid" : "invalid");
            logger.info(isValid ? "User Authenticated" : "User Authentication Failed");
        } catch (Exception e) {
            logger.error("User Authentication Error", e);
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write("invalid");
        }
    }
}