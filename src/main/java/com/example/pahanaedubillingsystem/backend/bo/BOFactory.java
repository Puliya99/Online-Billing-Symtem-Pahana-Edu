package com.example.pahanaedubillingsystem.backend.bo;

import com.example.pahanaedubillingsystem.backend.bo.custom.impl.*;

public class BOFactory {
    private static BOFactory boFactory;

    private BOFactory() {
    }

    public static BOFactory getBoFactory() {
        return (boFactory == null) ? boFactory = new BOFactory() : boFactory;
    }

    public enum BOTypes {
        CUSTOMER, ITEM, BILL, USER
    }

    public SuperBO getBO(BOTypes types) {
        switch (types) {
            case USER:
                return new UserBOImpl();
            case CUSTOMER:
                return new CustomerBOImpl();
            default:
                return null;
        }
    }
}