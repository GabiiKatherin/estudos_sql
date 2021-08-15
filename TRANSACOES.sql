CREATE TABLE IF NOT EXISTS funcionarios(
	id SERIAL,
	nome VARCHAR(50),
	gerente INTEGER,
	PRIMARY KEY (id),
	FOREIGN KEY (gerente) REFERENCES funcionarios(id)
);
INSERT INTO funcionarios (nome, gerente) VALUES ('Ancelmo',null);
INSERT INTO funcionarios (nome, gerente) VALUES ('Beatriz',1);
INSERT INTO funcionarios (nome, gerente) VALUES ('Magno',1);
INSERT INTO funcionarios (nome, gerente) VALUES ('Cremilda',2);
INSERT INTO funcionarios (nome, gerente) VALUES ('Wagner',4);

SELECT numero, nome ativo FROM banco ORDER BY numero;

UPDATE banco SET ativo = false WHERE numero = 0;

BEGIN;
UPDATE banco SET ativo = true WHERE numero = 0;
SELECT numero, nome, ativo FROM banco WHERE numero = 0;
ROLLBACK;

BEGIN;
UPDATE banco SET ativo = true WHERE numero = 0;
COMMIT;

SELECT id, gerente, nome
FROM funcionarios;

BEGIN;
UPDATE funcionarios SET gerente = 2 WHERE id = 3;
SAVEPOINT sf_func;
UPDATE funcionarios SET gerente = null;
ROLLBACK TO sf_func;
UPDATE funcionarios SET gerente = 3 WHERE id = 5;
COMMIT;

SELECT id, gerente, nome
FROM funcionarios;
