SELECT numero, nome FROM banco;
SELECT banco_numero, numero, nome FROM agencia;

--vamos fazer com 2 tabelas pra ficar simples de entender

WITH tbl_tmp_banco AS (
	SELECT numero, nome
	FROM banco
)	
	SELECT numero, nome
	--esse SELECT vem dali de cima do STATEMENT, nao da tabela!
	FROM tbl_tmp_banco;
	
--vamos supor que agora eu tenho parametros

WITH params AS(
	SELECT 213 AS banco_numero
), tbl_tmp_banco AS (
	SELECT numero, nome 
	FROM banco
	JOIN params ON params.banco_numero = banco.numero
)
SELECT numero, nome
FROM tbl_tmp_banco;

--Caso, fossemos trab com sub SELECTs:
	--lembrando que vai da preferencia de cada um, mas a boa prática chama o WITH

SELECT banco.numero,  banco.nome
FROM banco
JOIN (
	SELECT 213 AS banco_numero
) params  ON params.banco_numero = banco.numero;

--Vamos complexar um pouca:
WITH clientes_e_transacoes AS (
	SELECT cliente.nome AS cliente_nome,
		   tipo_transacao.nome AS tipo_transacao_nome,
		   cliente_transacoes.valor AS tipo_transacao_valor
	FROM cliente_transacoes
	JOIN cliente ON cliente.numero = cliente_transacoes.cliente_numero
	JOIN tipo_transacao ON tipo_transacao.id = cliente_transacoes.tipo_transacao_id
)
SELECT cliente_nome, tipo_transacao_nome, tipo_transacao_valor
FROM clientes_e_transacoes;
--pensa que essa é a query que a sua aplicação vai usar

--Se eu quiser selecionar apenas transacoes de clientes do banco Itau, eu não preciso mexer na query
--eu posso simplesmente incluir um JOIN no miolo dela

WITH clientes_e_transacoes AS (
	SELECT cliente.nome AS cliente_nome,
		   tipo_transacao.nome AS tipo_transacao_nome,
		   cliente_transacoes.valor AS tipo_transacao_valor
	FROM cliente_transacoes
	JOIN cliente ON cliente.numero = cliente_transacoes.cliente_numero
	JOIN tipo_transacao ON tipo_transacao.id = cliente_transacoes.tipo_transacao_id
	JOIN banco ON banco.numero = cliente_transacoes.banco_numero AND banco.nome ILIKE '%Itaú%'
)
SELECT cliente_nome, tipo_transacao_nome, tipo_transacao_valor
FROM clientes_e_transacoes;
--ele retorna apenas 217 clientes, antes havia retornado 2018