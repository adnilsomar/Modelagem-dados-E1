CREATE SCHEMA dimensionalproducao;

CREATE  TABLE dimensionalproducao.dim_cliente ( 
	sk_cliente           INT  NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	dim_id_cliente       VARCHAR(20),
	nome_cliete          VARCHAR(50),
	sobrenome_cliente    VARCHAR(50),
	endereço             VARCHAR(100),
	telefone             VARCHAR(20),
	email                VARCHAR(50)       
 );

CREATE  TABLE dimensionalproducao.dim_fornecedor ( 
	sk_fornecedor        INT  NOT NULL AUTO_INCREMENT    PRIMARY KEY,
	dim_id_fornecedor    VARCHAR(20),
	nome_empresa         VARCHAR(50),
	endereço             VARCHAR(100),
	telefone             VARCHAR(20),
	email                VARCHAR(50)       
 );
CREATE  TABLE dimensionalproducao.dim_funcionario ( 
	sk_funcionario       INT  NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	dim_id_funcionario   VARCHAR(20),
	nome                 VARCHAR(50),
	sobrenome            VARCHAR(50),
	cargo                VARCHAR(20),
	data_contratacao     DATE,
	salario              DECIMAL(10,2)       
 );

CREATE  TABLE dimensionalproducao.dim_produto ( 
	sk_produto           INT  NOT NULL AUTO_INCREMENT   PRIMARY KEY,
	dim_id_produto       VARCHAR(20),
	nome_produto         VARCHAR(50),
	descripcao_produto   TEXT(200),
	preco_unitario       DECIMAL(10,2),
	quantidade_inventario INT,
	categoria            VARCHAR(20)       
 ); 

CREATE  TABLE dimensionalproducao.dim_tempo ( 
	sk_data              INT  NOT NULL AUTO_INCREMENT  PRIMARY KEY,
	dim_data             DATE,
	mes                  INT,
	ano                  INT,
	dia_semana           VARCHAR(10),
	dia                  INT     
 );

CREATE  TABLE dimensionalproducao.fato_vendas ( 
	sk_cliente           INT,
	sk_produto           INT,
	sk_funcionario       INT,
	sk_fornecedor        INT,
	sk_data              INT,
	ingresos             DECIMAL(10,2),
	quantidade_produtos_vendidoa INT,
	tempo_envio          INT       
 ); 

ALTER TABLE dimensionalproducao.fato_vendas ADD CONSTRAINT fk_fato_vendas_dim_cliente FOREIGN KEY ( sk_cliente ) REFERENCES dimensionalproducao.dim_cliente( sk_cliente ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE dimensionalproducao.fato_vendas ADD CONSTRAINT fk_fato_vendas_dim_produto FOREIGN KEY ( sk_produto ) REFERENCES dimensionalproducao.dim_produto( sk_produto ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE dimensionalproducao.fato_vendas ADD CONSTRAINT fk_fato_vendas_dim_fornecedor FOREIGN KEY ( sk_fornecedor ) REFERENCES dimensionalproducao.dim_fornecedor( sk_fornecedor ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE dimensionalproducao.fato_vendas ADD CONSTRAINT fk_fato_vendas_dim_funcionario FOREIGN KEY ( sk_funcionario ) REFERENCES dimensionalproducao.dim_funcionario( sk_funcionario ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE dimensionalproducao.fato_vendas ADD CONSTRAINT fk_fato_vendas_dim_tempo FOREIGN KEY ( sk_data ) REFERENCES dimensionalproducao.dim_tempo( sk_data ) ON DELETE CASCADE ON UPDATE CASCADE;

