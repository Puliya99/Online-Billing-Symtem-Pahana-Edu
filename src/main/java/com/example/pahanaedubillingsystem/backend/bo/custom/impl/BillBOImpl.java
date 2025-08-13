package com.example.pahanaedubillingsystem.backend.bo.custom.impl;

import com.example.pahanaedubillingsystem.backend.bo.custom.BillBO;
import com.example.pahanaedubillingsystem.backend.dao.DAOFactory;
import com.example.pahanaedubillingsystem.backend.dao.SQLUtil;
import com.example.pahanaedubillingsystem.backend.dao.custom.BillDAO;
import com.example.pahanaedubillingsystem.backend.dao.custom.ItemDAO;
import com.example.pahanaedubillingsystem.backend.dto.BillDTO;
import com.example.pahanaedubillingsystem.backend.entity.Bill;
import com.example.pahanaedubillingsystem.backend.entity.Item;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BillBOImpl implements BillBO {
    private final BillDAO billDAO = (BillDAO) DAOFactory.getDaoFactory().getDAO(DAOFactory.DAOTypes.BILL);
    private final ItemDAO itemDAO = (ItemDAO) DAOFactory.getDaoFactory().getDAO(DAOFactory.DAOTypes.ITEM);

    @Override
    public boolean saveBill(BillDTO dto) throws SQLException {
        Item item = itemDAO.search(dto.getItemId());
        if (item == null) return false;
        if (item.getQty() < dto.getQty()) {
            return false;
        }
        boolean saved = billDAO.save(new Bill(dto.getBillId(), dto.getBillDate(), dto.getAccountNo(), dto.getItemId(), dto.getQty(), dto.getUnitPrice(), dto.getDiscount(), dto.getTotalAmount()));
        if (!saved) return false;
        Boolean updated = SQLUtil.execute("UPDATE items SET qty = qty - ? WHERE item_id = ?", dto.getQty(), dto.getItemId());
        return Boolean.TRUE.equals(updated);
    }

    @Override
    public boolean updateBill(BillDTO dto) throws SQLException {
        return billDAO.update(new Bill(dto.getBillId(), dto.getBillDate(), dto.getAccountNo(), dto.getItemId(), dto.getQty(), dto.getUnitPrice(), dto.getDiscount(), dto.getTotalAmount()));
    }

    @Override
    public boolean deleteBill(String billId) throws SQLException {
        return billDAO.delete(billId);
    }

    @Override
    public BillDTO searchBill(String billId) throws SQLException {
        Bill bill = billDAO.search(billId);
        if (bill != null) {
            return new BillDTO(bill.getBillId(), bill.getBillDate(), bill.getAccountNo(), bill.getItemId(), bill.getQty(), bill.getUnitPrice(), bill.getDiscount(), bill.getTotalAmount());
        }
        return null;
    }

    @Override
    public List<BillDTO> getAllBills() throws SQLException {
        List<BillDTO> bills = new ArrayList<>();
        List<Bill> all = billDAO.getAll();
        for (Bill b : all) {
            bills.add(new BillDTO(b.getBillId(), b.getBillDate(), b.getAccountNo(), b.getItemId(), b.getQty(), b.getUnitPrice(), b.getDiscount(), b.getTotalAmount()));
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
            return new BillDTO(bill.getBillId(), bill.getBillDate(), bill.getAccountNo(), bill.getItemId(), bill.getQty(), bill.getUnitPrice(), bill.getDiscount(), bill.getTotalAmount());
        }
        return null;
    }
}