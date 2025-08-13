package com.example.pahanaedubillingsystem.backend.bo.custom.impl;

import com.example.pahanaedubillingsystem.backend.bo.custom.VendorBO;
import com.example.pahanaedubillingsystem.backend.dao.DAOFactory;
import com.example.pahanaedubillingsystem.backend.dao.SQLUtil;
import com.example.pahanaedubillingsystem.backend.dao.custom.VendorDAO;
import com.example.pahanaedubillingsystem.backend.dto.VendorDTO;
import com.example.pahanaedubillingsystem.backend.entity.Vendor;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VendorBOImpl implements VendorBO {
    private final VendorDAO vendorDAO = (VendorDAO) DAOFactory.getDaoFactory().getDAO(DAOFactory.DAOTypes.VENDOR);
    @Override
    public boolean saveVendor(VendorDTO dto) throws SQLException {
        boolean saved = vendorDAO.save(new Vendor(dto.getGrnId(), dto.getName(), dto.getItemId(), dto.getDescription(), dto.getQty(), dto.getBuyingPrice()));
        if (!saved) return false;
        Boolean updated = SQLUtil.execute("UPDATE items SET qty = qty + ? WHERE item_id = ?", dto.getQty(), dto.getItemId());
        return Boolean.TRUE.equals(updated);
    }

    @Override
    public boolean updateVendor(VendorDTO dto) throws SQLException {
        return vendorDAO.update(new Vendor(dto.getGrnId(), dto.getName(), dto.getItemId(), dto.getDescription(), dto.getQty(), dto.getBuyingPrice()));
    }

    @Override
    public boolean deleteVendor(String grnId) throws SQLException {
        return vendorDAO.delete(grnId);
    }

    @Override
    public VendorDTO searchVendor(String grnId) throws SQLException {
        Vendor vendor = vendorDAO.search(grnId);
        if (vendor != null) {
            return new VendorDTO(vendor.getGrnId(), vendor.getName(), vendor.getItemId(), vendor.getDescription(), vendor.getQty(), vendor.getBuyingPrice());
        }
        return null;
    }

    @Override
    public List<VendorDTO> getAllVendors() throws SQLException {
        List<VendorDTO> vendors = new ArrayList<>();
        List<Vendor> all = vendorDAO.getAll();
        for (Vendor v : all) {
            vendors.add(new VendorDTO(v.getGrnId(), v.getName(), v.getItemId(), v.getDescription(), v.getQty(), v.getBuyingPrice()));
        }
        return vendors;
    }

    @Override
    public List<String> getVendorIds() throws SQLException {
        return vendorDAO.getIds();
    }

    @Override
    public VendorDTO searchByIdVendor(String grnId) throws SQLException {
        Vendor vendor = vendorDAO.searchById(grnId);
        if (vendor != null) {
            return new VendorDTO(vendor.getGrnId(), vendor.getName(), vendor.getItemId(), vendor.getDescription(), vendor.getQty(), vendor.getBuyingPrice());
        }
        return null;
    }
}
