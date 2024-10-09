-- exibir base de dados
show databases;


-- apagar a base de dados se já exixtir
drop database if exists pizzaria;

-- criar base de dados
create database if not exists pizzaria;

-- utilizar a base de dados
use pizzaria;

-- criar tabela 
create table clientes (
id int not null auto_increment primary key,
nome varchar(30),
telefone int,
logradouro varchar(30),
numero int,
complemento varchar(30),
bairro varchar(30),
referencia varchar(30)
);

-- tabela pizzas
create table if not exists pizzas (
id int not null auto_increment primary key,
nome varchar(30),
descricao varchar(100),
valor decimal(15,2)
);

-- mostrar tabelas
show tables;


-- tabela pedido
create table pedidos (
id int not null auto_increment primary key,
cliente_id int,
data datetime,
valor decimal(15,2)
);

-- ateração na tabela paraadicionar a chave estrangeira
alter table pedidos add foreign key (cliente_id) references clientes (id);

-- exibir a estrutura da tabela
describe pedidos;

-- criar tabela itens
create table itens_pedido (
pedido_id int,
pizza_id int,
quantidade int,
valor decimal(15,2),
primary key (pedido_id, pizza_id),
foreign key (pizza_id) references pizzas (id),
foreign key (pedido_id) references pedidos (id)
);

insert into clientes (telefone, nome, logradouro, numero, 
complemento, bairro, referencia)
values ('(11) 1111-1111', 'Alexandre Santos', 'Rua das Palmeiras',
111, null, 'Bela Vista', 'Em frente a escola');

select * from clientes;
-- telefone deu 0 pq o valor dele esta como int, porém tem (), entao vamos mudar a tabela

-- apagar coluna da tabela
alter table clientes drop telefone;

-- adicionar coluna
alter table clientes add tel numeric(15);

-- alterar o tipo de dados de um campo da tabela, pois esse numeric não funciona e vai dar 0
alter table clientes modify tel varchar(14); -- modify só altera dados

-- alterar o tipo de dados e nome da coluna, por exeplo de tel para telefone
alter table clientes change tel telefone varchar(14); 

describe clientes;

update clientes set telefone = '(11) 1111-1111' where id = 1; -- colocar o telefone ja que mudamos tudo

select * from clientes;

insert into clientes (telefone, nome, logradouro, numero, complemento, bairro, referencia)
values ('(22) 2222-2222', 'Bruna Vieira', 'Rua das Rosas', 222, null, 'Cantareira', null);

insert into clientes (telefone, nome, logradouro, numero, complemento, bairro, referencia)
values ('(33) 3333-3333', 'Bruna Dantas', 'Rua das Avencas', 333, null, 'Bela Vista', null);

insert into clientes (telefone, nome, logradouro, numero, complemento, bairro, referencia)
values ('(44) 444-444', 'Giulia Silva', 'Rua dos Cravos', 444, null, 'Cantareira', 'Esquina do mercado');

insert into clientes (telefone, nome, logradouro, numero, complemento, bairro, referencia)
values ('(55) 555-555', 'José Silva', 'Rua das Acárias', 555, null, 'Bela Vista', null);

insert into clientes (telefone, nome, logradouro, numero, complemento, bairro, referencia)
values ('(66) 6666-6666', 'Laura Madureira', 'Rua das Gardenias', 666, null, 'Cantareira', null);

select * from clientes;

-- inserir pizzas
insert into pizzas (nome, valor) values
('Povolone', 17),
('Portuguesa', 15),
('4 Queijos', 20),
('Calabresa', 17); -- mesma coisa que colocar insert into em todos, mas sem ele
select * from pizzas;

insert into pizzas (nome) values ('Escarola');
alter table pizzas modify valor decimal(15,2) default 99; -- defalut coloca como valor padrao caso nao coloquem o preço manualmente
insert into pizzas (nome) values ('Moda da Casa');
select * from pizzas;

insert into pedidos (id, cliente_id, data, valor) values
(1, 1, '2016-12-15 20:30:00', 32),
(2, 2, '2016-12-15 20:38:00', 40.00),
(3, 3, '2016-12-15 20:59:00', 22),
(4, 1, '2016-12-17 22:00:00', 42),
(5, 2, '2016-12-18 19:00:00', 45),
(6, 3, '2016-12-18 21:12:00', 44),
(7, 4, '2016-12-19 22:22:00', 72),
(8, 6, '2016-12-19 22:26:00', 34.0);
select * from pedidos;

insert into itens_pedido (pedido_id, pizza_id, quantidade, valor) values
(1, 1, 1, 15.00),
(1, 4, 1, 17.00),
(2, 3, 2, 40.00),
(3, 5, 1, 22.00),
(4, 3, 1, 20.00),
(4, 5, 1, 22.00),
(5, 1, 3, 45.00),
(6, 5, 2, 44.00),
(7, 1, 2, 30.00),
(7, 3, 1, 20.00),
(7, 5, 1, 22.00),
(8, 4, 2, 34.00);
select * from itens_pedido;

/* 
select [distinct] <colunas>
from <tabelas>
[where condição]
[group by <coluna>]
[having <condição>]
[order by <coluna>] asc (crescente) desc (decrescente) 
*/
-- recaptulando
-- selecionar todos os valores
select * from pizzas;
select id, nome, valor from pizzas;

-- nome da coluna exibido na resposta do comando pode ser alterado com a cláusula AS / apelido
select id as codigo, nome, valor as 'Valor R$' from pizzas; 

-- operações aritmeticas
select 10 + 3, 10 - 3, 10 / 3, 10 * 3;
select 10 + 3 as SOMA, 10 - 3 as SUBTRACAO, 10 / 3 as DIVISAO, 10 * 3 as MULTIPLICACAO;

-- como aumentar o valor das pizzas em 10%
select *, ((valor *10)/100) + valor as '10%' from pizzas;-- ou
select *, (valor*0.10) + valor as '10%' from pizzas;-- ou
select *, valor *1.1 as '10%' from pizzas;
select * from pizzas;
alter table pizzas add column custo decimal(15,2);
update pizzas set custo= valor * 0.60;

-- Selecionar todas as pizzas com valor superiror a R$ 17.00
select * from pizzas where valor > 17;

-- Selecionar todas as pizzas com valor igual ou superior a R$ 17.00
select * from pizzas where valor >= 17;

-- Selecionar todas as pizzas com valor inferior a R$ 17.00
select * from pizzas where valor < 17;

-- Selecionar todas as pizzas com valor igual a R$ 17.00
select * from pizzas where valor = 17;

-- Selecionar todas as pizzas com valor diferente de R$ 17.00
select * from pizzas where valor != 17;
select * from pizzas where valor <> 17;

-- Selecionar todas as pizzas com a coluna valor nula
select * from pizzas where valor <=> null;
select * from pizzas where valor is null;

-- Selecionar todas as pizzas com o valor maior que 15 e menor que 20
select * from pizzas where valor > 15 and valor <20;
select * from pizzas where valor between 16 and 19;

-- Selecionar todas as pizzas com o valores menores ou maiores que R$ 17.00
select * from pizzas where valor < 17 or valor > 17;

-- Selecionar todas as pizzas com o valores não menores ou maiores que R$ 17.00
select * from pizzas where not (valor < 17 or valor > 17);

-- Selecionar todas as pizzas com valores na faixa de R$ 17.00 a R$20.00
select * from pizzas where valor >= 17 or valor <= 20;
select * from pizzas where valor between 17 and 20;

-- Selecionar todas as pizzas com valores fora da faixa de R$ 17.00 a R$20.00
select * from pizzas where valor < 17 or valor > 20;
select * from pizzas where valor not between 17 and 20;
select * from pizzas where not (valor >=17 and valor <=20);

-- Selecionar todas as pizzas com valores iguais a R$ 15.00 e R$ 20.00
select * from pizzas where valor = 15 or valor = 20 ;
select * from pizzas where valor in (15,20,99);

-- Selecionar todas as pizzas com valores diferentes de R$ 15.00 e R$ 20.00
select * from pizzas where valor != 15 and valor != 20 ;
select * from pizzas where not (valor = 15 or valor = 20) ;
select * from pizzas where valor not in (15,20);

-- Selecionar todas as pizzas com valores não nulos
select * from pizzas where valor is not null;

-- Selecionar todas as pizzas com nomes que comecem com a letra E
select * from pizzas where nome like 'e%';

-- Selecionar todas as pizzas com nomes que terminam com a letra A
select * from pizzas where nome like '%a';

-- Selecionar todas as pizzas com nomes que tenham as letras "ESA"
select * from pizzas where nome like '%esa%';

-- Listar todas as colunas da tabela Pizza em ordem alfabética
select * from pizzas order by nome asc;

-- restringir o número de linhas retornadas pelo comando select
select * from pizzas order by valor desc limit 2;

-- Listar o nome e o valor da pizza em oredem decrescente de valor e crescente de nome
select * from pizzas order by valor desc, nome asc;

-- mostrar os valores sem repetição
select distinct valor from pizzas order by valor;

/* Funções de agregação
*Conhecidas como funções estatísticas, as funções de agregação obtem
*informação sobre conjuntos de linhas especificados
*AVG(coluna) Média dos valores da coluna
*COUNT Número de linhas
*MAX(coluna) Maior valor da coluna
*MIN(coluna) Menor valor da coluna
*SUM(coluna) Soma dos valores da coluna
*/

-- contar quantas pizzas estão cadastradas
select count(*) from pizzas; -- ou
select count(nome) from pizzas;
select * from pizzas;

-- qual a media dos preços das pizzas
select avg(valor)  as media from pizzas;
select avg(valor)  as media from pizzas where nome like '%esa';

-- qual o valor da pizza mais cara do cardapio 
select max(valor) as 'maior valor' from pizzas;

-- qual é o valor da pizza mais barata
select min(valor) as 'menor valor' from pizzas;

-- qual é o valor total do pedido numero 7
select * from itens_pedido;
select sum(valor) from itens_pedido where pedido_id = 7;

-- group by agrupa os pedidos. ex: tem 2 pedidos no id 1, ele agrupa esses 2 pedidos
select pedido_id as pedido, sum(valor) as 'valor pedido' from itens_pedido group by pedido_id;

-- vai mostar os pedidos que tem mais de 1 quantidade
select pedido_id as pedido, sum(valor) as 'valor pedido' from itens_pedido 
where quantidade > 1 group by pedido_id;

select pedido_id as pedido, 
sum(valor) as 'valor pedido', 
sum(quantidade) as 'qntdd pizzas',
avg(valor) as media,
sum(valor) / sum(quantidade) as 'valor medio'
from itens_pedido 
group by pedido_id;

-- INNER JOIN: Retorna registros quando há pelo menos uma correspondência em ambas as tabelas
select clientes.id as id_cliente, nome, telefone, pedidos.id as pedido, valor from clientes 
inner join pedidos on pedidos.cliente_id = clientes.id;

-- left join ou left outer join retorna todos os registros databela da esquerda
-- primeira tabela mencionada) e os registros correspondentes da tabela da direita
-- segunda tabela mncionada)
select clientes.id as id_cliente, nome, telefone, pedidos.id as pedido, valor from clientes
left join pedidos on pedidos.cliente_id = clientes.id;

-- right join ou right outer join retorna todos os registros da tabela da direita
-- segunda tabela mencionada) e os registros correspondentes da tabela da esquerda
-- primeira tabela mencionada)
select clientes.id as id_cliente, nome, telefone, pedidos.id as pedido, valor
from clientes
right join pedidos on pedidos.cliente_id = clientes.id; 

insert into pedidos(id, data, valor) values (9, '2024-10-02', 0);

-- quantidade de pedidos realizados por cliente, exibir nome do cliente e quantidade de pedidos realzados
select nome, count(pedidos.id)  from clientes 
left join pedidos on clientes.id = pedidos.cliente_id
group by nome;

select *from pedidos;
select * from clientes;
select *from itens_pedido;


-- quantos pedidos foram feitos no total
select count(pedido_id) as 'numero pedidos' from itens_pedido;

-- quantos pedidos foram feitos pelo cliente alexandre santos
select count(pedidos.id) as 'numero de pedidos' from pedidos where cliente_id= 1;

-- qual o valor total de todos os pedidos feitos ate agora
select sum(valor) as 'total pedidos' from itens_pedido;



select *from pedidos;
select *from clientes;
select *from itens_pedido;

-- 1 Liste todos os pedidos com o nome do cliente correspondente.
select clientes.id as cliente, nome, pedidos.id as pedidos from pedidos
inner join clientes on clientes.id = pedidos.cliente_id ;
-- -----------------------------------------------------------------------
-- correção
select pedidos.id as pedido, clientes.nome from pedidos
inner join clientes on pedidos.cliente_id = clientes.id;

-- 2 Quantos pedidos foram feitos no total?
select count(pedidos.id) as 'total pedidos' from pedidos;

-- 3 Liste os pedidos feitos após '2016-12-15' com o nome do cliente.
select pedidos.id as pedido, data, clientes.nome from pedidos
inner join clientes on pedidos.cliente_id = clientes.id
where data > '2016-12-15';

-- 4. Quantos pedidos foram feitos pelo cliente com o nome "Alexandre Santos"?
select count(pedidos.id) as 'numero pedidos', clientes.nome from pedidos 
inner join clientes on pedidos.cliente_id = clientes.id
where clientes.nome = 'Alexandre Santos';

-- 5. Liste todos os pedidos e seus respectivos clientes, incluindo pedidos feitos por clientes que foram excluídos da tabela clientes.
select pedidos.id as pedidos, clientes.nome from pedidos
left join clientes on clientes.id = pedidos.cliente_id;

-- 6. Qual o valor total de todos os pedidos feitos até agora?
select sum(valor) as valor_total from pedidos;

-- 7. Qual o total gasto por cada cliente?
select sum(valor) as valor_total, clientes.nome from pedidos
inner join clientes on clientes.id = pedidos.cliente_id
group by clientes.nome;

-- 8. Liste todos os clientes e seus pedidos feitos no mês de dezembro de 2016 (inclua clientes sem pedidos).
select clientes.nome, pedidos.id as pedido, pedidos.data, pedidos.valor from clientes
inner join pedidos on pedidos.cliente_id = clientes.id
where pedidos.data between '2016-12-01' and '2016-12-31 23:59:59';
-- ou where pedidos.data >= '2016-12-01' and pedidos.data <= '2016-12-31 23:59:59'

-- 9. Qual o valor médio dos pedidos realizados?
select avg(valor) as media from pedidos;

-- 10. Liste o valor total dos pedidos por cliente, incluindo pedidos feitos por clientes que foram excluídos (nome aparecerá como NULL).
select clientes.nome, sum(valor) as valor_total, count(pedidos.id) as total_pedidos from pedidos
left join clientes on clientes.id = pedidos.cliente_id
group by clientes.nome;

-- 11. Qual o valor do pedido mais caro registrado?
select max(valor) as maior_valor from pedidos;

-- 12. Qual o valor do pedido mais barato registrado?
select min(valor) as menor_valor from pedidos;

-- 13. Quantos pedidos cada cliente fez (mesmo que não tenham feito nenhum)?
select count(pedidos.id) as pedidos, clientes.nome from pedidos
right join clientes on clientes.id = pedidos.cliente_id
group by clientes.nome;

-- 14. Qual o pedido mais caro, exibir o nome do cliente e o valor do pedido.
select max(valor) as maior_valor,clientes.nome from pedidos
inner join clientes on clientes.id=pedidos.cliente_id;

-- 15. Qual a média de pizzas por pedido e quantos pedidos foram feitos?
select count(distinct pedido_id) as total_pedidos, avg(quantidade) as media_pizzas from itens_pedido;

-- 16. Qual o total de pizzas vendidas e o número de pedidos do cliente "Bruna Dantas"?
select sum(quantidade) as 'total pizzas', count(pedidos.id) as total_pedido from itens_pedido
inner join pedidos on itens_pedido.pedido_id = pedidos.id
inner join clientes on pedidos.cliente_id = clientes.id
where clientes.nome = 'Bruna Dantas';

-- 17. Qual o pedido mais caro e o mais barato do cliente "Laura Madureira"?
select max(valor) as 'maior valor', min(valor) as 'menor valor', clientes.nome from pedidos
inner join clientes on clientes.id= pedidos.cliente_id
where clientes.nome = 'Laura Madureira'
group by clientes.nome;

-- 18. Quantas pizzas cada cliente comprou no total?
select count(quantidade) as pizzas, clientes.nome from itens_pedido
inner join pedidos on itens_pedido.pedido_id = pedidos.id
inner join clientes on clientes.id = pedidos.cliente_id
group by clientes.nome;

-- 19. Qual o pedido mais barato, exibir o nome do cliente e o valor do pedido.
select min(valor) as pedido_barato, clientes.nome from pedidos
inner join clientes on clientes.id= pedidos.cliente_id
group by clientes.nome;

-- 20. Liste todos os clientes, mesmo que não tenham feito pedidos, com seus respectivos pedidos (se houver).
select clientes.id as id, clientes.nome as nome, pedidos.id from pedidos
right join clientes on clientes.id= pedidos.cliente_id;

-- 21. Liste todos os clientes com o valor total de seus pedidos (mesmo que não tenham feito pedidos).
select clientes.nome as nome, sum(valor) as total from pedidos
right join clientes on clientes.id= pedidos.cliente_id
group by clientes.nome;

-- 22. Liste os 3 clientes que mais gastou, exibir nome do cliente e o valor gasto.
select clientes.nome as nome, sum(valor) as total from pedidos
right join clientes on clientes.id= pedidos.cliente_id
group by clientes.nome
order by total desc
limit 3;
