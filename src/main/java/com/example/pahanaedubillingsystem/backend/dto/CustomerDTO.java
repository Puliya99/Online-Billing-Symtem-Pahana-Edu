package com.example.pahanaedubillingsystem.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CustomerDTO {
    private String accountNo;
    private String name;
    private String address;
    private String telephone;
    private int unitsConsumed;
}