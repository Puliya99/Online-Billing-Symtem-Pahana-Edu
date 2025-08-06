package com.example.pahanaedubillingsystem.backend.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Bill {
    private String billId;
    private Date billDate;
    private String accountNo;
    private double totalAmount;
}
