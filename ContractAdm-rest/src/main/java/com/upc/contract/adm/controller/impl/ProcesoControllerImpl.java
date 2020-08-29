package com.upc.contract.adm.controller.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.upc.contract.adm.controller.ProcesoController;
import com.upc.contract.core.entity.TipoContrato;
import com.upc.contract.core.service.TipoContratoService;

@RestController
@RequestMapping("/proceso")
public class ProcesoControllerImpl implements ProcesoController{
	@Autowired
	private TipoContratoService tipoContratoService;
	private Logger logger = LoggerFactory.getLogger(ProcesoControllerImpl.class);
	
	@Override
	@GetMapping("/listartipos")
	public List<TipoContrato> contratosDisponibles() {
		try {
			List<TipoContrato> lstContratos = tipoContratoService.contratosDisponibles();
			return lstContratos;
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
		}
	}

}
