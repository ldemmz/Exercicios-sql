-- --------------------------------------------------------------------------------------------------------------------------------------

								-- Inserção de dados nas tabelas para consultas posteriores --

-- --------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Conta_PJ (CNPJ, razao_social, nome_fantasia, inicio_atividade, status_atividade) VALUES
  ('12345678901234', 'Oficina HAHA Ltda.', 'Oficina HAHA', '2023-02-26', 'Ativa'),
  ('98765432109876', 'Teste Teste Teste', 'Teste loja', '2022-05-15', 'Ativa');

INSERT INTO Conta_PF (Nome_completo, CPF) VALUES
  ('Leonardo de C P Rodrigues', '12345678901'),
  ('Pessoa Aleatória da Vida', '98765432101');

INSERT INTO Contatos (Endereço_completo, Observação_endereço, Email, DDD_telefone, Número_telefone, Contato_alternativo) VALUES
  ('Rua jardim Floresta, N° 322, Bairro Tal, Uberlândia, Minas Gerais', 'Perto do boneco de boné', 'contato@oficinateste.com', '034', '123456789', NULL),
  ('Avenida Tô Perdido, N° 001, Bairro Não sei, São Paulo, São Paulo', NULL , 'leo9@otiklsk.com', '011', '987654321', NULL),
  ('Endereço aleatório_1','Ao lado da padaria', 'emailteste@exemplo.com.br','011','123321123',NULL),
  ('Rua do Amendoim,  N° 9, Bairro da Goiaba, São Paulo, São Paulo', NULL, NULL, '011', '112233445', '011 122112212'),
  ('Socorro mano, eu perdi minha casa!', 'É sério!!', 'emailemaillala@exemplo.com', '011', '994488552', NULL),
  ('Palácio de Jade', 'Lá no alto', 'dragaoguerreiro@alenda.com', '999', '999999999', NULL);
  
INSERT INTO Cliente (idContato, idConta_PJ, idConta_PF) VALUES
  (1, 1, NULL),
  (2, NULL, 1),
  (3, NULL, 2),
  (5, 2, NULL);

INSERT INTO Funcionários (idContato, Nome_completo, CPF, Cargo, Salário) VALUES
  (6, 'Mario Bros', '87654321098', 'Mecânico', 3000.00),
  (4, 'Everton Sobrenome Feio', '76543210987', 'Aprendiz', 1300.00);

INSERT INTO Veículo (Modelo, Placa) VALUES
  ('Toyota Corolla 2008 Branco', 'ABC1234'),
  ('Volkswagen Gol 1999 Preto', 'DEF5678');

INSERT INTO VeículoXClientes (idVeículo, idCliente) VALUES
  (1, 1),
  (2, 2);

INSERT INTO Peças (Nome, Quantidade_disponível) VALUES
  ('Óleo do Motor', 50),
  ('Pastilhas de Freio', 100),
  ('Motor ABC', 800);

INSERT INTO Fornecedor (idCliente) VALUES 
   (1),
   (4);

INSERT INTO Fornecimento_de_peças (idPeça, idFornecedor, Quantidade, Valor_da_compra, Observação) VALUES
  (1, 1, 20, 150.00, 'Promoção de óleo'),
  (2, 2, 50, 100.00, 'Desconto para revendedores');

INSERT INTO Pagamentos (Tipo_pagamento, Número_cartão, CVC, Validade_cartão, cod_PIX, cod_boleto, Pagamentocol) VALUES
  ('Cartão', '1234567890123456', '123', '1225', NULL, NULL, NULL),
  ('Boleto', NULL, NULL, NULL, NULL, 'B1234567890', NULL);


INSERT INTO Ordem_de_serviço (idVeículo, idPagamento, Data_emissão, Data_conclusão, Valor_serviço, Status_atual, Observação) VALUES
  (1, 1, '2023-08-22', '2023-08-22', 350.00, 'Serviço concluído','alguma informação útil'),
  (2, 2, '2023-08-01', NULL, 2000.00, 'Aguardando chegada de materiais','observação 12123131');
  
INSERT INTO FuncionárioXOrdem (idOrdem, idFuncionário) VALUES
  (1, 1),
  (1, 2),
  (2, 1);
  
  INSERT INTO PeçasXOrdem (idOrdem, idPeça, Quantidade)	VALUES
  (1, 1, 1),
  (1, 2, 4),
  (2, 3, 1);
-- --------------------------------------------------------------------------------------------------------------------------------------

															-- Consultas --

-- --------------------------------------------------------------------------------------------------------------------------------------
  
												  -- Consultando veículos listados --
 
SELECT * FROM Veículo;  

									  -- Descobrindo qual é o funcionário com maior salário -- 
 
SELECT Nome_completo as 'Funcionário com o maior salário', Cargo, Salário 
FROM Funcionários 
ORDER BY Salário DESC LIMIT 1; 

								-- Agora filtrando por funcionários que ganham abaixo de 2000 reais --
                                      
SELECT Nome_completo as 'Nome do funcionário', Cargo, Salário 
FROM Funcionários 
HAVING Salário < 2000; 


									-- Pesquisando o cliente, modelo de carro, placa e número --
SELECT 
	CASE
		WHEN pf.Nome_completo IS NOT NULL THEN pf.Nome_completo
		WHEN pj.razao_social IS NOT NULL THEN pj.razao_social
	END AS Cliente, v.Modelo, v.Placa, CONCAT(cont.DDD_telefone, ' ', cont.Número_telefone) AS 'Número de telefone'
FROM Cliente c
LEFT JOIN Conta_PJ pj ON c.idConta_PJ = pj.idConta_PJ
LEFT JOIN Conta_PF pf ON c.idConta_PF = pf.idConta_PF
LEFT JOIN Contatos cont ON c.idContato = cont.idContato
LEFT JOIN VeículoXClientes vc ON c.idCliente = vc.idCliente
LEFT JOIN Veículo v ON vc.idVeículo = v.idVeículo;

						-- Filtrando a consulta anterior para exibir apenas os clientes que possuem veículo --
SELECT 
    CASE
        WHEN pf.Nome_completo IS NOT NULL THEN pf.Nome_completo
        WHEN pj.razao_social IS NOT NULL THEN pj.razao_social
    END AS Nome_Indivíduo, v.Modelo, v.Placa, CONCAT(cont.DDD_telefone, ' ', cont.Número_telefone) AS 'Número de telefone'
FROM Cliente c
LEFT JOIN Conta_PJ pj ON c.idConta_PJ = pj.idConta_PJ
LEFT JOIN Conta_PF pf ON c.idConta_PF = pf.idConta_PF
LEFT JOIN Contatos cont ON c.idContato = cont.idContato
LEFT JOIN VeículoXClientes vc ON c.idCliente = vc.idCliente
LEFT JOIN Veículo v ON vc.idVeículo = v.idVeículo
WHERE vc.idVeículo IS NOT NULL;

											  -- Registro de compra de peças -- 
SELECT 
	fp.idPeça,   
    p.Nome AS 'Nome da peça',
    pj.nome_fantasia AS'Fornecedor',
    pj.CNPJ AS CNPJ,
    fp.Quantidade as 'Quantidade negociada',
    fp.valor_da_compra as 'Valor da compra'
FROM `Fornecimento_de_peças` fp
LEFT JOIN `Peças` p ON fp.idPeça = p.idPeça
LEFT JOIN Fornecedor f ON fp.idFornecedor = f.idFornecedor
LEFT JOIN Cliente c ON f.idCliente = c.idCliente
LEFT JOIN Conta_PJ pj ON c.idConta_PJ = pj.idConta_PJ
LEFT JOIN Conta_PF pf ON c.idConta_PF = pf.idConta_PF;

-- --------------------------------------------------------------------------------------------------------------------------------------
