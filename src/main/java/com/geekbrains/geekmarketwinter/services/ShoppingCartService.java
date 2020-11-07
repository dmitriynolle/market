package com.geekbrains.geekmarketwinter.services;

import com.geekbrains.geekmarketwinter.entites.OrderItem;
import com.geekbrains.geekmarketwinter.entites.Product;
import com.geekbrains.geekmarketwinter.utils.ShoppingCart;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;

@Service
public class ShoppingCartService {
    private ProductService productService;

    @Autowired
    public void setProductService(ProductService productService) {
        this.productService = productService;
    }

    public ShoppingCart getCurrentCart(HttpSession session) {
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        if (cart == null) {
            cart = new ShoppingCart();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    public void resetCart(HttpSession session) {
        session.removeAttribute("cart");
    }

    public void addToCart(HttpSession session, Long productId) {
        Product product = productService.getProductById(productId);
        addToCart(session, product);
    }

    public void addToCart(HttpSession session, Product product) {
        ShoppingCart cart = getCurrentCart(session);
        cart.add(product);
    }

    public void removeFromCart(HttpSession session, Long productId) {
        Product product = productService.getProductById(productId);
        removeFromCart(session, product);
    }

    public void removeFromCart(HttpSession session, Product product) {
        ShoppingCart carts = getCurrentCart(session);
        for (OrderItem cart : carts.getItems()) {
            if(cart.getProduct().getId() == product.getId() && cart.getQuantity() > 1){
                cart.setQuantity(cart.getQuantity() - 1);
                cart.setTotalPrice(cart.getTotalPrice()-cart.getItemPrice());
                carts.setTotalCost(carts.getTotalCost()-cart.getItemPrice());
                break;
            } else if(cart.getProduct().getId() == product.getId() && cart.getQuantity() == 1){
                carts.remove(product);
                break;
            }
        }
    }

    public void setProductCount(HttpSession session, Long productId, Long quantity) {
        ShoppingCart cart = getCurrentCart(session);
        Product product = productService.getProductById(productId);
        cart.setQuantity(product, quantity);
    }

    public void setProductCount(HttpSession session, Product product, Long quantity) {
        ShoppingCart cart = getCurrentCart(session);
        cart.setQuantity(product, quantity);
    }

    public double getTotalCost(HttpSession session) {
        return getCurrentCart(session).getTotalCost();
    }
}
