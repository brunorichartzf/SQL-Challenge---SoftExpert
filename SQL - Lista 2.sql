--A)O nome e telefone de todos os clientes em que o telefone começa com o dígito 4;

SELECT * FROM CUSTOMER WHERE IDFONE LIKE '4%';

--B)Todas as colunas dos clientes que não possuem telefone cadastrado;

SELECT * FROM CUSTOMER WHERE IDFONE = NULL;

--C)O nome e o telefone dos fornecedores em que o DDD não foi cadastrado;

SELECT NMSUPPLIER, IDFONE FROM SUPPLIER WHERE IDFONE NOT LIKE '(%';

--D)O nome, quantidade em estoque e o preço com desconto de 10% dos
--produtos que tem mais de 2000 unidades em estoque;

SELECT NMPRODUCT, QTSTOCK, VLPRICE - 0.1 * VLPRICE AS VLPRICE FROM PRODUCT WHERE QTSTOCK > 2000;

--E)O nome e o preço dos produtos com preço entre 10 e 20 reais;

SELECT NMPRODUCT, VLPRICE FROM PRODUCT WHERE VLPRICE >= 10 AND VLPRICE <= 20;

--F)O nome do produto, o preço e o preço total do estoque dos produtos com
--preço acima de 50 reais;

SELECT NMPRODUCT, VLPRICE, VLPRICE * QTSTOCK AS TOTALPRICE FROM PRODUCT WHERE VLPRICE > 50;

--G)O nome do produto, o nome do fornecedor e o telefone do fornecedor dos
--produtos com preço acima de 20 reais e que tenham mais de 1500 unidades
--em estoque;

SELECT PRODUCT.NMPRODUCT, SUPPLIER.NMSUPPLIER, SUPPLIER.IDFONE FROM PRODUCT INNER JOIN SUPPLIER ON PRODUCT.VLPRICE > 20 AND PRODUCT.QTSTOCK > 1500 AND PRODUCT.CDSUPPLIER = SUPPLIER.CDSUPPLIER;

--H)O nome do cliente, a data do pedido e o valor total do pedido para pedidos
--feitos entre junho e julho de 2003;

SELECT CUSTOMER.NMCUSTOMER, REQUEST.DTREQUEST, REQUEST.VLTOTAL FROM CUSTOMER INNER JOIN REQUEST ON CUSTOMER.CDCUSTOMER = REQUEST.CDCUSTOMER 
AND REQUEST.DTREQUEST >= '2003-06-01' AND REQUEST.DTREQUEST <= '2003-07-31';

--I)O nome do cliente, o nome do produto, a data do pedido, a quantidade pedida,
--o valor unitário de venda dos produtos e o valor total do produto pedido, cujas
--unidades pedidas por pedido seja maior que 500.

SELECT CUSTOMER.NMCUSTOMER, PRODUCT.NMPRODUCT, REQUEST.DTREQUEST, PRODUCTREQUEST.QTAMOUNT, PRODUCTREQUEST.VLUNITARY, PRODUCTREQUEST.VLUNITARY * PRODUCTREQUEST.QTAMOUNT AS VLTOTAL
FROM CUSTOMER INNER JOIN REQUEST ON CUSTOMER.CDCUSTOMER = REQUEST.CDCUSTOMER
INNER JOIN PRODUCTREQUEST ON REQUEST.CDREQUEST = PRODUCTREQUEST.CDREQUEST
INNER JOIN PRODUCT ON PRODUCT.CDPRODUCT = PRODUCTREQUEST.CDPRODUCT
INNER JOIN (SELECT PRODUCTREQUEST.CDREQUEST, SUM(PRODUCTREQUEST.QTAMOUNT) AS TOTALAMT FROM PRODUCTREQUEST GROUP BY PRODUCTREQUEST.CDREQUEST) P ON P.CDREQUEST = PRODUCTREQUEST.CDREQUEST AND P.TOTALAMT > 500;