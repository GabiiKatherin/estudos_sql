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