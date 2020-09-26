package com.upc.signer.service;

public interface FirmaService {
	byte[] firmarPdf(byte[] data) throws Exception;
}
