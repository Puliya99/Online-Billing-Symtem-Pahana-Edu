package com.example.pahanaedubillingsystem.backend.entity;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Customer {
    private String accountNo;
    private String name;
    private String address;
    private String telephone;
    private int unitsConsumed;
}

