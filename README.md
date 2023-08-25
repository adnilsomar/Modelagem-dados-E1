<h1 align="center"> <img src="https://github.com/adnilsomar/Modelagem-dados-E1/blob/main/assets/images__2_-removebg-preview.png" width=30/> Modelagem de dados </h1>

## Caso: Empresa de Produção ABC

## Objetivo:
Criar um modelo logico dimensional para poder responder as tarefas de negocio da empresa, a partir do modelo logico transacional.

## Introdução:

A empresa de produção ABC é uma entidade fictícia criada com o propósito de ilustrar como dados transacionais podem ser transformados em informações estratégicas por meio da criação de um modelo dimensional. Neste exercício, partiu-se de um modelo transacional da empresa para conceber um modelo dimensional capaz de abordar e responder a várias tarefas de negócio.


## Modelo transacional da empresa ABC
 <img src="https://github.com/adnilsomar/Modelagem-dados-E1/blob/main/assets/TransacionalProducao.png" width=2000 height=auto/>

## Transações:

### Realização de um Pedido:

* Um cliente cria um novo pedido, fornecendo a lista de produtos e as quantidades desejadas.
* A data e o estado do pedido (pendente) são registrados.
* Os detalhes do pedido são criados, relacionando os produtos e quantidades com o pedido.
  
### Gestão de Inventário:

* É possível consultar e atualizar a quantidade em estoque de um produto específico.
* O registro da chegada de novos produtos dos fornecedores é feito.

### Registro de Envio:

* Quando um pedido é concluído, a data de envio é registrada e o estado do pedido é atualizado.
  
### Faturamento e Pagamento:

* Uma fatura é gerada ao concluir um pedido, calculando o total a ser pago.
* O pagamento é registrado pelo cliente.
  
### Gestão de Fornecedores:

* Novos fornecedores podem ser adicionados e suas informações atualizadas.
* Os produtos fornecidos por cada fornecedor são registrados.
 
### Gestão de Funcionários:

* Novos funcionários podem ser adicionados e suas informações atualizadas.
* O agendamento de funcionários para pedidos e seu desempenho são registrados.

## Tarefas de negocio:

### **:green_circle:Receitas totais por mês no último ano**<br>
Analisaremos os dados para identificar as receitas totais por mês durante o último ano. Isso permitirá compreender os padrões sazonais de receitas e tomar decisões orientadas pela variação mensal.

### **:green_circle:Produtos mais vendidos em cada categoria no último trimestre.**<br>
Identificar os produtos mais vendidos em cada categoria durante o último trimestre. Essa análise ajudará a direcionar estoques, promoções e estratégias de marketing de forma mais precisa.

### **:green_circle:Tendência de vendas por dia da semana**<br>
Analisar as vendas por dia da semana, entender melhor as tendências de consumo e ajustar as operações para atender à demanda variável.

### **:green_circle:Desempenho de vendas de cada funcionário no último semestre**<br>
Avaliar o desempenho de vendas de cada funcionário durante o último semestre, permitindo reconhecer os contribuintes mais eficazes e identificar áreas para treinamento e desenvolvimento.

### **:green_circle:Taxa de cumprimento de pedidos por fornecedor**<br>
Analisar a taxa de cumprimento de pedidos por fornecedor para garantir relações de suprimento confiáveis e otimizar a cadeia de suprimentos.

### **:green_circle:Relação entre tempo de envio e satisfação do cliente**<br>
Investigar a relação entre o tempo de envio e a satisfação do cliente para determinar se há uma correlação entre esses fatores e tomar medidas para melhorar a experiência do cliente.

### **:green_circle:Clientes com maior valor de compra no último ano**<br>
Identificar clientes que realizaram as maiores compras durante o último ano, permitindo reconhecer e recompensar os clientes mais valiosos.

### **:green_circle:Produtos com queda significativa nas vendas**<br>
Analisar os produtos que experimentaram uma queda significativa nas vendas para entender as razões por trás dessa diminuição e elaborar estratégias de recuperação.

Essas tarefas ilustram como a transformação de dados em insights dimensionais pode aprimorar a compreensão e a tomada de decisões em uma organização fictícia.

## Criação do Modelo Lógico Dimensional
 <img src="https://github.com/adnilsomar/Modelagem-dados-E1/blob/main/assets/DimensionalProducao.png" width=2000 height=auto/>

Para a construção deste modelo, identificamos as dimensões que serão pertinentes para responder às perguntas: "Tempo", "Produto", "Colaborador", "Cliente" e "Fornecedor". Além disso, identificamos os eventos (fatos) que desejamos analisar com base nas questões propostas. Também abordamos aspectos como granularidade, hierarquia e relações para aprimorar a compreensão e a representação dos dados. Neste modelo também foi usado a "SK (Surrogate Key)", que são chaves substitutas usadas nas tabelas de dimensão em vez das chaves primárias originais dos dados de origem. Essas chaves substitutas não possuem significado próprio, mas permitem uma gestão mais eficiente dos dados no data warehouse. O objetivo de usar chaves substitutas ("SK") em vez das chaves primárias originais é melhorar o desempenho em consultas e análises. Ao usar chaves substitutas, evita-se a necessidade de repetir as mesmas chaves na tabela de fatos, o que economiza espaço em disco e agiliza as operações de junção entre as tabelas de dimensão e a tabela de fatos.

 ## Criação do modelo físico

Após a criação do modelo lógico dimensional, o próximo passo consistiu na implementação do modelo físico por meio da linguagem SQL com MySQL.

```
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

```

## Respondendo as tarefas de negocio

### Aqui estão alguns exemplos de como as perguntas poderiam ser respondidas usando combinações de tabelas:

1. Quais são as receitas totais por mês durante o último ano?
   Seria usada a tabela de fatos para somar as receitas e combinada com a dimensão de tempo para filtrar por mês e ano.
   
2. Quais são os produtos mais vendidos em cada categoria durante o último trimestre?
   Seria usada a tabela de fatos para identificar a quantidade de produtos vendidos e combinada com a dimensão de produto para filtrar por categoria e a dimensão de tempo para filtrar por trimestre.
   
3. Qual é a tendência de vendas por dia da semana?
   Seria usada a tabela de fatos para somar as vendas e combinada com a dimensão de tempo para agrupar por dia da semana.

4. Qual é o desempenho de vendas de cada funcionário durante o último semestre?
 Seria usada a tabela de fatos para somar as vendas e combinada com a dimensão de funcionário para filtrar por funcionário e a dimensão de tempo para filtrar por semestre.

5. Qual é a taxa de cumprimento de pedidos por fornecedor?
   Seria usada a tabela de fatos para calcular a taxa de cumprimento (número de pedidos completados dividido pelo número total de pedidos) e combinada com a dimensão de fornecedor.

6. Qual é a relação entre o tempo de envio e a satisfação do cliente?
   Seria usada a tabela de fatos para comparar o tempo de envio com as avaliações de satisfação dos clientes e combinada com a dimensão de tempo e possivelmente a dimensão de cliente.
   
7. Quais são os clientes com maior valor de compra durante o último ano?
   Seria usada a tabela de fatos para identificar as receitas por cliente e combinada com a dimensão de cliente e a dimensão de tempo para filtrar por ano.

8. Quais são os produtos que tiveram uma diminuição significativa nas vendas?
   Seria usada a tabela de fatos para comparar as vendas atuais com as vendas passadas e combinada com a dimensão de produto.
 





