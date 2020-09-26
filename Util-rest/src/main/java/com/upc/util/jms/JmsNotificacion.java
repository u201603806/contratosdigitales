package com.upc.util.jms;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.annotation.JmsListener;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.upc.util.service.UtilidadService;

@Component
public class JmsNotificacion {
	
	@Autowired
	private UtilidadService utilService;
	
	@JmsListener(destination = "${jms.cola.notificacion}")
	public void notificar(String mensaje) {
		ObjectMapper mapper = new ObjectMapper();

		try {
			System.out.println(mensaje);
			@SuppressWarnings("unchecked")
			Map<String, Object> map = mapper.readValue(mensaje, Map.class);
			utilService.enviarCorreo(map);
			System.out.println("mensaje enviado");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
