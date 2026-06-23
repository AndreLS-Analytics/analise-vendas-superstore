SELECT 
    SUBSTR("Order Date", -4) AS "Ano",
    SUM("Sales") AS "Faturamento Total"
FROM train 
GROUP BY "Ano"
ORDER BY "Ano" ASC;


-- 4. Análise de Sazonalidade por Mês
SELECT 
    SUBSTR("Order Date", 4, 2) AS "Mes",
    SUM("Sales") AS "Faturamento Total"
FROM train 
GROUP BY "Mes"
ORDER BY "Faturamento Total" DESC;

-- 5. Pedidos com vendas acima da média geral (Subquery)
SELECT 
    "Order ID" AS "ID do Pedido",
    "Customer Name" AS "Cliente",
    "Sales" AS "Valor da Venda"
FROM train
WHERE "Sales" > (SELECT AVG("Sales") FROM train)
ORDER BY "Sales" DESC;