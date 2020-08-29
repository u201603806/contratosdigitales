package com.upc.contract.adm.controller.impl;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.upc.contract.adm.controller.LoginController;
import com.upc.contract.core.entity.Usuario;
import com.upc.contract.core.service.UsuarioService;
import com.upc.contract.core.util.ConstantesCore;
import com.upc.contract.core.util.ResponseCore;
import com.upc.contract.core.util.UtilCore;

@RestController
@RequestMapping("/seguridad")
public class LoginControllerImpl implements LoginController {
	@Autowired
	private UsuarioService usuarioService;
	Logger logger = LoggerFactory.getLogger(LoginControllerImpl.class);

	@Override
	@RequestMapping(value = "/acceso", produces = { MediaType.APPLICATION_JSON_VALUE,
			MediaType.APPLICATION_XML_VALUE }, method = RequestMethod.POST)
	public ResponseCore validarAcceso(HttpServletRequest request) {
		Usuario oUsuario;
		ResponseCore response = new ResponseCore();
		try {
			String usuario = request.getParameter("usuario");
			String clave = request.getParameter("clave");
			logger.debug("usuario "+usuario);
			oUsuario = usuarioService.userValidate(usuario, UtilCore.generateSHA256(clave));
			if(UtilCore.isNullOrEmpty(oUsuario)) {
				response.setEstadoRespuesta(ConstantesCore.RSP_ERROR);
				response.setMensajeRespuesta("usuario o clave incorrectos");
			}else {
				Map<String, Object> parametro = new HashMap<>();
				parametro.put("usuario", oUsuario);
				response.setParametros(parametro);
				response.setEstadoRespuesta(ConstantesCore.RSP_OK);
				response.setMensajeRespuesta("Acceso correcto");
			}
		} catch (Exception e) {
			logger.error(e.getMessage(),e);
			response.setEstadoRespuesta(ConstantesCore.RSP_ERROR);
			response.setMensajeRespuesta(e.getMessage());
		}
		return response;
	}

}
