--A)O nome do produto, o nome do fornecedor, o pre�o do produto, o pre�o com
--10% de desconto, o pre�o com 20% de desconto e o pre�o com 30% de
--desconto para produtos cujo valor com 10% de desconto ultrapasse os 15
--reais, isso ordenado por pre�o e produto;

SELECT PRODUCT.NMPRODUCT, SUPPLIER.NMSUPPLIER, PRODUCT.VLPRICE, 
PRODUCT.VLPRICE - PRODUCT.VLPRICE*0.1 AS TEN,
PRODUCT.VLPRICE - PRODUCT.VLPRICE*0.2 AS TWENTYPCT,
PRODUCT.VLPRICE - PRODUCT.VLPRICE*0.3 AS THIRTYPCT
FROM PRODUCT INNER JOIN SUPPLIER ON PRODUCT.VLPRICE - PRODUCT.VLPRICE*0.1 > 15 AND PRODUCT.CDSUPPLIER = SUPPLIER.CDSUPPLIER
ORDER BY PRODUCT.VLPRICE, PRODUCT.NMPRODUCT;

--B)O nome do produto, o nome do fornecedor, o pre�o do produto, o pre�o total
--do produto no estoque e o pre�o total para o dobro do estoque para produtos
--com pre�o total acima de 12000, ordenados por fornecedor e produto;

SELECT PRODUCT.NMPRODUCT, SUPPLIER.NMSUPPLIER, PRODUCT.VLPRICE, PRODUCT.VLPRICE * PRODUCT.QTSTOCK AS TOTALSTOCKPRICE, PRODUCT.VLPRICE * PRODUCT.QTSTOCK *2 AS DOUBLETOTALSTOCKPRICE
FROM PRODUCT INNER JOIN SUPPLIER ON PRODUCT.CDSUPPLIER = SUPPLIER.CDSUPPLIER AND PRODUCT.VLPRICE * PRODUCT.QTSTOCK > 12000
ORDER BY SUPPLIER.NMSUPPLIER, PRODUCT.NMPRODUCT;


--C)Todas as colunas dos clientes que possuem telefone cadastrado e come�am
--com a letra J, ordenado pelo nome do cliente;

SELECT * FROM CUSTOMER WHERE CUSTOMER.IDFONE IS NOT NULL AND CUSTOMER.NMCUSTOMER LIKE 'J%' ORDER BY CUSTOMER.NMCUSTOMER;

--D)O nome do produto, o pre�o e o nome do fornecedor dos produtos que o
--fornecedor tenha no nome os caracteres �ica�, ordenado por fornecedor e
--pre�o;

SELECT PRODUCT.NMPRODUCT, PRODUCT.VLPRICE, SUPPLIER.NMSUPPLIER FROM PRODUCT
INNER JOIN SUPPLIER ON PRODUCT.CDSUPPLIER = SUPPLIER.CDSUPPLIER AND SUPPLIER.NMSUPPLIER LIKE '%ica%' ORDER BY SUPPLIER.NMSUPPLIER, PRODUCT.VLPRICE;

--E)O nome do fornecedor, o fone do fornecedor, o nome do produto, o pre�o e o
--pre�o total do produto no estoque para produtos que comecem com a letra S,
--tendo pre�o acima de 50, ordenado por fornecedor e pre�o;

SELECT SUPPLIER.NMSUPPLIER, SUPPLIER.IDFONE, PRODUCT.NMPRODUCT, PRODUCT.VLPRICE, PRODUCT.VLPRICE * PRODUCT.QTSTOCK AS TOTALSTOCKVALUE
FROM SUPPLIER INNER JOIN PRODUCT ON SUPPLIER.CDSUPPLIER = PRODUCT.CDSUPPLIER AND PRODUCT.NMPRODUCT LIKE 'S%' AND PRODUCT.VLPRICE > 50
ORDER BY SUPPLIER.NMSUPPLIER, PRODUCT.VLPRICE;

--F)O nome do cliente, o nome do produto, a data do pedido, a data de entrega, a
--quantidade pedida, o valor unit�rio de venda dos produtos e o valor total do
--produto pedido, cujas unidades pedidas por pedido sejam menor que 600 e a
--data do pedido seja no m�s de agosto de 2003 e o produto comece com a
--letra M;

SELECT CUSTOMER.NMCUSTOMER, PRODUCT.NMPRODUCT, REQUEST.DTREQUEST, REQUEST.DTDELIVER, PRODUCTREQUEST.QTAMOUNT, PRODUCT.VLPRICE, PRODUCTREQUEST.QTAMOUNT * PRODUCT.VLPRICE AS TOTALPRODUCT
FROM CUSTOMER INNER JOIN REQUEST ON REQUEST.CDCUSTOMER = CUSTOMER.CDCUSTOMER
INNER JOIN PRODUCTREQUEST ON REQUEST.CDREQUEST = PRODUCTREQUEST.CDREQUEST
INNER JOIN PRODUCT ON PRODUCT.CDPRODUCT = PRODUCTREQUEST.CDPRODUCT
INNER JOIN (SELECT PRODUCTREQUEST.CDREQUEST, SUM(PRODUCTREQUEST.QTAMOUNT) AS TOTALAMT FROM PRODUCTREQUEST GROUP BY PRODUCTREQUEST.CDREQUEST) P ON P.CDREQUEST = PRODUCTREQUEST.CDREQUEST 
AND P.TOTALAMT < 600 AND REQUEST.DTREQUEST BETWEEN '2003-08-01' AND '2003-08-31' AND PRODUCT.NMPRODUCT LIKE 'M%';

--G)O nome do cliente, o nome do produto o nome do fornecedor, a data do
--pedido, a data de entrega e o pre�o, somente se o fornecedor for de S�o Paulo
--(011) e o pre�o seja maior que 20 reais.

SELECT CUSTOMER.NMCUSTOMER, PRODUCT.NMPRODUCT, SUPPLIER.NMSUPPLIER, REQUEST.DTREQUEST, REQUEST.DTDELIVER, PRODUCT.VLPRICE
FROM CUSTOMER INNER JOIN REQUEST ON REQUEST.CDCUSTOMER = CUSTOMER.CDCUSTOMER
INNER JOIN PRODUCTREQUEST ON REQUEST.CDREQUEST = PRODUCTREQUEST.CDREQUEST
INNER JOIN PRODUCT ON PRODUCTREQUEST.CDPRODUCT = PRODUCT.CDPRODUCT
INNER JOIN SUPPLIER ON SUPPLIER.CDSUPPLIER = PRODUCT.CDSUPPLIER AND SUPPLIER.IDFONE LIKE '(011)%' AND PRODUCT.VLPRICE > 20;
