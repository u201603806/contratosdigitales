package com.upc.contract.adm.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.upc.contract.core.entity.Usuario;


public interface LoginController {
	@GetMapping("/entidad/{codigo}")
    Usuario obtenerEntidad(@PathVariable(value = "codigo") Long codigo);
}
