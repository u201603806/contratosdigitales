package com.upc.contract.core.service;

import com.upc.contract.core.entity.Usuario;

public interface UsuarioService {
	Usuario obtenerUsuario(Long codigo) throws Exception;
}
