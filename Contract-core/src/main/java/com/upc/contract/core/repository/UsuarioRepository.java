package com.upc.contract.core.repository;

import org.springframework.data.repository.CrudRepository;

import com.upc.contract.core.entity.Usuario;

public interface UsuarioRepository extends CrudRepository<Usuario, Long> {

}
