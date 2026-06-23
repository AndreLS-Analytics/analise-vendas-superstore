# analise-vendas-superstore
Markdown
# Projeto Prático: Inteligência de Mercado e Análise de Performance Comercial com SQL e SQLite

**Autor:** André Luis da Silva Santos
**Perfil de Portfólio:** AndréLS_Analytics
**Tecnologias Utilizadas:** SQL, SQLite, DBeaver

Este projeto apresenta a documentação técnica e o relatório executivo da análise de dados comerciais baseada no dataset *Superstore Sales*. O objetivo principal foi extrair indicadores-chave de desempenho (KPIs) vitais para subsidiar tomadas de decisão estratégicas nas áreas de marketing, vendas e logística regional.

## 1. Introdução e Contextualização do Negócio
No cenário competitivo atual, transformar dados brutos em inteligência de mercado é um diferencial crítico. A base de dados utilizada registra transações de vendas de uma grande rede de varejo, contendo dados geográficos, temporais, segmentação de clientes e detalhamento de produtos.

Utilizando o ecossistema leve e robusto do **SQLite** por meio do gerenciador **DBeaver**, este projeto simula a atuação de um analista de inteligência de mercado respondendo a demandas reais da diretoria executiva.

## 2. Estrutura do Banco de Dados (Dicionário de Dados)
A tabela principal, denominada `train`, foi estruturada com tipos de dados otimizados para garantir consultas rápidas e precisas:

| Nome da Coluna | Tipo de Dado | Descrição |
| :--- | :--- | :--- |
| **Row ID** | INTEGER | Identificador único sequencial da linha. |
| **Order ID** | VARCHAR | Código único de identificação do pedido. |
| **Order Date** | NVARCHAR | Data em que o pedido foi realizado (DD/MM/YYYY). |
| **Customer Name** | VARCHAR | Nome do cliente responsável pela compra. |
| **State** | VARCHAR | Estado de destino da entrega do produto. |
| **Category** | VARCHAR | Categoria macro do produto vendido. |
| **Sales** | REAL | Valor monetário da venda (faturamento bruto). |

## 3. Consultas Estratégicas e Métricas de Desempenho (KPIs)

### 3.1 Visão Geral e Indicadores do Estado de Nova York
Para validar as funções de agregação e consolidar os primeiros KPIs executivos ("Cai-Pi-Ais"), isolamos as transações destinadas ao estado de Nova York para compreender o volume operacional e o ticket médio regional.

```sql
SELECT 
    SUM("Sales") AS "Faturamento Total",
    AVG("Sales") AS "Venda Média",
    COUNT(*) AS "Total de Pedidos"
FROM train 
WHERE "State" = 'New York';
Resultados Obtidos:

Faturamento Total: $306.361,14

Venda Média (Ticket Médio): $279,27

Total de Pedidos: 1.097

3.2 Ranking de Faturamento por Estado (Tomada de Decisão Geográfica)
Expandindo o escopo regional para uma visão macro de mercado, foi aplicado o agrupamento multirregional com filtros avançados para identificar os mercados que ultrapassaram a meta de corte de $100.000,00 em faturamento histórico.

SQL
SELECT 
    "State" AS "Estado",
    SUM("Sales") AS "Faturamento Total",
    COUNT(*) AS "Total de Pedidos"
FROM train 
GROUP BY "State"
HAVING SUM("Sales") > 100000
ORDER BY "Faturamento Total" DESC;
Insight de Negócio: A consulta demonstrou que apenas 5 estados atingiram a meta estipulada. A liderança absoluta pertence ao estado da Califórnia, acumulando um faturamento de $446.306,46 distribuído em 1.946 pedidos, consolidando-se como a região de maior relevância para alocação de investimentos e campanhas de marketing agressivas.

3.3 Análise de Sazonalidade (Evolução Temporal)
A análise temporal utilizou manipulações de strings para extrair as janelas de tempo adequadas, identificando os anos de maior crescimento e os meses de pico de vendas para fins de planejamento logístico e controle de estoques.

SQL
-- Sazonalidade por Mês (Identificação de Picos Operacionais)
SELECT 
    SUBSTR("Order Date", 4, 2) AS "Mes",
    SUM("Sales") AS "Faturamento Total"
FROM train 
GROUP BY "Mes"
ORDER BY "Faturamento Total" DESC;
Insight de Negócio: O ano de maior desempenho histórico foi 2018. Na análise mensal tática, o mês 11 (Novembro) despontou no topo isolado com um faturamento acumulado de $350.161,71. Este padrão sugere um forte impacto de eventos sazonais de fim de ano (como a Black Friday) na receita da empresa.

3.4 Identificação de Clientes de Alto Valor (Subqueries)
Para apoiar estratégias de relacionamento e fidelização corporativa (B2B), implementou-se uma subconsulta que isola as transações individuais que ficaram estritamente acima da média histórica de vendas de toda a organização.

SQL
SELECT 
    "Order ID" AS "ID do Pedido",
    "Customer Name" AS "Cliente",
    "Sales" AS "Valor da Venda"
FROM train
WHERE "Sales" > (SELECT AVG("Sales") FROM train)
ORDER BY "Sales" DESC;
Insight de Negócio: Esta consulta localiza transações de grande impacto comercial. O cliente de maior destaque individual mapeado na base foi Sean Miller, registrando uma única venda no valor de $22.638,48. Clientes com esse perfil representam contas estratégicas para programs de retenção.

4. Conclusão
O projeto provou a viabilidade prática do uso de SQL para a extração veloz de inteligência comercial. O código gerado atende a padrões rígidos de mercado, demonstrando domínio em agrupamentos, filtros condicionais avançados e estruturação de dados.
