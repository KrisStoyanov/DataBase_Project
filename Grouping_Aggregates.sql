USE RESTAURANT;
--1
SELECT 
	p.ID,
	p.NAME AS 'Product',
	COUNT(INGREDIANT_AMOUNT) AS 'Number of different types of ingridients for this product'
FROM INGREDIANTS_IN_PRODUCTS inp
JOIN PRODUCTS p ON inp.PRODUCT_ID = p.ID
GROUP BY ID, p.NAME 
--2
SELECT 
	OCCUPATION_ID,
	o.OCCUPATION_NAME AS 'Occupation name',
	COUNT(e.OCCUPATION_ID) AS 'Number of people at this position',
	SUM(e.SALARY) AS 'Total salary for this position',
	AVG(e.SALARY) AS 'Average salary for this position' 
FROM EMPLOYEES e 
JOIN OCCUPATIONS o ON e.OCCUPATION_ID = o.ID
GROUP BY OCCUPATION_ID, o.OCCUPATION_NAME

--3
--MONSTROSITY
SELECT 
	o.EMPLOYEE_ID,
    FIRST_NAME AS 'First name',
    LAST_NAME AS 'Last name',
    count(o.EMPLOYEE_ID) AS 'Number of orders done',
    firstOrder.CREATED_AT AS 'First order taken',
    firstOrder.FINISHED_AT AS 'First order finished',
    lastOrder.CREATED_AT AS 'Last order taken',
    lastOrder.FINISHED_AT AS 'Last order finished'
FROM ORDERS o
JOIN EMPLOYEES e ON o.EMPLOYEE_ID = e.ID
JOIN (	SELECT
			o.EMPLOYEE_ID,
			employeeMaxOrder.CREATED_AT,
			FINISHED_AT 
		FROM ORDERS o
		JOIN (	SELECT 
					EMPLOYEE_ID,
					MAX(CREATED_AT) CREATED_AT
				FROM ORDERS 
				GROUP BY EMPLOYEE_ID) employeeMaxOrder ON 
		o.EMPLOYEE_ID = employeeMaxOrder.EMPLOYEE_ID AND o.CREATED_AT = employeeMaxOrder.CREATED_AT) lastOrder 
ON lastOrder.EMPLOYEE_ID = o.EMPLOYEE_ID
 
JOIN (	SELECT 
			o.EMPLOYEE_ID,		
			employeeMaxOrder.CREATED_AT,
			FINISHED_AT 
		FROM ORDERS o
		JOIN (	SELECT 
					EMPLOYEE_ID,
					MIN(CREATED_AT) CREATED_AT
				FROM ORDERS 
				GROUP BY EMPLOYEE_ID) employeeMaxOrder ON 
		o.EMPLOYEE_ID = employeeMaxOrder.EMPLOYEE_ID AND o.CREATED_AT = employeeMaxOrder.CREATED_AT) firstOrder
ON firstOrder.EMPLOYEE_ID = o.EMPLOYEE_ID

GROUP BY o.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME, firstOrder.CREATED_AT, firstOrder.FINISHED_AT, lastOrder.CREATED_AT, lastOrder.FINISHED_AT