# Desafio de Projeto --> Criando Transações, Executando Backup e Recovery de Banco de Dados

SET @@AUTOCOMMIT = 0;
SELECT @@AUTOCOMMIT;
SHOW DATABASES;
USE desafio_dio_sistemaecommerce;

-- CODE 1 --> Executar uma transação de select e update
START TRANSACTION;	#Aumenta salario dos vendedores em 10% (Somente para os que ganham até 3k)

	UPDATE vendedor SET Salary = (Salary * 1.1) WHERE Salary <= 3000;
	SELECT * FROM vendedor;

COMMIT;


-- CODE 2 --> Criar uma Transação dentro de uma Procedure com reversão caso acontreça Erro ou Exceção (Rollback)
DELIMITER \\
CREATE PROCEDURE cancelaPedidosRealizadosNoCartaoDeCredito()
	BEGIN
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
			BEGIN
				SHOW ERRORS LIMIT 1;
				ROLLBACK;
            
            END;
    
		START TRANSACTION;
			UPDATE pedido SET StatusPedido = 'Cancelado' WHERE FormaPagamento = 'Cartão de Crédito';
			
            SELECT
				Id_Pedido AS 'Código do Pedido',
				FormaPagamento AS 'Forma de Pagamento',
				(ValorFrete + ValorProduto) AS 'Valor Total',
				StatusPedido AS 'Status Do Pedido',
				Descricao AS 'Descrição'
            FROM 
				pedido
			WHERE
				FormaPagamento = 'Cartão de Crédito';
                
		COMMIT;
        
    END \\
DELIMITER ;

CALL cancelaPedidosRealizadosNoCartaoDeCredito;
