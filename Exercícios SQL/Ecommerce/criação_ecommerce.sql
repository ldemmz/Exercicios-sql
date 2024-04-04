

	-- Criação do esquema --


CREATE SCHEMA IF NOT EXISTS ecommerce DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_cs ;
USE ecommerce ;



	-- Tipos de contas --



CREATE TABLE IF NOT EXISTS conta_pf (
  idConta_PF INT AUTO_INCREMENT PRIMARY KEY,
  primeiro_nome VARCHAR(12) NOT NULL,
  abv_meio_nome VARCHAR(3),
  sobrenome VARCHAR(20) NOT NULL,
  CPF CHAR(11) NOT NULL,
 CONSTRAINT unique_cpf_conta UNIQUE (CPF)
 );


CREATE TABLE IF NOT EXISTS conta_pj (
  idConta_PJ INT AUTO_INCREMENT PRIMARY KEY,
  CNPJ CHAR(14) NOT NULL,
  razao_social VARCHAR(80) NOT NULL,
  nome_fantasia VARCHAR(35) NOT NULL,
  inicio_atividade DATE,
  status_atividade VARCHAR(47),
  tipo_usuario ENUM('Comprador', 'Vendedor', 'Fornecedor') DEFAULT 'Comprador',
 CONSTRAINT unique_cnpj_conta UNIQUE (CNPJ)
);

CREATE TABLE IF NOT EXISTS usuario (
  idUsuario INT AUTO_INCREMENT PRIMARY KEY,
  idConta_PF INT,
  idConta_PJ INT,
  CONSTRAINT fk_usuario_contapf FOREIGN KEY (idConta_PF) REFERENCES conta_pf(idConta_PF)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_usuario_contapj FOREIGN KEY (idConta_PJ) REFERENCES conta_pj(idConta_PJ)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);



	-- Endereço e contato das contas --

 
 
CREATE TABLE IF NOT EXISTS contatos (
  idContato INT AUTO_INCREMENT,
  idUsuario INT NOT NULL,
  tipo_contato ENUM('Telefone fixo', 'Celular', 'E-mail') DEFAULT 'Celular',
  DDD CHAR(3),
  numero_contato CHAR(9),
  email VARCHAR(45),
  PRIMARY KEY (idContato, idUsuario),
  CONSTRAINT fk_contatos_usuario FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS endereços (
  idEndereço INT AUTO_INCREMENT,
  idUsuario INT,
  tipo_residência VARCHAR(25) NOT NULL,
  país VARCHAR(48) NOT NULL,
  estado VARCHAR(60) NOT NULL,
  cidade VARCHAR(60) NOT NULL,
  endereço VARCHAR(155) NOT NULL,
  complemento VARCHAR(200),
  PRIMARY KEY (idEndereço, idUsuario),
  CONSTRAINT fk_endereço_usuario FOREIGN KEY (idUsuario) REFERENCES usuario (idUsuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);



	-- Produtos e vendas  -- 



CREATE TABLE IF NOT EXISTS produtos (
  idProduto INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(35) NOT NULL,
  tipo ENUM('Eletrodomésticos', 'Brinquedos', 'Vestimentas', 'Alimentos', 'Não Definido') DEFAULT 'Não Definido',
  preço DECIMAL(10,2) NOT NULL,
  avaliação FLOAT NOT NULL,
  descrição VARCHAR(200) NOT NULL,
  dimensão VARCHAR(10)
  );
  


CREATE TABLE IF NOT EXISTS pagamentos (
  idPagamento INT NOT NULL AUTO_INCREMENT,
  idUsuario INT NOT NULL,
  tipo_pagamento ENUM('Boleto', 'Pix', 'Cartão') DEFAULT 'Boleto',
  numero_cartao CHAR(16),
  CVC CHAR(3) ,
  validade_cartao CHAR(4) ,
  cod_PIX VARCHAR(100),
  cod_boleto VARCHAR(100),
  PRIMARY KEY (idPagamento, idUsuario),
  CONSTRAINT fk_usuario_pagamentos FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario)
  );
  
CREATE TABLE IF NOT EXISTS pedidos (
  idPedido INT AUTO_INCREMENT,
  idUsuario INT NOT NULL,
  idPagamento INT NOT NULL,
  valor_pagamento DECIMAL(10,2) NOT NULL,
  frete DECIMAL(6,2) NOT NULL,
  status_pedido ENUM('Em Processamento', 'Confirmado', 'Cancelado') NOT NULL DEFAULT 'Em Processamento',
  descrição VARCHAR(200) NOT NULL,
  PRIMARY KEY (idPedido, idUsuario, idPagamento),
  CONSTRAINT fk_pedidos_usuario FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_pedidos_pagamentos FOREIGN KEY (idPagamento) REFERENCES pagamentos(idPagamento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    );



	-- Tabela para interpretar quantos produtos serão necessários de cada id para determinado pedido --



CREATE TABLE IF NOT EXISTS Relação_pedidoXproduto (
	idPedido INT,
	idProduto INT,
	quantidade INT NOT NULL,
	PRIMARY KEY (idProduto, idPedido),
    	CONSTRAINT fk_idpedidos_produto FOREIGN KEY (idPedido) REFERENCES pedidos(idPedido)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT fk_idprodutos_pedido FOREIGN KEY (idProduto) REFERENCES produtos(idProduto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION

);


	-- Registro de entregas -- 



CREATE TABLE IF NOT EXISTS entregas (
  idEntrega INT AUTO_INCREMENT,
  idPedido INT,
  idEndereço INT,
  cod_rastreio VARCHAR(12) NOT NULL,
  status_entrega ENUM('Em Processamento', 'Em trânsito', 'Entregue') DEFAULT 'Em Processamento',
  PRIMARY KEY (idEntrega, idPedido, idEndereço),
  CONSTRAINT fk_entrega_pedidos FOREIGN KEY (idPedido) REFERENCES pedidos(idPedido)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_entrega_endereço FOREIGN KEY (idEndereço) REFERENCES endereços(idEndereço)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);



	-- Gerenciamento de estoque --



CREATE TABLE IF NOT EXISTS estoque (
  idEstoque INT AUTO_INCREMENT,
  idEndereço INT,
  nome_estoque VARCHAR(45) NOT NULL,
  PRIMARY KEY (idEstoque, idEndereço),
  CONSTRAINT fk_estoque_endereços FOREIGN KEY (idEndereço) REFERENCES endereços (idEndereço)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS verificação_de_estoque (
  idProduto INT,
  idEstoque INT,
  quantidade INT NOT NULL,
  PRIMARY KEY (idProduto, idEstoque),
  CONSTRAINT fk_produtosEmEstoque_idProduto FOREIGN KEY (idProduto) REFERENCES produtos(idProduto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_produtosEmEstoque_idEstoque FOREIGN KEY (idEstoque) REFERENCES estoque(idEstoque)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);



	-- Controle de distribuição Vendedores/Fornecedores --
    
    
    
CREATE TABLE IF NOT EXISTS produtos_vendedoresXfornecedores (
  idUsuario INT,
  idProduto INT,
  quantidade INT NOT NULL,
  valor_unitario DECIMAL (8,2),
  valor_total_pago DECIMAL (10,2),
  status_atual ENUM('Produto solicitado', 'Produto entregue') DEFAULT 'Produto solicitado',
  comentário VARCHAR(350),
  PRIMARY KEY (idUsuario, idProduto),
  CONSTRAINT fk_idUsuario_vendedorXfornecedor FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_idProduto_vendedorXfornecedor FOREIGN KEY (idProduto) REFERENCES produtos(idProduto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

