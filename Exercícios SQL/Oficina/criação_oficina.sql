-- --------------------------------------------------------------------------------------------------------------------------------------

													-- Criando esquema da oficina --

-- --------------------------------------------------------------------------------------------------------------------------------------
CREATE SCHEMA IF NOT EXISTS oficina DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_cs ;
USE oficina;

-- --------------------------------------------------------------------------------------------------------------------------------------

													   -- Cadastro de contas --

-- --------------------------------------------------------------------------------------------------------------------------------------
    
    CREATE TABLE IF NOT EXISTS Conta_PJ (
  idConta_PJ INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  CNPJ CHAR(14) NOT NULL,
  razao_social VARCHAR(80) NOT NULL,
  nome_fantasia VARCHAR(35) NOT NULL,
  inicio_atividade DATE NOT NULL,
  status_atividade VARCHAR(47) NOT NULL,
  CONSTRAINT unique_cnpj_cliente UNIQUE (CNPJ)
  );


CREATE TABLE IF NOT EXISTS Conta_PF (
  idConta_PF INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Nome_completo VARCHAR(70) NOT NULL,
  CPF CHAR(11) NOT NULL,
  CONSTRAINT unique_cpf_cliente UNIQUE (CPF)
);


CREATE TABLE IF NOT EXISTS Contatos (
  idContato INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Endereço_completo VARCHAR(150) NOT NULL,
  Observação_endereço VARCHAR(200),
  Email VARCHAR(60),
  DDD_telefone CHAR(3) NOT NULL,
  Número_telefone CHAR(9) NOT NULL,
  Contato_alternativo VARCHAR(150)
  );


CREATE TABLE IF NOT EXISTS Cliente (
  idCliente INT NOT NULL AUTO_INCREMENT,
  idContato INT NOT NULL,
  idConta_PJ INT UNIQUE,
  idConta_PF INT UNIQUE,
  PRIMARY KEY (idCliente, idContato),
  CONSTRAINT fk_cliente_contapj FOREIGN KEY (idConta_PJ) REFERENCES Conta_PJ(idConta_PJ),
  CONSTRAINT fk_cliente_contapf FOREIGN KEY (idConta_PF) REFERENCES Conta_PF(idConta_PF),
  CONSTRAINT fk_contato_cliente FOREIGN KEY (idContato) REFERENCES Contatos(idContato)
);


CREATE TABLE IF NOT EXISTS Funcionários (
  idFuncionário INT AUTO_INCREMENT,
  idContato INT,
  Nome_completo VARCHAR(45) NOT NULL,
  CPF VARCHAR(11) NOT NULL,
  Cargo VARCHAR(25) NOT NULL,
  Salário DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (idFuncionário, idContato),
  CONSTRAINT fk_contato_funcionario FOREIGN KEY (idContato) REFERENCES Contatos(idContato)
);

-- --------------------------------------------------------------------------------------------------------------------------------------

													   -- Cadastro de veículos --

-- --------------------------------------------------------------------------------------------------------------------------------------
 
CREATE TABLE IF NOT EXISTS Veículo (
  idVeículo INT AUTO_INCREMENT PRIMARY KEY,
  Modelo VARCHAR(45) NOT NULL,
  Placa CHAR(7) NOT NULL
);


CREATE TABLE IF NOT EXISTS VeículoXClientes (
  idVeículo INT NOT NULL,
  idCliente INT NOT NULL,
  PRIMARY KEY (idVeículo, idCliente),
  CONSTRAINT fk_veículo_por_cliente FOREIGN KEY (idVeículo) REFERENCES Veículo(idVeículo),
  CONSTRAINT fk_cliente_por_veículo FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);


-- --------------------------------------------------------------------------------------------------------------------------------------

													   -- Cadastro de peças --

-- --------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS `Peças` (
  idPeça INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Nome VARCHAR(60) NOT NULL,
  Quantidade_disponível INT NOT NULL DEFAULT 1
);


-- --------------------------------------------------------------------------------------------------------------------------------------

													   -- Fornecimento de peças --

-- -------------------------------------------------------------------------------------------------------------------------------------- 


CREATE TABLE IF NOT EXISTS Fornecedor (
  idFornecedor INT NOT NULL AUTO_INCREMENT,
  idCliente INT NOT NULL,
  PRIMARY KEY (idFornecedor, idCliente),
  CONSTRAINT fk_fornecedor_idCliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
  );
  
  
  CREATE TABLE IF NOT EXISTS `Fornecimento_de_peças` (
  idPeça INT NOT NULL,
  idFornecedor INT NOT NULL,
  Quantidade INT NOT NULL,
  Valor_da_compra DECIMAL(12,2) NOT NULL,
  Observação VARCHAR(200),
  PRIMARY KEY (idPeça, idFornecedor),
  CONSTRAINT fk_fornecimentoPeças_idPeça FOREIGN KEY (idPeça) REFERENCES `Peças`(idPeça),
  CONSTRAINT fk_fornecimentoPeças_idFornecedor FOREIGN KEY (idFornecedor) REFERENCES Fornecedor(idFornecedor)
  );
  
-- --------------------------------------------------------------------------------------------------------------------------------------

													   -- Movimentações - Ordem de Serviço --

-- --------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS Pagamentos (
  idPagamento INT AUTO_INCREMENT PRIMARY KEY,
  Tipo_pagamento ENUM('Boleto','Pix','Cartão') NOT NULL DEFAULT 'Boleto',
  Número_cartão CHAR(16),
  CVC CHAR(3),
  Validade_cartão CHAR(4),
  cod_PIX VARCHAR(100),
  cod_boleto VARCHAR(100),
  Pagamentocol VARCHAR(45)
);


 
CREATE TABLE IF NOT EXISTS Ordem_de_serviço (
  idOrdem INT AUTO_INCREMENT,
  idVeículo INT,
  idPagamento INT,
  Data_emissão DATE NOT NULL,
  Data_conclusão DATE,
  Valor_serviço DECIMAL(10,2) NOT NULL,
  Status_atual ENUM('Aguardando aprovação do cliente', 'Aguardando chegada de materiais', 'Serviço concluído')
  NOT NULL DEFAULT 'Aguardando aprovação do cliente',
  Observação VARCHAR(300),
  PRIMARY KEY (idOrdem, idVeículo),
  CONSTRAINT fk_ordem_de_serviço_idPagamento FOREIGN KEY (idPagamento) REFERENCES Pagamentos(idPagamento),
  CONSTRAINT fk_ordem_de_serviço_idVeículo FOREIGN KEY (idVeículo) REFERENCES Veículo(idVeículo)
);


CREATE TABLE IF NOT EXISTS FuncionárioXOrdem (
  idOrdem INT NOT NULL, 
  idFuncionário INT NOT NULL,
  PRIMARY KEY (idOrdem, idFuncionário),
  CONSTRAINT fk_funcionarioXordem_idFuncionario FOREIGN KEY (idFuncionário) REFERENCES Funcionários(idFuncionário),
  CONSTRAINT fk_funcionarioXordem_idOrdem FOREIGN KEY (idOrdem) REFERENCES Ordem_de_serviço(idOrdem)
  );



CREATE TABLE IF NOT EXISTS PeçasXOrdem (
  idOrdem INT NOT NULL,
  idPeça INT NOT NULL,
  Quantidade INT NOT NULL,
  PRIMARY KEY (idOrdem, idPeça),
  CONSTRAINT fk_peçasXOrdem_idPeça FOREIGN KEY (idPeça) REFERENCES `Peças`(idPeça),
  CONSTRAINT fk_peçasXOrdem_idOrdem FOREIGN KEY (idOrdem) REFERENCES Ordem_de_serviço(idOrdem)
);
 

