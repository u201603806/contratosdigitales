package com.upc.signer.controller;

import org.springframework.web.bind.annotation.PostMapping;

import com.upc.signer.bean.Documento;

public interface FirmaController {
	@PostMapping("/firma")
	Object firmarDocumento(Documento documento);
}
