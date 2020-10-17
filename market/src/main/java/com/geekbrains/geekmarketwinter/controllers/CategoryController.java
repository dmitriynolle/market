package com.geekbrains.geekmarketwinter.controllers;

import com.geekbrains.geekmarketwinter.services.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CategoryController {
    private CategoryService categoryService;

    @Autowired
    public void setCategoryService(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @RequestMapping("/category")
    public String getCategory(){
//        System.out.println(categoryService.getAllCategories());
        return categoryService.getAllCategories().toString();
    }
}
