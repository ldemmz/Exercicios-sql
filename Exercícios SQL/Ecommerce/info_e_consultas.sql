
-- --------------------------------------------------------------------------------------------------------------------------------------

								-- Inserção de dados nas tabelas para consultas posteriores --

-- --------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO conta_pf (primeiro_nome, abv_meio_nome, sobrenome, CPF) VALUES 
('Leonardo',NULL,'Rodrigues', '12345678999'),
('Alice', 'P.','Soares', '34256927611'),
('Bruno','E.','Oliveira','55522210323');

INSERT INTO conta_pj (CNPJ, razao_social, nome_fantasia, inicio_atividade, status_atividade, tipo_usuario) VALUES
	('12345678000321', 'Ecommerce do Leo', 'Ecommerce do Leo', '2023-05-02','Ativa', NULL),
    ('12345678000123', 'Tech Solutions', 'Tech Soluções', '2020-01-15', 'Ativa', 'Vendedor'),
    ('98765432000110', 'Lisa Modas SS', 'Lisa Modas', '2018-05-20', 'Ativa', 'Fornecedor'),
    ('84247891332000', 'Ana Maria Acessórios','Ana Roupas e Acessórios','2022-12-02', 'Ativa', 'Comprador');

INSERT INTO usuario (idConta_PF, idConta_PJ) VALUES
	(NULL, 1),
    (1, NULL),
    (NULL, 2),
    (2, NULL),
    (NULL, 3),
    (NULL, 4),
    (3, NULL);

INSERT INTO contatos (idUsuario, tipo_contato, DDD, numero_contato, email) VALUES
    (1, 'E-mail', NULL, NULL, 'leonardor99@outkkloo.com'),
    (1,'Celular','064','999381982', NULL),
    (2, 'Celular','041','123456789', NULL),
    (3,'Celular','011','922322322', NULL),
    (4,'E-mail', NULL, NULL, 'alice89@exemplo.com'),
    (5, 'E-mail', NULL, NULL, 'contatolm@exemplolm.com.br'),
    (5, 'Celular','011','214365879', NULL),
    (6, 'E-mail', NULL, NULL,'ana_contato@exemplo.com'),
    (7,'E-mail', NULL, NULL, 'brunexcomefarofa@exemplo.com.br');

INSERT INTO endereços (idUsuario, tipo_residência, país, estado, cidade, endereço, complemento) VALUES
    (1, 'Galpão', 'Brasil', 'São Paulo', 'São Paulo', 'Av. Principal, 123, Centro', 'Próximo a loja do Seu Zé'),
    (2, 'Apartamento', 'Brasil', 'Paraná', 'Curitiba', 'Rua Amoras, N° 201, Bairro Exemplo', NULL),
    (3, 'Loja', 'Brasil', 'São Paulo', 'São Paulo', 'Av. Principal, 123, Centro', NULL),
    (4, 'Casa', 'Brasil', 'Goiás', 'Trindade', 'Rua Ablubluble, Quadra 5, Lote 22, Setor Leste', NULL),
    (5, 'Fábrica', 'Brasil', 'São Paulo', 'São Paulo', 'Av Tal, 323, Centro ', 'Próximo ao posto X'),
    (6, 'Loja', 'Brasil', 'Rio de Janeiro', 'Rio de Janeiro', 'Rua Secundária, N° 789, Bairro Aiaiai', 'Dentro da galeria'),
    (7, 'Apartamento', 'Brasil', 'Minas Gerais', 'Belo Horizonte', 'Rua Peixe-boi,N° 456, Bairro Tenso', 'Edifício Tanajura');

INSERT INTO produtos (nome, tipo, preço, avaliação, descrição, dimensão) VALUES
    ('Geladeira abcd 300L', 'Eletrodomésticos', 2000.00, 4.5, 'Geladeira de duas portas com capacidade de 300L', '60x70x150'),
    ('Ursinho de Pelúcia', 'Brinquedos', 72.50, 4.2, 'Ursinho de pelúcia amarelo feito com algodão X', '20x20x40'),
    ('Camiseta', 'Vestimentas', 63.00, 4.7, 'Camiseta de algodão com estampa moderna', NULL),
    ('Arroz bonitão', 'Alimentos', 7.20,  4.9, 'Pacote de arroz branco de 1kg', NULL);

INSERT INTO pagamentos (idUsuario, tipo_pagamento, numero_cartao, CVC, validade_cartao, cod_PIX, cod_boleto) VALUES
    ('2','Cartão', '1234567890123456', '123', '1225', NULL, NULL),
    ('6','Boleto', NULL, NULL, NULL,  NULL, '123456789012345678'),
    ('3','Pix', NULL, NULL, NULL, '1234567890', NULL),
	('6','Cartão', '8502942890123456', '111', '0926', NULL, NULL),
    ('7','Cartão', '5094304238043832', '109', '0527', NULL, NULL);

INSERT INTO pedidos (idUsuario, idPagamento, valor_pagamento, frete, status_pedido, descrição) VALUES
    (2, 1, 2145.00, 77.00, 'Confirmado', 'Pedido de geladeira e dois ursos de pelúcia.'),
    (6, 2, 63.00, 8.00, 'Confirmado', 'Pedido de camiseta.'),
    (3, 3, 72.50, 12.00, 'Confirmado', '5 geladeiras para Tech Soluções.'),
    (6, 4, 6300.00, 90.00, 'Confirmado', 'Pedido de 100 camisas para entrega até agosto.'),
    (7, 5, 72.00, 6.00, 'Confirmado', 'Pedido de arroz');

INSERT INTO Relação_pedidoXproduto (idPedido, idProduto, quantidade) VALUES
    (1, 1, 1),
    (1, 2, 2),
    (2, 3, 1),
    (3, 1, 5),
    (4, 3, 100),
    (5, 4, 10);

INSERT INTO entregas (idPedido, idEndereço, cod_rastreio, status_entrega) VALUES
    (1, 2, 'RA123456789', 'Entregue'),
    (2, 6, 'RB987654321', 'Entregue'),
    (3, 3, 'RC456789012', 'Entregue'),
    (4, 6, 'RB529230200', 'Em Processamento'),
    (5, 7, 'RA032103129', 'Em trânsito');
    
INSERT INTO estoque (idEndereço, nome_estoque) VALUES 
	('1', 'Galpão do E-commerce');

INSERT INTO verificação_de_estoque (idProduto, idEstoque, quantidade) VALUES
	(1, 1, 12),
    (2, 1, 220),
    (3, 1, 200),
    (4, 1, 300);
    
INSERT INTO produtos_vendedoresxfornecedores (idUsuario, idProduto, quantidade, valor_unitario, valor_total_pago, status_atual, comentário) VALUES
	(5, 3, 130, 32.00, 4160.00, 'Produto entregue', 'Frete gratuito devido ao volume de compra');
    
-- --------------------------------------------------------------------------------------------------------------------------------------

													 -- Consultas --

-- --------------------------------------------------------------------------------------------------------------------------------------

											  -- Pesquisando produtos --
                                                
SELECT * FROM produtos;


							 -- Filtrando produtos com nota de avaliação superior a 4.2 --
            
SELECT * FROM produtos HAVING avaliação > 4.2;

					        -- Pesquisando pelo produto com maior avaliação (Nome e nota) --
                                                
SELECT nome as 'Produto' , avaliação as Avaliação FROM produtos ORDER BY avaliação DESC LIMIT 1;

								 -- Descobrindo o preço do Ursinho de Pelúcia --
                                    
SELECT preço from produtos WHERE nome='Ursinho de Pelúcia';

						-- Buscando pelo usuário que realizou a maior quantidade de pedidos --
                             
SELECT u.idUsuario as 'ID do usuário',
       CASE
         WHEN pj.CNPJ IS NOT NULL THEN pj.nome_fantasia
         WHEN pf.CPF IS NOT NULL THEN CONCAT_WS(' ', pf.primeiro_nome, pf.abv_meio_nome, pf.sobrenome)
       END as Comprador,
       COUNT(p.idPedido) as 'Pedidos realizados'
FROM usuario u
LEFT JOIN conta_pf pf ON u.idConta_PF = pf.idConta_PF
LEFT JOIN conta_pj pj ON u.idConta_PJ = pj.idConta_PJ
LEFT JOIN pedidos p ON u.idUsuario = p.idUsuario
GROUP BY u.idUsuario, Comprador
ORDER BY `Pedidos realizados` DESC
LIMIT 1;

				-- Gerando tabela com informações essenciais relacionadas a entraga dos pedidos --

SELECT 
    p.idPedido as 'Identificação do pedido', 
    e.cod_rastreio as 'Código de rastreio', 
    (SELECT 
        CASE
			WHEN pj.CNPJ IS NOT NULL THEN pj.nome_fantasia
			WHEN pf.CPF IS NOT NULL THEN CONCAT_WS(' ', pf.primeiro_nome, pf.abv_meio_nome, pf.sobrenome)
			END as Comprador
        FROM usuario u
        LEFT JOIN conta_pf pf ON u.idConta_PF = pf.idConta_PF
        LEFT JOIN conta_pj pj ON u.idConta_PJ = pj.idConta_PJ
        WHERE u.idUsuario = p.idUsuario
    ) AS 'Solicitante',
    e.status_entrega as 'Status da entrega', 
    CONCAT(en.endereço, ' - Estado: ', en.estado) as 'Endereço de recebimento', 
    en.complemento as 'Complemento do endereço', 
    CASE 
        WHEN c.tipo_contato = 'Celular' THEN CONCAT(c.DDD, ' ', c.numero_contato) 
        WHEN c.tipo_contato = 'E-mail' THEN c.email 
        ELSE '' 
    END AS 'Contato'
FROM entregas e
JOIN pedidos p ON e.idPedido = p.idPedido
JOIN endereços en ON e.idEndereço = en.idEndereço
JOIN contatos c ON p.idUsuario = c.idUsuario;

			  	-- Pesquisa para saber o gasto de cada solicitante em seus pedidos --
                
SELECT p.idPedido as 'Identificação do pedido', 
       CASE
           WHEN u.idConta_PF IS NOT NULL THEN CONCAT_WS(' ', pf.primeiro_nome, pf.abv_meio_nome, pf.sobrenome)
           ELSE pj.nome_fantasia
       END AS 'Solicitante',
       CASE
           WHEN u.idConta_PF IS NOT NULL THEN pf.CPF
           ELSE pj.CNPJ
       END AS 'CPF ou CNPJ', p.valor_pagamento as 'Valor gasto (R$)', p.frete as 'Frete (R$)'
FROM pedidos p
JOIN usuario u ON p.idUsuario = u.idUsuario
LEFT JOIN conta_pf pf ON u.idConta_PF = pf.idConta_PF
LEFT JOIN conta_pj pj ON u.idConta_PJ = pj.idConta_PJ;

							-- Compra de produtos com fornecedores --
 
 SELECT pj.nome_fantasia as Fornecedor, pj.CNPJ, p.nome AS 'Produto Oferecido',p.idProduto as 'Identificação do Produto', pvf.quantidade as 'QTD', pvf.valor_total_pago as 'Valor da compra (R$)'
FROM usuario u
JOIN conta_pj pj ON u.idConta_PJ = pj.idConta_PJ
JOIN produtos_vendedoresXfornecedores pvf ON u.idUsuario = pvf.idUsuario
JOIN produtos p ON pvf.idProduto = p.idProduto
WHERE pj.tipo_usuario = 'Fornecedor';