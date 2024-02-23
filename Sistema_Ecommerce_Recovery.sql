-- MySQL dump 10.13  Distrib 8.2.0, for Win64 (x86_64)
--
-- Host: localhost    Database: desafio_dio_sistemaecommerce
-- ------------------------------------------------------
-- Server version	8.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `desafio_dio_sistemaecommerce`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `desafio_dio_sistemaecommerce` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `desafio_dio_sistemaecommerce`;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `Id_Cliente` int NOT NULL AUTO_INCREMENT,
  `Identificacao` varchar(45) DEFAULT NULL,
  `CPF` char(11) DEFAULT NULL,
  `CNPJ` char(14) DEFAULT NULL,
  `Logradouro` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Id_Cliente`),
  UNIQUE KEY `Logradouro` (`Logradouro`),
  KEY `fk_cliente_PessoaFisica` (`CPF`),
  KEY `fk_cliente_PessoaJuridica` (`CNPJ`),
  CONSTRAINT `fk_cliente_PessoaFisica` FOREIGN KEY (`CPF`) REFERENCES `pessoa_fisica` (`CPF`) ON DELETE CASCADE,
  CONSTRAINT `fk_cliente_PessoaJuridica` FOREIGN KEY (`CNPJ`) REFERENCES `pessoa_juridica` (`CNPJ`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Cliente que compra em atacado','12345678910',NULL,'Avenida Palacio'),(2,'Cliente Que Faz Grandes Pedidos','10987654321',NULL,'Avenida Brigadeiro'),(3,'Cliente Que Compra No Varejo','11122233344',NULL,'Rua Jardins Floridos'),(5,'Cliente Master',NULL,'8005648721325','Rua 7 de Abril'),(6,'Cliente Premium Plus',NULL,'8004242567492','Rua 5 de Fevereiro');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tg_tabelaAuxiliar_remocaoDeCliente` AFTER DELETE ON `cliente` FOR EACH ROW begin    
		insert into ClientesRemovidos(Identificacao, CPF, CNPJ) values (old.Identificacao, old.CPF, old.CNPJ);
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `clientesremovidos`
--

DROP TABLE IF EXISTS `clientesremovidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientesremovidos` (
  `NumeroRemocao` int NOT NULL AUTO_INCREMENT,
  `Identificacao` varchar(45) DEFAULT NULL,
  `CPF` char(11) DEFAULT NULL,
  `CNPJ` char(14) DEFAULT NULL,
  PRIMARY KEY (`NumeroRemocao`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientesremovidos`
--

LOCK TABLES `clientesremovidos` WRITE;
/*!40000 ALTER TABLE `clientesremovidos` DISABLE KEYS */;
INSERT INTO `clientesremovidos` VALUES (1,'Cliente Premium',NULL,'8001234567890');
/*!40000 ALTER TABLE `clientesremovidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disponibiliza_produto`
--

DROP TABLE IF EXISTS `disponibiliza_produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disponibiliza_produto` (
  `Id_Fornecedor` int NOT NULL,
  `Id_Produto` int NOT NULL,
  PRIMARY KEY (`Id_Produto`,`Id_Fornecedor`),
  KEY `fk_dispProduto_fornecedor` (`Id_Fornecedor`),
  CONSTRAINT `fk_dispProduto_fornecedor` FOREIGN KEY (`Id_Fornecedor`) REFERENCES `fornecedor` (`Id_Fornecedor`),
  CONSTRAINT `fk_dispProduto_Produto` FOREIGN KEY (`Id_Produto`) REFERENCES `produto` (`Id_Produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disponibiliza_produto`
--

LOCK TABLES `disponibiliza_produto` WRITE;
/*!40000 ALTER TABLE `disponibiliza_produto` DISABLE KEYS */;
INSERT INTO `disponibiliza_produto` VALUES (1,5),(2,3),(3,1),(4,2),(5,4);
/*!40000 ALTER TABLE `disponibiliza_produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrega`
--

DROP TABLE IF EXISTS `entrega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entrega` (
  `Logradouro` varchar(50) NOT NULL,
  `Id_Produto` int NOT NULL,
  `Rastreio` char(15) DEFAULT NULL,
  `ValorFrete` double DEFAULT NULL,
  PRIMARY KEY (`Logradouro`,`Id_Produto`),
  UNIQUE KEY `Rastreio` (`Rastreio`),
  UNIQUE KEY `ValorFrete` (`ValorFrete`),
  KEY `fk_Entrega_Id_Produto` (`Id_Produto`),
  CONSTRAINT `fk_Entrega_Id_Cliente` FOREIGN KEY (`Logradouro`) REFERENCES `cliente` (`Logradouro`) ON DELETE CASCADE,
  CONSTRAINT `fk_Entrega_Id_Produto` FOREIGN KEY (`Id_Produto`) REFERENCES `produto` (`Id_Produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrega`
--

LOCK TABLES `entrega` WRITE;
/*!40000 ALTER TABLE `entrega` DISABLE KEYS */;
INSERT INTO `entrega` VALUES ('Avenida Brigadeiro',2,'DEF456',10.5),('Rua 5 de Fevereiro',5,'MNO654',12.99),('Rua 7 de Abril',3,'GHI789',8.75),('Rua Jardins Floridos',1,'ABC123',15.99);
/*!40000 ALTER TABLE `entrega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estoque`
--

DROP TABLE IF EXISTS `estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estoque` (
  `Id_Estoque` int NOT NULL AUTO_INCREMENT,
  `Logradouro` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Id_Estoque`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estoque`
--

LOCK TABLES `estoque` WRITE;
/*!40000 ALTER TABLE `estoque` DISABLE KEYS */;
INSERT INTO `estoque` VALUES (1,'Rua A, 123'),(2,'Avenida B, 456'),(3,'Travessa C, 789'),(4,'Rua D, 321'),(5,'Avenida E, 654');
/*!40000 ALTER TABLE `estoque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornecedor`
--

DROP TABLE IF EXISTS `fornecedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fornecedor` (
  `Id_Fornecedor` int NOT NULL AUTO_INCREMENT,
  `RazaoSocial` varchar(45) DEFAULT NULL,
  `CNPJ` char(14) DEFAULT NULL,
  PRIMARY KEY (`Id_Fornecedor`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornecedor`
--

LOCK TABLES `fornecedor` WRITE;
/*!40000 ALTER TABLE `fornecedor` DISABLE KEYS */;
INSERT INTO `fornecedor` VALUES (1,'Fornecedor A','99945678901234'),(2,'Fornecedor B','99989012345678'),(3,'Fornecedor C','99923456789012'),(4,'Fornecedor D','99967890123456'),(5,'Fornecedor E','99901234567890');
/*!40000 ALTER TABLE `fornecedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagamento`
--

DROP TABLE IF EXISTS `pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagamento` (
  `NumeroTransacao` int NOT NULL AUTO_INCREMENT,
  `FormaPagamento` varchar(20) NOT NULL,
  `Id_Cliente` int NOT NULL,
  `Parcelas` int DEFAULT NULL,
  `Desconto` double DEFAULT NULL,
  PRIMARY KEY (`NumeroTransacao`),
  KEY `fk_Pag_id_Cliente` (`Id_Cliente`),
  CONSTRAINT `fk_Pag_id_Cliente` FOREIGN KEY (`Id_Cliente`) REFERENCES `cliente` (`Id_Cliente`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagamento`
--

LOCK TABLES `pagamento` WRITE;
/*!40000 ALTER TABLE `pagamento` DISABLE KEYS */;
INSERT INTO `pagamento` VALUES (1,'Cartão de Crédito',1,3,5),(2,'Boleto Bancário',2,1,NULL),(3,'Cartão de Crédito',3,5,NULL),(5,'Pix',5,NULL,7);
/*!40000 ALTER TABLE `pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `Id_Pedido` int NOT NULL AUTO_INCREMENT,
  `Id_Cliente` int DEFAULT NULL,
  `FormaPagamento` varchar(20) NOT NULL,
  `Rastreio` char(15) DEFAULT NULL,
  `ValorFrete` double DEFAULT NULL,
  `ValorProduto` decimal(10,0) DEFAULT NULL,
  `CodigoDeRastreio` char(15) DEFAULT NULL,
  `StatusPedido` varchar(10) DEFAULT NULL,
  `Descricao` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`Id_Pedido`),
  KEY `fk_valorFrete` (`ValorFrete`),
  KEY `fk_valorProduto` (`ValorProduto`),
  KEY `fk_CodRastreio` (`Rastreio`),
  KEY `fk_Pedido_Id_Cliente` (`Id_Cliente`),
  CONSTRAINT `fk_CodRastreio` FOREIGN KEY (`Rastreio`) REFERENCES `entrega` (`Rastreio`),
  CONSTRAINT `fk_Pedido_Id_Cliente` FOREIGN KEY (`Id_Cliente`) REFERENCES `cliente` (`Id_Cliente`) ON DELETE CASCADE,
  CONSTRAINT `fk_valorFrete` FOREIGN KEY (`ValorFrete`) REFERENCES `entrega` (`ValorFrete`),
  CONSTRAINT `fk_valorProduto` FOREIGN KEY (`ValorProduto`) REFERENCES `produto` (`Valor`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,1,'Cartão de Crédito',NULL,15.99,800,'ABC123','Cancelado','Pedido de smartphone'),(2,2,'Boleto Bancário',NULL,10.5,30,'DEF456','Concluído','Pedido de camiseta'),(3,3,'Cartão de Crédito',NULL,8.75,16,'GHI789','Cancelado','Pedido de romance'),(5,5,'Pix',NULL,12.99,50,'MNO654','Enviado','Pedido de óculos de sol');
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pessoa_fisica`
--

DROP TABLE IF EXISTS `pessoa_fisica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pessoa_fisica` (
  `CPF` char(11) NOT NULL,
  `PrimeiroNome` varchar(10) NOT NULL,
  `NomeDoMeio` varchar(20) NOT NULL,
  `UltimoNome` varchar(10) NOT NULL,
  `Idade` int NOT NULL,
  `Logradouro` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`CPF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa_fisica`
--

LOCK TABLES `pessoa_fisica` WRITE;
/*!40000 ALTER TABLE `pessoa_fisica` DISABLE KEYS */;
INSERT INTO `pessoa_fisica` VALUES ('10987654321','Robert','J','Morgan',22,'Avenida Brigadeiro'),('11122233344','Alissa','G','Junior',22,'Rua Jardins Floridos'),('12345678910','Peter','B','Parker',22,'Avenida Palacio'),('15467892345','Ana','Y','Maria',22,'Jd Das Rosas'),('19879871802','Carina','P','Santos',22,'Avenida Qualquer');
/*!40000 ALTER TABLE `pessoa_fisica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pessoa_juridica`
--

DROP TABLE IF EXISTS `pessoa_juridica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pessoa_juridica` (
  `CNPJ` char(14) NOT NULL,
  `Nome` varchar(30) NOT NULL,
  `Logradouro` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`CNPJ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa_juridica`
--

LOCK TABLES `pessoa_juridica` WRITE;
/*!40000 ALTER TABLE `pessoa_juridica` DISABLE KEYS */;
INSERT INTO `pessoa_juridica` VALUES ('8001234567890','Empresa Ficticia 2','Rua 25 de Março'),('8004242567492','NomeFicticios.com','Rua 5 de Fevereiro'),('8005648721325','5° Empresa Ficticia','Rua 7 de Abril'),('8007779995544','EmpregaBem','Rua 43 de Outubro'),('8007897897891','Empresa 1','Rua 1 de Janeiro');
/*!40000 ALTER TABLE `pessoa_juridica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto` (
  `Id_Produto` int NOT NULL AUTO_INCREMENT,
  `Id_Estoque` int DEFAULT NULL,
  `Categoria` varchar(45) DEFAULT NULL,
  `Descricao` varchar(45) DEFAULT NULL,
  `Valor` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`Id_Produto`),
  UNIQUE KEY `Valor` (`Valor`),
  KEY `fk_prod_estoque` (`Id_Estoque`),
  CONSTRAINT `fk_prod_estoque` FOREIGN KEY (`Id_Estoque`) REFERENCES `estoque` (`Id_Estoque`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` VALUES (1,1,'Eletrônicos','Smartphone',800),(2,2,'Roupas','Camiseta',30),(3,3,'Livros','Romance',16),(4,4,'Eletrônicos','Notebook',1300),(5,5,'Acessórios','Óculos de Sol',50);
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos_por_vendedor`
--

DROP TABLE IF EXISTS `produtos_por_vendedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos_por_vendedor` (
  `Id_Produto` int NOT NULL,
  `Id_VendedorTerceirizado` int NOT NULL,
  PRIMARY KEY (`Id_Produto`,`Id_VendedorTerceirizado`),
  KEY `fk_Prod_por_vendedor_Vendedor` (`Id_VendedorTerceirizado`),
  CONSTRAINT `fk_Prod_por_vendedor_IdProd` FOREIGN KEY (`Id_Produto`) REFERENCES `produto` (`Id_Produto`),
  CONSTRAINT `fk_Prod_por_vendedor_Vendedor` FOREIGN KEY (`Id_VendedorTerceirizado`) REFERENCES `vendedor` (`Id_VendedorTerceirizado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos_por_vendedor`
--

LOCK TABLES `produtos_por_vendedor` WRITE;
/*!40000 ALTER TABLE `produtos_por_vendedor` DISABLE KEYS */;
INSERT INTO `produtos_por_vendedor` VALUES (5,1),(4,2),(2,3),(1,4),(3,5);
/*!40000 ALTER TABLE `produtos_por_vendedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quantidade_em_estoque`
--

DROP TABLE IF EXISTS `quantidade_em_estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quantidade_em_estoque` (
  `Id_Produto` int NOT NULL,
  `Id_Estoque` int NOT NULL,
  `Quantidade` int DEFAULT NULL,
  PRIMARY KEY (`Id_Produto`,`Id_Estoque`),
  KEY `fk_QtdEstoque_idEstoq` (`Id_Estoque`),
  CONSTRAINT `fk_QtdEstoque_idEstoq` FOREIGN KEY (`Id_Estoque`) REFERENCES `estoque` (`Id_Estoque`),
  CONSTRAINT `fk_QtdEstoque_idProd` FOREIGN KEY (`Id_Produto`) REFERENCES `produto` (`Id_Produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quantidade_em_estoque`
--

LOCK TABLES `quantidade_em_estoque` WRITE;
/*!40000 ALTER TABLE `quantidade_em_estoque` DISABLE KEYS */;
INSERT INTO `quantidade_em_estoque` VALUES (1,1,100),(2,2,50),(3,3,75),(4,4,30),(5,5,40);
/*!40000 ALTER TABLE `quantidade_em_estoque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendedor`
--

DROP TABLE IF EXISTS `vendedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendedor` (
  `Id_VendedorTerceirizado` int NOT NULL AUTO_INCREMENT,
  `CNPJ` char(14) NOT NULL,
  `RazaoSocial` varchar(45) DEFAULT NULL,
  `Logradouro` varchar(45) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT '3000.00',
  PRIMARY KEY (`Id_VendedorTerceirizado`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendedor`
--

LOCK TABLES `vendedor` WRITE;
/*!40000 ALTER TABLE `vendedor` DISABLE KEYS */;
INSERT INTO `vendedor` VALUES (1,'12345678901234','Vendedor A','Rua X, 789',3600.00),(2,'56789012345678','Vendedor B','Avenida Y, 456',3600.00),(3,'90123456789012','Vendedor C','Travessa Z, 123',3600.00),(4,'34567890123456','Vendedor D','Rua W, 987',3600.00),(5,'78901234567890','Vendedor E','Avenida V, 654',3600.00);
/*!40000 ALTER TABLE `vendedor` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tg_AumentoSalario` BEFORE UPDATE ON `vendedor` FOR EACH ROW begin
	set new.Salary = new.Salary * 1.20;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-23 15:50:10
