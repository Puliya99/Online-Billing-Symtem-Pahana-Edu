package com.example.pahanaedubillingsystem.backend.bo.custom.impl;

import com.example.pahanaedubillingsystem.backend.bo.custom.VendorBO;
import com.example.pahanaedubillingsystem.backend.dao.DAOFactory;
import com.example.pahanaedubillingsystem.backend.dao.custom.ItemDAO;
import com.example.pahanaedubillingsystem.backend.dao.custom.VendorDAO;
import com.example.pahanaedubillingsystem.backend.entity.Item;
import com.example.pahanaedubillingsystem.backend.dto.VendorDTO;
import com.example.pahanaedubillingsystem.backend.entity.Vendor;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VendorBOImpl implements VendorBO {
    private final VendorDAO vendorDAO = (VendorDAO) DAOFactory.getDaoFactory().getDAO(DAOFactory.DAOTypes.VENDOR);
    private final ItemDAO itemDAO = (ItemDAO) DAOFactory.getDaoFactory().getDAO(DAOFactory.DAOTypes.ITEM);

    @Override
    public boolean saveVendor(VendorDTO dto) throws SQLException {
        boolean saved = vendorDAO.save(new Vendor(dto.getGrnId(), dto.getGrnDate(), dto.getName(), dto.getItemId(), dto.getDescription(), dto.getQty(), dto.getBuyingPrice()));
        if (!saved) return false;
        return applyItemQtyDelta(dto.getItemId(), dto.getQty());
    }

    @Override
    public boolean updateVendor(VendorDTO dto) throws SQLException {
        Vendor existing = vendorDAO.searchById(dto.getGrnId());
        boolean updated = vendorDAO.update(new Vendor(dto.getGrnId(), dto.getGrnDate(), dto.getName(), dto.getItemId(), dto.getDescription(), dto.getQty(), dto.getBuyingPrice()));
        if (!updated) return false;

        if (existing == null) {
            return applyItemQtyDelta(dto.getItemId(), dto.getQty());
        }

        String oldItemId = existing.getItemId();
        int oldQty = existing.getQty();
        String newItemId = dto.getItemId();
        int newQty = dto.getQty();

        boolean ok = true;
        if (oldItemId != null && !oldItemId.equals(newItemId)) {
            ok &= applyItemQtyDelta(oldItemId, -oldQty);
            ok &= applyItemQtyDelta(newItemId, newQty);
        } else {
            int delta = newQty - oldQty;
            if (delta != 0) ok &= applyItemQtyDelta(newItemId, delta);
        }
        return ok;
    }

    @Override
    public boolean deleteVendor(String grnId) throws SQLException {
        Vendor existing = vendorDAO.searchById(grnId);
        boolean deleted = vendorDAO.delete(grnId);
        if (!deleted) return false;
        if (existing == null) return true;
        return applyItemQtyDelta(existing.getItemId(), -existing.getQty());
    }

    private boolean applyItemQtyDelta(String itemId, int delta) throws SQLException {
        if (itemId == null || itemId.isEmpty() || delta == 0) return true;
        Item item = itemDAO.searchById(itemId);
        if (item == null) return false;
        int newQty = item.getQty() + delta;
        if (newQty < 0) newQty = 0;
        item.setQty(newQty);
        return itemDAO.update(item);
    }

    @Override
    public VendorDTO searchVendor(String grnId) throws SQLException {
        Vendor vendor = vendorDAO.search(grnId);
        if (vendor != null) {
            return new VendorDTO(vendor.getGrnId(), vendor.getGrnDate(), vendor.getName(), vendor.getItemId(), vendor.getDescription(), vendor.getQty(), vendor.getBuyingPrice());
        }
        return null;
    }

    @Override
    public List<VendorDTO> getAllVendors() throws SQLException {
        List<VendorDTO> vendors = new ArrayList<>();
        List<Vendor> all = vendorDAO.getAll();
        for (Vendor v : all) {
            vendors.add(new VendorDTO(v.getGrnId(), v.getGrnDate(), v.getName(), v.getItemId(), v.getDescription(), v.getQty(), v.getBuyingPrice()));
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
            return new VendorDTO(vendor.getGrnId(), vendor.getGrnDate(), vendor.getName(), vendor.getItemId(), vendor.getDescription(), vendor.getQty(), vendor.getBuyingPrice());
        }
        return null;
    }
}
