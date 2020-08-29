package com.upc.contract.adm.controller;

import java.util.List;

import org.springframework.web.bind.annotation.PostMapping;

import com.upc.contract.core.entity.TipoContrato;

public interface ProcesoController {
	@PostMapping("/tipos")
	List<TipoContrato> contratosDisponibles();

}
