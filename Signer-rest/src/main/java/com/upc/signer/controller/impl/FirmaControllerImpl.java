package com.upc.signer.controller.impl;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.upc.signer.bean.Documento;
import com.upc.signer.controller.FirmaController;
import com.upc.signer.service.FirmaService;

@RestController
@RequestMapping("/pki")
public class FirmaControllerImpl implements FirmaController{

	@Autowired
	private FirmaService utilService;
	private Logger logger = LoggerFactory.getLogger(FirmaControllerImpl.class);
	
	@Override
	@PostMapping("/firma")
	public Object firmarDocumento(@RequestBody Documento documento) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			byte[] rsp = utilService.firmarPdf(documento.getData());
			response.put("estado", "OK");
			response.put("data", rsp);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			response.put("estado", "ERROR");
			response.put("mensaje", e.getMessage());
		}
		return response;
	}

}
