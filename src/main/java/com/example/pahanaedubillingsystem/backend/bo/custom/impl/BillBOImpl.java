package com.example.pahanaedubillingsystem.backend.bo.custom.impl;

import com.example.pahanaedubillingsystem.backend.bo.custom.BillBO;
import com.example.pahanaedubillingsystem.backend.dao.DAOFactory;
import com.example.pahanaedubillingsystem.backend.dao.custom.BillDAO;
import com.example.pahanaedubillingsystem.backend.dao.custom.CartDAO;
import com.example.pahanaedubillingsystem.backend.dao.custom.CartItemDAO;
import com.example.pahanaedubillingsystem.backend.dao.custom.ItemDAO;
import com.example.pahanaedubillingsystem.backend.dao.custom.CustomerDAO;
import com.example.pahanaedubillingsystem.backend.dto.BillDTO;
import com.example.pahanaedubillingsystem.backend.entity.Bill;
import com.example.pahanaedubillingsystem.backend.entity.Cart_Item;
import com.example.pahanaedubillingsystem.backend.entity.Item;
import com.example.pahanaedubillingsystem.backend.entity.Customer;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BillBOImpl implements BillBO {
    private final BillDAO billDAO = (BillDAO) DAOFactory.getDaoFactory().getDAO(DAOFactory.DAOTypes.BILL);
    private final CartDAO cartDAO = (CartDAO) DAOFactory.getDaoFactory().getDAO(DAOFactory.DAOTypes.CART);
    private final CartItemDAO cartItemDAO = (CartItemDAO) DAOFactory.getDaoFactory().getDAO(DAOFactory.DAOTypes.CART_ITEM);
    private final ItemDAO itemDAO = (ItemDAO) DAOFactory.getDaoFactory().getDAO(DAOFactory.DAOTypes.ITEM);
    private final CustomerDAO customerDAO = (CustomerDAO) DAOFactory.getDaoFactory().getDAO(DAOFactory.DAOTypes.CUSTOMER);

    @Override
    public boolean saveBill(BillDTO dto) throws SQLException {
        boolean saved = billDAO.save(new Bill(dto.getBillId(), dto.getBillDate(), dto.getAccountNo(), dto.getCartId(), dto.getDiscount(), dto.getTotalAmount()));
        if (!saved) return false;

        int totalQtyInCart = 0;

        if (dto.getCartId() != null && !dto.getCartId().isEmpty()) {
            List<Cart_Item> cartItems = cartItemDAO.findByCartId(dto.getCartId());
            for (Cart_Item ci : cartItems) {
                Item item = itemDAO.searchById(ci.getItemId());
                if (item != null) {
                    int currentQty = item.getQty();
                    int newQty = currentQty - ci.getQty();
                    if (newQty < 0) newQty = 0;
                    item.setQty(newQty);
                    itemDAO.update(item);
                }
                totalQtyInCart += ci.getQty();
            }
        }

        if (dto.getAccountNo() != null && !dto.getAccountNo().isEmpty() && totalQtyInCart > 0) {
            Customer customer = customerDAO.searchById(dto.getAccountNo());
            if (customer != null) {
                int currentUnits = customer.getUnitsConsumed();
                customer.setUnitsConsumed(currentUnits + totalQtyInCart);
                customerDAO.update(customer);
            }
        }

        return true;
    }

    @Override
    public boolean updateBill(BillDTO dto) throws SQLException {
        Bill existing = billDAO.searchById(dto.getBillId());
        if (existing != null) {
            String oldCartId = existing.getCartId();
            if (oldCartId != null && !oldCartId.isEmpty()) {
                List<Cart_Item> oldItems = cartItemDAO.findByCartId(oldCartId);
                for (Cart_Item ci : oldItems) {
                    Item item = itemDAO.searchById(ci.getItemId());
                    if (item != null) {
                        item.setQty(item.getQty() + ci.getQty());
                        itemDAO.update(item);
                    }
                }
            }
            String oldAccount = existing.getAccountNo();
            if (oldAccount != null && !oldAccount.isEmpty()) {
                int totalQty = 0;
                if (existing.getCartId() != null && !existing.getCartId().isEmpty()) {
                    for (Cart_Item ci : cartItemDAO.findByCartId(existing.getCartId())) {
                        totalQty += ci.getQty();
                    }
                }
                if (totalQty > 0) {
                    Customer oldCus = customerDAO.searchById(oldAccount);
                    if (oldCus != null) {
                        int newUnits = oldCus.getUnitsConsumed() - totalQty;
                        if (newUnits < 0) newUnits = 0;
                        oldCus.setUnitsConsumed(newUnits);
                        customerDAO.update(oldCus);
                    }
                }
            }
        }
        String newCartId = dto.getCartId();
        int newTotalQty = 0;
        if (newCartId != null && !newCartId.isEmpty()) {
            List<Cart_Item> newItems = cartItemDAO.findByCartId(newCartId);
            for (Cart_Item ci : newItems) {
                Item item = itemDAO.searchById(ci.getItemId());
                if (item != null) {
                    int newQty = item.getQty() - ci.getQty();
                    if (newQty < 0) newQty = 0;
                    item.setQty(newQty);
                    itemDAO.update(item);
                }
                newTotalQty += ci.getQty();
            }
        }
        if (dto.getAccountNo() != null && !dto.getAccountNo().isEmpty() && newTotalQty > 0) {
            Customer newCus = customerDAO.searchById(dto.getAccountNo());
            if (newCus != null) {
                newCus.setUnitsConsumed(newCus.getUnitsConsumed() + newTotalQty);
                customerDAO.update(newCus);
            }
        }
        return billDAO.update(new Bill(dto.getBillId(), dto.getBillDate(), dto.getAccountNo(), dto.getCartId(), dto.getDiscount(), dto.getTotalAmount()));
    }

    @Override
    public boolean deleteBill(String billId) throws SQLException {
        Bill existing = billDAO.searchById(billId);
        if (existing != null) {
            String cartId = existing.getCartId();
            int totalQty = 0;
            if (cartId != null && !cartId.isEmpty()) {
                List<Cart_Item> items = cartItemDAO.findByCartId(cartId);
                for (Cart_Item ci : items) {
                    Item item = itemDAO.searchById(ci.getItemId());
                    if (item != null) {
                        item.setQty(item.getQty() + ci.getQty());
                        itemDAO.update(item);
                    }
                    totalQty += ci.getQty();
                }
            }
            String account = existing.getAccountNo();
            if (account != null && !account.isEmpty() && totalQty > 0) {
                Customer cus = customerDAO.searchById(account);
                if (cus != null) {
                    int newUnits = cus.getUnitsConsumed() - totalQty;
                    if (newUnits < 0) newUnits = 0;
                    cus.setUnitsConsumed(newUnits);
                    customerDAO.update(cus);
                }
            }
        }
        return billDAO.delete(billId);
    }

    @Override
    public BillDTO searchBill(String billId) throws SQLException {
        Bill bill = billDAO.search(billId);
        if (bill != null) {
            return new BillDTO(bill.getBillId(), bill.getBillDate(), bill.getAccountNo(), bill.getCartId(), bill.getDiscount(), bill.getTotalAmount());
        }
        return null;
    }

    @Override
    public List<BillDTO> getAllBills() throws SQLException {
        List<BillDTO> bills = new ArrayList<>();
        List<Bill> all = billDAO.getAll();
        for (Bill b : all) {
            bills.add(new BillDTO(b.getBillId(), b.getBillDate(), b.getAccountNo(), b.getCartId(), b.getDiscount(), b.getTotalAmount()));
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
            return new BillDTO(bill.getBillId(), bill.getBillDate(), bill.getAccountNo(), bill.getCartId(), bill.getDiscount(), bill.getTotalAmount());
        }
        return null;
    }
}