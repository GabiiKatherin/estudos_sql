CREATE TABLE IF NOT EXISTS banco (
	numero INTEGER NOT NULL,
	nome VARCHAR(50) NOT NULL,
	
	/* Boas práticas */
	
	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (numero)
);

CREATE TABLE IF NOT EXISTS agencia (
	banco_numero INTEGER NOT NULL,
	numero INTEGER NOT NULL,
	nome VARCHAR(80) NOT NULL,

	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (banco_numero,numero),
	FOREIGN KEY (banco_numero) REFERENCES banco (numero)
);


/*Tudo que for imediato de olhar, separe numa tabela
Para que as tabelas não concorram entre si*/
CREATE TABLE IF NOT EXISTS cliente(
	numero BIGSERIAL NOT NULL,
	nome VARCHAR(120) NOT NULL,
	email VARCHAR(250) NOT NULL,
	
	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY(numero)
);

CREATE TABLE conta_corrente(
	/*Fará referência a vários bancos*/
	banco_numero INTEGER NOT NULL,
	agencia_numero INTEGER NOT NULL,
	numero BIGINT NOT NULL,
	digito SMALLINT NOT NULL,
	/*BIGINT proque não é um num serial*/
	cliente_numero BIGINT NOT NULL,
	
	/*Comandos de controle*/	
	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	/*Poderíamos aqui criar um id pra agrupar tudo isso, mas em matéria de regras de normalização é importante que a indentidade da tabela esteja descrita naquela PRIMARY KEY, por isso, aqui vamos colocar dessa forma*/
	PRIMARY KEY (banco_numero,agencia_numero,numero,digito,cliente_numero),
	
	/*Uma FOREIGN KEY tem vai referenciar uma PRIMARY KEY com mais de um campo, precisa ter os mesmos campos*/
	FOREIGN KEY (banco_numero,agencia_numero) REFERENCES agencia (numero,banco_numero),
	FOREIGN KEY (cliente_numero) REFERENCES cliente (numero)
);