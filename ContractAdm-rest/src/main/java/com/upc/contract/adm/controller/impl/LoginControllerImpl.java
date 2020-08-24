package com.upc.contract.adm.controller.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.upc.contract.adm.controller.LoginController;
import com.upc.contract.core.entity.Usuario;
import com.upc.contract.core.service.UsuarioService;

@RestController
@RequestMapping("/admin")
public class LoginControllerImpl implements LoginController {
	@Autowired
	private UsuarioService usuarioService;
	Logger logger = LoggerFactory.getLogger(LoginControllerImpl.class);

	@Override
	@GetMapping("/entidad/{codigo}")
	public Usuario obtenerEntidad(@PathVariable(value = "codigo") Long codigo) {
		Usuario oUsuario;
		try {
			logger.debug("Buscando entidad usuario");
			oUsuario = usuarioService.obtenerUsuario(codigo);
		} catch (Exception e) {
			logger.error("Error de Obtener Entidad");
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Mi mensaje");
		}
		return oUsuario;
	}

}
