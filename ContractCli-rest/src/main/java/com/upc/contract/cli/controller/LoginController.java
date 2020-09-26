package com.upc.contract.cli.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.upc.contract.core.entity.Usuario;


public interface LoginController {
	@PostMapping("/acceso")
    Usuario obtenerEntidad(@RequestBody Usuario usuario);
}
