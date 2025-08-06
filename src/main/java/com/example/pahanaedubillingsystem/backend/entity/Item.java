package com.example.pahanaedubillingsystem.backend.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Item {
    private String itemId;
    private String name;
    private double price;
    private int qty;
}
