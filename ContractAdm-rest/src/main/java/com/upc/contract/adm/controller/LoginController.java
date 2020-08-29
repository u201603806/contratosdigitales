package com.upc.contract.adm.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.upc.contract.core.util.ResponseCore;


public interface LoginController {
	@RequestMapping(value = "/acceso", produces = { MediaType.APPLICATION_JSON_VALUE,
			MediaType.APPLICATION_XML_VALUE }, method = RequestMethod.POST)
	ResponseCore validarAcceso(HttpServletRequest request);
}
