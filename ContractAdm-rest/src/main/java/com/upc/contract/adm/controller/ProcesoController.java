package com.upc.contract.adm.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;

import com.upc.contract.core.entity.TipoContrato;

public interface ProcesoController {
	@GetMapping("/tipos")
	List<TipoContrato> contratosDisponibles();

}
