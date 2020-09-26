package com.upc.signer.service.impl;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.security.KeyStore;
import java.security.PrivateKey;

import org.springframework.stereotype.Service;

import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfSignatureAppearance;
import com.itextpdf.text.pdf.PdfStamper;
import com.upc.signer.service.FirmaService;

@Service
public class FirmaServiceImpl implements FirmaService{

	private static String CERTIFICADO = "D:\\Temp\\Certificado.pfx";
	private static String CLAVE = "12345678";
	
	@Override
	public byte[] firmarPdf(byte[] data) throws Exception {
		try {
			PdfReader reader = null;
			reader = new PdfReader(data);
			
			KeyStore keystore = KeyStore.getInstance("PKCS12");
			InputStream in = new FileInputStream(CERTIFICADO);
            keystore.load(in, CLAVE.toCharArray());
            in.close();
			
            String alias = (String) keystore.aliases().nextElement();
            PrivateKey pk = (PrivateKey) keystore.getKey(alias, CLAVE.toCharArray());
            java.security.cert.Certificate[] chain = keystore.getCertificateChain(alias);
            
    		ByteArrayOutputStream nuevoDocumento = new ByteArrayOutputStream();
            PdfStamper stp = PdfStamper.createSignature(reader, nuevoDocumento, '\000', null, true);
            PdfSignatureAppearance sap = stp.getSignatureAppearance();
            sap.setCrypto(pk, chain, null, PdfSignatureAppearance.WINCER_SIGNED);
            sap.setReason("Firma de Contrato");
            sap.setLocation("Lima");
            stp.close();
            return nuevoDocumento.toByteArray();
            
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

}
