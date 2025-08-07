package com.example.pahanaedubillingsystem.backend.bo.custom;

import com.example.pahanaedubillingsystem.backend.bo.SuperBO;
import com.example.pahanaedubillingsystem.backend.dto.BillDTO;
import java.sql.SQLException;
import java.util.List;

public interface BillBO extends SuperBO {
    boolean saveBill(BillDTO dto) throws SQLException;
    BillDTO searchBill(String billId) throws SQLException;
    List<BillDTO> getAllBills() throws SQLException;
    List<String> getBillIds() throws SQLException;
    BillDTO searchByIdBill(String billId) throws SQLException;
}