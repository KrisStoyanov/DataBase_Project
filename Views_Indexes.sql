CREATE VIEW MONTHLY_REPORT AS
SELECT COUNT(DISTINCT ORDERS.ID) 'Number of orders', SUM(PRODUCTS.PRICE) Income, SUM(COALESCE(INGREDIANTS.PRICE, 0) * COALESCE(INGREDIANTS_IN_PRODUCTS.INGREDIANT_AMOUNT, 0)) Cost, MONTH(ORDERS.CREATED_AT) Month, YEAR(ORDERS.CREATED_AT) Year FROM ORDERS
LEFT JOIN PRODUCTS_IN_ORDERS ON PRODUCTS_IN_ORDERS.ORDER_ID = ORDERS.ID
LEFT JOIN PRODUCTS ON PRODUCTS.ID = PRODUCTS_IN_ORDERS.PRODUCT_ID
LEFT JOIN INGREDIANTS_IN_PRODUCTS ON INGREDIANTS_IN_PRODUCTS.PRODUCT_ID = PRODUCTS.ID
LEFT JOIN INGREDIANTS ON INGREDIANTS.ID = INGREDIANTS_IN_PRODUCTS.INGREDIANT_ID
GROUP BY YEAR(ORDERS.CREATED_AT), MONTH(ORDERS.CREATED_AT)

CREATE VIEW EMPLOYEES_VIEW AS
SELECT 
EMPLOYEES.FIRST_NAME,
EMPLOYEES.LAST_NAME,
EMPLOYEES.AGE,
EMPLOYEES.SALARY,
OCCUPATIONS.OCCUPATION_NAME
FROM EMPLOYEES
JOIN OCCUPATIONS on OCCUPATIONS.ID = EMPLOYEES.OCCUPATION_ID

CREATE VIEW COOK_BOOK AS
SELECT prod.NAME PRODUCT_NAME, ing.NAME INGREDIANT_NAME, iip.INGREDIANT_AMOUNT
FROM INGREDIANTS_IN_PRODUCTS iip
JOIN INGREDIANTS ing ON ing.ID = iip.INGREDIANT_ID
JOIN  PRODUCTS prod ON prod.ID = iip.PRODUCT_ID


CREATE INDEX IDX_CREATED_AT
ON ORDERS(CREATED_AT)

CREATE INDEX IDX_FINISHED_AT
ON ORDERS(FINISHED_AT)

