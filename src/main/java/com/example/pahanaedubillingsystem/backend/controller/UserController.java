package com.example.pahanaedubillingsystem.backend.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.example.pahanaedubillingsystem.backend.dto.UserDTO;
import com.example.pahanaedubillingsystem.backend.util.CrudUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

@WebServlet(name = "UserModel", urlPatterns = "/UserModel", loadOnStartup = 4)
public class UserController extends HttpServlet {
    private final static Logger logger = LoggerFactory.getLogger(UserController.class);
    private ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            UserDTO user = objectMapper.readValue(req.getInputStream(), UserDTO.class);
            boolean isValid = CrudUtil.getInstance().validateUser(user.getUsername(), user.getPassword());
            resp.getWriter().write(isValid ? "valid" : "invalid");
            logger.info(isValid ? "User Authenticated" : "User Authentication Failed");
        } catch (Exception e) {
            logger.error("User Authentication Error", e);
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error authenticating user");
        }
    }
}
