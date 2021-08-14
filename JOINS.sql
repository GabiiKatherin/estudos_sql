SELECT count (1) FROM banco --151;
SELECT count (1) FROM agencia --296;

/*A relação que vamos obter é de todas as 296 agências que existem nessa contagem que possuem um banco*/
SELECT banco.numero, banco.nome, agencia.numero, agencia.nome
FROM banco
JOIN agencia ON agencia.banco_numero = banco.numero;
--agencia.banco_numero, porque criamos essa FK dentro da tabela de agencia

/*Agora, quantos bancos possuem agências?*/
--Numero total:
SELECT count (banco.numero)
FROM banco
JOIN agencia ON agencia.banco_numero = banco.numero;

--Se quiséssemos agrupar os bancos, poderíamos fazer assim:
SELECT banco.numero	
FROM banco
JOIN agencia ON agencia.banco_numero = banco.numero
GROUP BY banco.numero;
--Desse resultado, concluímos que apenas 9 bancos posspuem agencias

--Outra forma de fazer:
SELECT count (distinct banco.numero) FROM banco
JOIN agencia ON agencia.banco_numero = banco.numero;

--LEFT JOINS:
SELECT banco.numero, banco.nome, agencia.numero, agencia.nome
FROM banco
LEFT JOIN agencia ON agencia.banco_numero = banco.numero;
--Temos 438 registros, porque ele vai retornar todos os bancos que possuem relacionamento junto com as agências e todos os que não tem relação alguma

SELECT banco.numero, banco.nome, agencia.numero, agencia.nome
FROM agencia
RIGHT JOIN banco ON banco.numero = agencia.numero;
--Uma obs importante: esse RIGHT JOIN funcionou 
--RIGHT JOIN: O right só vai funcionar se houver mais registros à direita do que a esquerda

SELECT agencia.numero, agencia.nome, banco_numero, banco.nome;
FROM agencia
LEFT JOIN banco ON banco.numero = agencia.banco_numero;
--esse é o correto de se fazer nesse caso

SELECT banco.numero, banco.nome, agencia.numero, agencia.nome
FROM banco
FULL JOIN agencia ON agencia.banco_numero = banco.numero;
--ele trás todos os bancos e todas as agências, todas as possibilidades que temos
--veio igual ao outro porque, nesse caso, não temos nenhuma agencia sem banco, se houvesse, veríamos o nome da agencia com o banco NULL
--Lá atrás nós forçamos o relacionamento dizendo que o banco seria NOT NULL

CREATE TABLE IF NOT EXISTS teste_a (id serial primary key, valor varchar(10));
CREATE TABLE IF NOT EXISTS teste_b (id serial primary key, valor varchar(10));

INSERT INTO teste_a (valor) VALUES  ('teste 1');
INSERT INTO teste_a (valor) VALUES  ('teste 2');
INSERT INTO teste_a (valor) VALUES  ('teste 3');
INSERT INTO teste_a (valor) VALUES  ('teste 4');

INSERT INTO teste_b (valor) VALUES  ('teste a');
INSERT INTO teste_b (valor) VALUES  ('teste b');
INSERT INTO teste_b (valor) VALUES  ('teste c');
INSERT INTO teste_b (valor) VALUES  ('teste d');

SELECT tbla.valor, tblb.valor
--tbls e tblb são apelidos
FROM teste_a tbla
CROSS JOIN teste_b tblb;

--ele cria uma matriz e isso é um desperdício de recurso

DROP TABLE IF EXISTS teste_a;
DROP TABLE IF EXISTS teste_b;

--Vamos fazer um JOIN completo
SELECT  banco.nome,
		agencia.nome,
		conta_corrente.numero,
		conta_corrente.digito,
		cliente.nome
--o mais importante é sempre seguir uma ordem que faça sentido na relação entre as tabelas
FROM banco 
JOIN agencia ON agencia.banco_numero = banco.numero
JOIN conta_corrente
	--ON conta_corrente.banco_numero = agencia.banco_numero;
	ON conta_corrente.banco_numero = banco.numero
	AND conta_corrente.agencia_numero = agencia.numero
JOIN cliente
	ON cliente.numero = conta_corrente.cliente_numero;
--Fizemos um JOIN entre 3 tabelas e relacionamos todos os dados


