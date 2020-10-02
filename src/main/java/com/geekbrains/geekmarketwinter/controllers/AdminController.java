package com.geekbrains.geekmarketwinter.controllers;

import com.geekbrains.geekmarketwinter.entites.Category;
import com.geekbrains.geekmarketwinter.entites.Order;
import com.geekbrains.geekmarketwinter.entites.Role;
import com.geekbrains.geekmarketwinter.services.CategoryService;
import com.geekbrains.geekmarketwinter.services.OrderService;
import com.geekbrains.geekmarketwinter.services.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {
    private OrderService orderService;
    private CategoryService categoryService;
    private RoleService roleService;

    @Autowired
    public void setOrderService(OrderService orderService) {
        this.orderService = orderService;
    }

    @Autowired
    public void setCategoryService(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @Autowired
    public void setRoleService(RoleService roleService) {
        this.roleService = roleService;
    }

    @GetMapping
    public String showAdminDashboard() {
        return "admin-panel";
    }

    @GetMapping("/orders")
    public String showOrders(Model model) {
        List<Order> orders = orderService.getAllOrders();
        model.addAttribute("orders", orders);
        return "orders-page";
    }

    @GetMapping("/orders/ready/{id}")
    public void orderReady(HttpServletRequest request, HttpServletResponse response, @PathVariable("id") Long id) throws Exception {
        Order order = orderService.findById(id);
        orderService.changeOrderStatus(order, 2L);
        response.sendRedirect(request.getHeader("referer"));
    }

    @PostMapping("/addCategory")
    public String addCategory(Model model, @RequestParam("inputCategory") String category){
        Category newCategory = new Category();
        newCategory.setTitle(category);
//        categoryService.addCategory(newCategory);
        model.addAttribute("category", category);
        return "admin-panel";
    }

    @PostMapping("/addRole")
    public String addRole(Model model, @RequestParam("inputRole") String role){
        Role newRole = new Role();
        newRole.setName(role);
//        roleService.addRole(newRole);
        model.addAttribute("role", role);
        return "admin-panel";
    }
}
