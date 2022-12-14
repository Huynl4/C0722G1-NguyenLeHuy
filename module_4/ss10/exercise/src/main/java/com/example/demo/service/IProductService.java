package com.example.demo.service;

import com.example.demo.model.Product;

import java.util.List;
import java.util.Optional;

public interface IProductService {
    Optional<Product> findById(Long id);
    List<Product> findAll();
}
