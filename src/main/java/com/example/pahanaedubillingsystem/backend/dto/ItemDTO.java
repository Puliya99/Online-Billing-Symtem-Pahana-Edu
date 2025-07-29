package com.example.pahanaedubillingsystem.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ItemDTO {
    private String itemId;
    private String name;
    private double price;
    private int qty;
}