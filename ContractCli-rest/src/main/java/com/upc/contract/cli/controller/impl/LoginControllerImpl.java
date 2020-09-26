package com.upc.contract.cli.controller.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.upc.contract.cli.controller.LoginController;
import com.upc.contract.core.entity.Usuario;
import com.upc.contract.core.service.UsuarioService;

@RestController
@RequestMapping("/seguridad")
public class LoginControllerImpl implements LoginController {
	@Autowired
	private UsuarioService usuarioService;
	Logger logger = LoggerFactory.getLogger(LoginControllerImpl.class);

	@Override
	@PostMapping("/acceso")
	public Usuario obtenerEntidad(@RequestBody Usuario usuario) {
		Usuario oUsuario = new Usuario();
		try {
			logger.debug("Buscando entidad usuario");
			oUsuario = usuarioService.userValidate(usuario.getCodUsuario(), usuario.getClave());
		} catch (Exception e) {
			logger.error("Error de Obtener colaborador");
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
		}
		return oUsuario;
	}

}
