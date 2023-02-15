CREATE DATABASE angeli
    WITH
    OWNER = dev
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.utf8'
    LC_CTYPE = 'en_US.utf8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

CREATE TABLE address (
	id SERIAL PRIMARY KEY,
	logradouro VARCHAR (100)NOT NULL,
	numero INT NOT NULL,
 	bairro VARCHAR(50) NOT NULL,
 	cidade VARCHAR(50) NOT NULL,
	estado VARCHAR(50) NOT NULL,
	cep VARCHAR(9) NOT NULL
);


CREATE TABLE cliente(
 	id SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
 	email VARCHAR(200) NOT NULL,
 	contato VARCHAR(15) NOT NULL,
	id_address INT NOT NULL,
	CONSTRAINT fk_address FOREIGN KEY (id_address) REFERENCES address(id)
);

CREATE TABLE apoiador (
	id SERIAL PRIMARY KEY,
	tipo VARCHAR(100) NOT NULL,
  	id_cliente INT,
  	CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id)
);

CREATE TABLE produtos(
  	id SERIAL PRIMARY KEY ,
    nome_produto VARCHAR(100) NOT NULL,
  	descricao VARCHAR(300) NOT NULL,
	photo VARCHAR(300 ) NOT NULL,
  	valor FLOAT NOT NULL,
  	altura_cm float not NULL,
  	comprimento_cm FLOAT NOT NULL,
  	largura_cm FLOAT NOT NULL,
  	peso_kg FLOAT NOT NULL
);

CREATE TABLE pedidos(
  	ID SERIAL PRIMARY KEY,
   	id_cliente INT NOT NULL,
  	id_produto INT NOT NULL,
  	quantidade INT not NULL,
	FOREIGN KEY (id_cliente) REFERENCES cliente(id),
  	FOREIGN KEY (id_produto) REFERENCES produtos(id)
);


INSERT INTO produtos(nome_produto, descricao, photo,valor, altura_cm, comprimento_cm, largura_cm, peso_kg) VALUES
('Porta Chaves Árvore do Amor','Porta chaves Árvore da vida decorativo feito em corações e folhas em Patchwork com muito amor e carinho para os lares de pessoas especiais como vocês. Contém e pinos dourados.', '/image_products/quadro-infantil-com-botoes-artesanato.jpg','180.00','50','50','3','7'),
('Quadro Artesal Árvore da Vida','Quadro artesal decorativo árvore da vida colorido.', '/image_products/arvore-da-vida.jpg','187.00','90','80','5','8'),
('Quadro Artesal Menina Africana','Quadro decorativo boneca africana em madeira, vestido com perola suas flores com uma bolinha de perola no meio e pintura degrade tudo feito a mão.','/image_products/quadro_menina_africana.png','245.00','60','90','3','7'),
('Conjunto de mesa 18 peças','Conjunto de mesa vermelho formado por 18 peças com objetivo de tornar suas experiências à mesa muito mais significativa.','/image_products/jogo_de_mesa.jpg','395.00','0','0','0','5'),
('Família de Gatos','Família de gatos composto por 4 unidades  feito com tais tradicional nas cores vermelho, castanho claro.', '/image_products/familia_gatos.jpeg','93.00','12.5','10','3','0.725'),
('Casal de Bonecos','Casal de bonecos feitos com o tradiocinal Tais.', '/image_products/Casal_bonecos.jpeg','114.00','25','10','5.5','0.740'),
('Família de Gatos','Família de gatos composto por 4 unidades feito com o tais tradicional nas cores preto, bege e vermelho.', '/image_products/Familia_de_gatos.jpeg','98','12','8','3.5','0.650');

INSERT INTO address (logradouro,numero,bairro,cidade,estado, cep) VALUES
('Rua Guilherme Mazeto','200','Pinheirinho','Curitiba','PR','81110-436'),
('Rua Amoroso Lima','28','Cidade Nova','Rio de Janeiro','RJ','20211-120'),
('Rua Boa Vista 12','212','Boa Vista','Goiânia','Goiás','74477-414'),
('Rua do sol ','106','Vila do Sol','João Pessoa','PB','58800-436');

INSERT INTO cliente (nome,email,contato,id_address) VALUES
('João Pedro','joaoarvalho30@gmail.com','(61) 99323-0446','3'),
('Ângela Amaral','angela.hawerroth@gmail.com','(41)99999-8888','2'),
('Rafael Carvalho ','rafael.carvalho12@gmail.com','(83) 99323-0446','3'),
('Juliana Soares','juliana22.soares@gmail.com','(21)99999-8888','1');

INSERT INTO apoiador (tipo,id_cliente)VALUES
('Voluntário','1'),
('Patrocinador','3'),
('Doador','2');

INSERT INTO pedidos (id_cliente,id_produto,quantidade) VALUES
('1','5','10'),
('2','4','4'),
('3','1','2');


/* Consultas simples e juntando tabelas */

SELECT * FROM address;
SELECT * FROM cliente;
SELECT * FROM apoiador;
SELECT * FROM produtos;
SELECT * FROM pedidos;


SELECT * FROM cliente
RIGHT JOIN pedidos
ON cliente.id = pedidos.id_cliente;

SELECT * FROM cliente
RIGHT JOIN pedidos
ON cliente.id = pedidos.id_cliente
LEFT join produtos
ON pedidos.id_produto = produtos.id;

SELECT * FROM cliente
RIGHT JOIN pedidos
ON cliente.id = pedidos.id_cliente
LEFT join produtos
ON pedidos.id_produto = produtos.id
where produtos.largura_cm = '3';


SELECT * FROM cliente
RIGHT JOIN address
ON cliente.id_address = address.id;

SELECT * FROM apoiador
LEFT JOIN cliente
ON apoiador.id_cliente = cliente.id;
