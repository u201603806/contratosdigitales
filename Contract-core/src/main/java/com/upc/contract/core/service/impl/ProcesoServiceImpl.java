package com.upc.contract.core.service.impl;

import java.io.ByteArrayInputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.upc.contract.core.entity.Colaborador;
import com.upc.contract.core.entity.Documento;
import com.upc.contract.core.entity.Envio;
import com.upc.contract.core.repository.ColaboradorRepository;
import com.upc.contract.core.repository.DocumentoRepository;
import com.upc.contract.core.repository.EnvioRepository;
import com.upc.contract.core.service.ProcesoService;
import com.upc.contract.core.util.UtilCore;

@Service
public class ProcesoServiceImpl implements ProcesoService {

	@Autowired
	private EnvioRepository envioRepository;
	@Autowired
	private ColaboradorRepository colaboradorRepository;
	@Autowired
	private DocumentoRepository documentoRepository;

	@Override
	public Long guardarEnvio(Envio envio) throws Exception {
		Workbook libroExcel = WorkbookFactory.create(new ByteArrayInputStream(envio.getDatos()));
		Sheet hojaActual = libroExcel.getSheetAt(0);
		int numeroFilas = hojaActual.getLastRowNum()-1;
		envio.setIdEstado(new Long(2));
		envio.setFechaRegistro(new Date());
		envio.setCantidad(numeroFilas);
		return envioRepository.save(envio).getIdEnvio();
	}

	@Override
	public Long obtenerIdEnvio() throws Exception {
		return envioRepository.count();
	}

	@Override
	public List<Map<String, Object>> obtenerRegistros(String idEnvio,String nombre) throws Exception {
		List<Map<String, Object>> lstDocumentos = new ArrayList<>();
		Documento documento=new Documento();
		documento.setIdEnvio(new Long(idEnvio));
		Envio envio = envioRepository.findById(documento.getIdEnvio()).get();
		Workbook libroExcel = WorkbookFactory.create(new ByteArrayInputStream(envio.getDatos()));
		Sheet hojaActual = libroExcel.getSheetAt(0);
		int numeroFilas = hojaActual.getLastRowNum();
		for (int fila = 2; fila <= numeroFilas; fila++) {
			Map<String, Object> mapDocumento = new HashMap<>();
			mapDocumento.put("dni", hojaActual.getRow(fila).getCell(0).getStringCellValue());
			mapDocumento.put("nombre", hojaActual.getRow(fila).getCell(1).getStringCellValue());
			mapDocumento.put("puesto", hojaActual.getRow(fila).getCell(3).getStringCellValue());
			mapDocumento.put("inicio", hojaActual.getRow(fila).getCell(5).getStringCellValue());
			mapDocumento.put("fin", hojaActual.getRow(fila).getCell(6).getStringCellValue());
			if(UtilCore.isNullOrEmpty(nombre) || nombre.equals("-") || nombre.equals("0")) {
				lstDocumentos.add(mapDocumento);
			}else {
				if(mapDocumento.get("nombre").toString().toUpperCase().contains(nombre.toUpperCase())) {
					lstDocumentos.add(mapDocumento);
				}
			}
		}
		return lstDocumentos;
	}

	@Override
	@Transactional
	public void guardarRegistros(Envio envio) throws Exception {
		envio = envioRepository.findById(envio.getIdEnvio()).get();
		Workbook libroExcel = WorkbookFactory.create(new ByteArrayInputStream(envio.getDatos()));
		Sheet hojaActual = libroExcel.getSheetAt(0);
		int numeroFilas = hojaActual.getLastRowNum();
		for (int fila = 2; fila <= numeroFilas; fila++) {
			Colaborador colaborador=new Colaborador();
			colaborador.setDni(hojaActual.getRow(fila).getCell(0).getStringCellValue());
			colaborador.setNombreApellido(hojaActual.getRow(fila).getCell(1).getStringCellValue());
			colaborador.setClave(UtilCore.generateSHA256(colaborador.getDni()));
			colaborador.setCelular(hojaActual.getRow(fila).getCell(8).getStringCellValue());
			colaborador.setCorreo(hojaActual.getRow(fila).getCell(9).getStringCellValue());
			colaborador = colaboradorRepository.save(colaborador);
			Documento documento = new Documento();
			documento.setDni(colaborador.getDni());
			documento.setIdEnvio(envio.getIdEnvio());
			documento.setIdEstado(new Long("4"));
			documento.setCargo(hojaActual.getRow(fila).getCell(3).getStringCellValue());
			documento.setArea(hojaActual.getRow(fila).getCell(2).getStringCellValue());
			documento.setJefe(hojaActual.getRow(fila).getCell(7).getStringCellValue());
			documento.setSueldo(hojaActual.getRow(fila).getCell(4).getNumericCellValue());
			documentoRepository.save(documento);
		}
		envio.setIdEstado(new Long("3"));
		envioRepository.save(envio);
	}

}
