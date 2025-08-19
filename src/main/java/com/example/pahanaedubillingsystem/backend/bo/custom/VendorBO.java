package com.example.pahanaedubillingsystem.backend.bo.custom;

import com.example.pahanaedubillingsystem.backend.bo.SuperBO;
import com.example.pahanaedubillingsystem.backend.dto.CustomerDTO;
import com.example.pahanaedubillingsystem.backend.dto.VendorDTO;

import java.sql.SQLException;
import java.util.List;

public interface VendorBO extends SuperBO {
    boolean saveVendor(VendorDTO dto) throws SQLException;
    boolean updateVendor(VendorDTO dto) throws SQLException;
    boolean deleteVendor(String grnId) throws SQLException;
    VendorDTO searchVendor(String grnId) throws SQLException;
    List<VendorDTO> getAllVendors() throws SQLException;
    List<String> getVendorIds() throws SQLException;
    VendorDTO searchByIdVendor(String grnId) throws SQLException;
}
