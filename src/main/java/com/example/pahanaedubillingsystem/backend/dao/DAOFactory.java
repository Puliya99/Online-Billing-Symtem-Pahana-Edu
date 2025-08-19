package com.example.pahanaedubillingsystem.backend.dao;

import com.example.pahanaedubillingsystem.backend.dao.custom.impl.*;

public class DAOFactory {
    private static DAOFactory daoFactory;

    private DAOFactory() {
    }

    public static DAOFactory getDaoFactory() {
        return (daoFactory == null) ? daoFactory = new DAOFactory() : daoFactory;
    }

    public enum DAOTypes {
        CUSTOMER, ITEM, BILL, USER, VENDOR, CART, CART_ITEM;
    }

    public SuperDAO getDAO(DAOTypes types) {
        switch (types) {
            case USER:
                return new UserDAOImpl();
            case CUSTOMER:
                return new CustomerDAOImpl();
            case ITEM:
                return new ItemDAOImpl();
            case BILL:
                return new BillDAOImpl();
            case VENDOR:
                return new VendorDAOImpl();
            case CART:
                return new CartDAOImpl();
            case CART_ITEM:
                return new CartItemDAOImpl();
            default:
                return null;
        }
    }
}