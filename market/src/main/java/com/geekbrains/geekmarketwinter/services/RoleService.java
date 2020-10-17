package com.geekbrains.geekmarketwinter.services;

import com.geekbrains.geekmarketwinter.entites.Role;
import com.geekbrains.geekmarketwinter.repositories.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleService {
    private RoleRepository roleRepository;

    @Autowired
    public void setCategoryRepository(RoleRepository roleRepository) {
        this.roleRepository = roleRepository;
    }

    public void addRole(Role role) {
        roleRepository.save(role);
    }
}
