/*Listagem dos bancos*/
SELECT numero, nome, ativo FROM banco;
/*Todas as agencias*/
SELECT banco_numero, numero, nome FROM agencia;
/*Lstagem dos clientes*/
SELECT numero, nome, email FROM cliente;
/*Transações que temos*/
SELECT id, nome FROM tipo_transacao;
/*Listagem de Infos de Conta Corrente*/
SELECT banco_numero, agencia_numero, numero, cliente_numero FROM conta_corrente;
/*Listagem de Infos de transações*/
SELECT banco_numero, agencia_numero, cliente_numero FROM cliente_transacoes;

/*Listagem de TODOS os campos das transacoes*/
SELECT * FROM cliente_transacoes

/*Existe um catálogo do banco, uma VIEW que vai mostrar todas as colunas da tabela banco*/
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'banco';

/*Algumas funções agregadas:*/

-- AVG
-- COUNT (having)
-- MAX
-- MIN
-- SUM

SELECT * FROM cliente_transacoes;

/*Média de todos os valores, nesse caso, de clientes*/
SELECT AVG(valor) FROM cliente_transacoes;

/*Contagem de dados*/
SELECT COUNT (numero), email
FROM cliente
WHERE email ILIKE '@hotmail.com'
/*As funções agregadas são funções de agrupamento, por isso, o email precisa ser igualmente agrupado*/
--Adicionamos, então:
GROUP BY email;

--Valor máximo para transação
SELECT MAX(valor)
FROM cliente_transacoes;

--Valor mínimo para transação
SELECT MIN(valor)
FROM cliente_transacoes;

/*Máximo valor de cada tipo de transação*/
SELECT MAX(valor), tipo_transacao_id
FROM cliente_transacoes
GROUP BY tipo_transacao_id

/*Mínimo valor de cada tipo de transação*/
SELECT MIN(valor), tipo_transacao_id
FROM cliente_transacoes
GROUP BY tipo_transacao_id

-- Qual o campo de identificação?
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'cliente_transacoes';
-- id
SELECT COUNT(id), tipo_transacao_id
FROM cliente_transacoes
GROUP BY tipo_transacao_id
--Incluindo o comando abaixo, ele fará a contagem dos tipos de transação, mas só trará as que tiverem contagem maior que 150
HAVING COUNT (id) > 150;

/*Soma as transações*/
SELECT SUM(valor)
FROM cliente_transacoes

SELECT SUM (valor), tipo_transacao_id
FROM cliente_transacoes
GROUP BY tipo_transacao_id
/*Também podemos incluir comandos de ordenação*/
--Por default o ORDER BY é ASC, ascendente. Mas podemos ordenar de forma descendente
ORDER BY tipo_transacao_id DESC;
