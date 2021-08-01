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
	numero BIGSERIAL PRIMARY,
	nome VARCHAR(120) NOT NULL,
	email VARCHAR(250) NOT NULL,
	
	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	
);

CREATE TABLE IF NOT EXISTS conta_corrente(
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

CREATE TABLE IF NOT EXISTS tipo_transacao(
	id SMALLSERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,

	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

);

CREATE TABLE IF NOT EXISTS cliente_transacoes(
	/*Se essa TABLE vai referenciar uma transação do cliente, ela envolve a conta corrente dele o que implica a inclusao de uma referencia*/
	id BIGSERIAL PRIMARY KEY,
	
	banco_numero INTEGER NOT NULL,
	agencia_numero INTEGER NOT NULL,
	conta_corrente_numero BIGINT NOT NULL,
	conta_corrente_digito SMALLINT NOT NULL,
	cliente_numero BIGINT NOT NULL,
	tipo_transacao_id SMALLINT NOT NULL,
	
	/*O valor pode ter 15 numeros e os dois ultimos são casas decimais*/
	valor NUMERIC(15,2),

	FOREIGN KEY (banco_numero,agencia_numero,conta_corrente_numero,conta_corrente_digito,cliente_numero) REFERENCES conta_corrente(banco_numero,agencia_numero,numero,digito,cliente_numero),
	
	/*Não vamos inserir o campo "ativo" porque é uma transação e ela irá ocorrer*/
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

/*Agora iremos inserir dados respeitando as PRIMARY KEY's e FOREIGN KEY's*/
