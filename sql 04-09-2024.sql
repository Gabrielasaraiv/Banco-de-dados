create database redes;

use redes;

create table usuarios(
id int not null auto_increment primary key,
email varchar(45) not null unique,
nome varchar(100) not null,
data_criacao date not null
);

create table postagens(
id int not null auto_increment primary key,
texto varchar(255),
imagem varchar(45),
data_publicacao date not null,
usuarios_id int not null,
foreign key (usuarios_id) references usuarios (id)
);

create table comentarios(
id int not null auto_increment primary key,
texto varchar(255) not null,
data_criacao date not null,
usuarios_id int not null,
postagens_id int not null,
foreign key (usuarios_id) references usuarios (id),
foreign key (postagens_id) references postagens (id)
);

create table curtidas(
usuarios_id int not null,
postagens_id int not null,
primary key (usuarios_id, postagens_id),
foreign key (usuarios_id) references usuarios (id),
foreign key (postagens_id) references postagens (id)
);


insert into usuarios (email, nome, data_criacao) values ('ricardo@senai.com', 'Ricardo Santos', '2018-07-20');
insert into usuarios (email, nome, data_criacao) values ('ana@senai.com', 'Ana Carolina', '2019-12-09');
insert into usuarios (email, nome, data_criacao) values ('gabi@senai.com', 'Gabriel Rodrigues', '2021-01-02');
insert into usuarios (email, nome, data_criacao) values ('Luiza@senai.com', 'Maria Luiza', '2020-05-14');
insert into usuarios (email, nome, data_criacao) values ('carlos@senai.com', 'Carlos Almeida', '2017-01-24');
select * from usuarios;

-- usuario 1
insert into postagens (texto, data_publicacao, usuarios_id) values ('Hoje é meu aniversário! Parabéns para mim.',
'2019-02-06', 1);
insert into postagens (texto, imagem, data_publicacao, usuarios_id) values ('Festa de aniversário com a familia!',
'imagem-festa', '2019-02-07', 1);
insert into postagens (imagem, data_publicacao, usuarios_id) values ('foto-minha',
'2019-04-18', 1);
insert into postagens (texto, imagem, data_publicacao, usuarios_id) values ('Parabéns mãe, te amo muito!',
'imagem-mãe', '2019-07-01', 1);
insert into postagens (texto, data_publicacao, usuarios_id) values ('Feliz natal!',
'2019-12-25', 1);
select * from postagens;


-- usuario 2
insert into postagens (texto, data_publicacao, usuarios_id) values ('Cachorrinho novo! Bem vindo a família.',
'2019-12-28', 2);
insert into postagens (texto, imagem, data_publicacao, usuarios_id) values ('Eu e meu bebê',
'imagem-cachorrinho', '2020-02-15', 2);
insert into postagens (texto, data_publicacao, usuarios_id) values ('Hoje é aniversário do meu pai, obrigado por tudo, te amo!',
'2020-02-20', 2);
insert into postagens (texto, imagem, data_publicacao, usuarios_id) values ('Viagem com a família',
'imagem-paris', '2020-03-01', 2);
insert into postagens (texto, data_publicacao, usuarios_id) values ('Ferias!',
'2020-07-05', 2);
select * from postagens;