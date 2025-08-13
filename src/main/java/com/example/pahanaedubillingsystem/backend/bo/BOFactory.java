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
        CUSTOMER, ITEM, BILL, USER, VENDOR
    }

    public SuperBO getBO(BOTypes types) {
        switch (types) {
            case USER:
                return new UserBOImpl();
            case CUSTOMER:
                return new CustomerBOImpl();
            case ITEM:
                return new ItemBOImpl();
            case BILL:
                return new BillBOImpl();
            case VENDOR:
                return new VendorBOImpl();
            default:
                return null;
        }
    }
}