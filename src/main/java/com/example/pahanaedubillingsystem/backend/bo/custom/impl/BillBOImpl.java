package com.example.pahanaedubillingsystem.backend.bo.custom.impl;

import com.example.pahanaedubillingsystem.backend.bo.custom.BillBO;
import com.example.pahanaedubillingsystem.backend.dao.DAOFactory;
import com.example.pahanaedubillingsystem.backend.dao.custom.BillDAO;
import com.example.pahanaedubillingsystem.backend.dto.BillDTO;
import com.example.pahanaedubillingsystem.backend.entity.Bill;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BillBOImpl implements BillBO {
    private final BillDAO billDAO = (BillDAO) DAOFactory.getDaoFactory().getDAO(DAOFactory.DAOTypes.BILL);

    @Override
    public boolean saveBill(BillDTO dto) throws SQLException {
        return billDAO.save(new Bill(dto.getBillId(), dto.getBillDate(), dto.getAccountNo(), dto.getTotalAmount()));
    }

    @Override
    public BillDTO searchBill(String billId) throws SQLException {
        Bill bill = billDAO.search(billId);
        if (bill != null) {
            return new BillDTO(bill.getBillId(), bill.getBillDate(), bill.getAccountNo(), bill.getTotalAmount());
        }
        return null;
    }

    @Override
    public List<BillDTO> getAllBills() throws SQLException {
        List<BillDTO> bills = new ArrayList<>();
        List<Bill> all = billDAO.getAll();
        for (Bill b : all) {
            bills.add(new BillDTO(b.getBillId(), b.getBillDate(), b.getAccountNo(), b.getTotalAmount()));
        }
        return bills;
    }

    @Override
    public List<String> getBillIds() throws SQLException {
        return billDAO.getIds();
    }

    @Override
    public BillDTO searchByIdBill(String billId) throws SQLException {
        Bill bill = billDAO.searchById(billId);
        if (bill != null) {
            return new BillDTO(bill.getBillId(), bill.getBillDate(), bill.getAccountNo(), bill.getTotalAmount());
        }
        return null;
    }
}