package com.codegym.service.impl;

import com.codegym.service.IDictionaryService;
import org.springframework.stereotype.Service;

import java.util.LinkedHashMap;
import java.util.Map;

@Service
public class DictionaryService implements IDictionaryService {

    @Override
    public Map<String, String> change() {
        Map<String,String> map = new LinkedHashMap<>();
        map.put("Hello","xin chào");
        map.put("Car","xe hơi");
        map.put("home","ngôi nhà");
        return map;
    }
}
