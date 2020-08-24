package com.upc.contract.cli;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableJpaRepositories("com.upc.contract.core.repository")
@EntityScan ("com.upc.contract.core.entity")
@ComponentScan("com.upc.contract.*")
public class ContractCliRestApplication {

	public static void main(String[] args) {
		SpringApplication.run(ContractCliRestApplication.class, args);
	}

}
