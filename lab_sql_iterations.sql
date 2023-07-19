-- Leonardo Olmos Saucedo | SQL Iterations

USE sakila;

-- 1. Write a query to find what is the total business done by each store.
SELECT SUM(P.AMOUNT) AS TOTAL_BUSINESS, ST.STORE_ID
FROM PAYMENT P
JOIN STAFF S 
ON S.STAFF_ID = P.STAFF_ID
JOIN STORE ST 
ON ST.STORE_ID = S.STORE_ID
GROUP BY ST.STORE_ID;

-- 2. Convert the previous query into a stored procedure.
DROP PROCEDURE IF EXISTS get_total_bussiness_by_store;

DELIMITER $$

CREATE PROCEDURE get_total_bussiness_by_store()
BEGIN
	SELECT SUM(P.AMOUNT) AS TOTAL_BUSINESS, ST.STORE_ID
	FROM PAYMENT P
	JOIN STAFF S 
	ON S.STAFF_ID = P.STAFF_ID
	JOIN STORE ST 
	ON ST.STORE_ID = S.STORE_ID
	GROUP BY ST.STORE_ID;
END $$

DELIMITER ;

CALL get_total_bussiness_by_store();

/*
32661.45	1
33085.15	2
*/

-- 3. Convert the previous query into a stored procedure that takes the input for store_id and displays the total sales for that store.
DROP PROCEDURE IF EXISTS get_total_bussiness_by_store;

DELIMITER $$

CREATE PROCEDURE get_total_bussiness_by_store(IN STORE_ID INT)
BEGIN
	SELECT SUM(P.AMOUNT) AS TOTAL_BUSINESS, ST.STORE_ID
	FROM PAYMENT P
	JOIN STAFF S 
	ON S.STAFF_ID = P.STAFF_ID
	JOIN STORE ST 
	ON ST.STORE_ID = S.STORE_ID
    WHERE ST.STORE_ID = STORE_ID
	GROUP BY ST.STORE_ID;
END $$

DELIMITER ;

CALL get_total_bussiness_by_store(2);

/* 4. Update the previous query. Declare a variable total_sales_value of float type, that will store the returned result (of the total sales amount for the store). 
Call the stored procedure and print the results. */

DROP PROCEDURE IF EXISTS get_total_bussiness_by_store;

DELIMITER $$

CREATE PROCEDURE get_total_bussiness_by_store(IN STORE_ID INT)
BEGIN
	DECLARE total_sales_value FLOAT DEFAULT 0.0;
    
	SELECT SUM(P.AMOUNT) INTO total_sales_value
	FROM PAYMENT P
	JOIN STAFF S 
	ON S.STAFF_ID = P.STAFF_ID
	JOIN STORE ST 
	ON ST.STORE_ID = S.STORE_ID
    WHERE ST.STORE_ID = STORE_ID;
    
    SELECT total_sales_value;
END $$

DELIMITER ;

CALL get_total_bussiness_by_store(1);

/* 5. In the previous query, add another variable flag. 
If the total sales value for the store is over 30.000, then label it as green_flag, otherwise label is as red_flag. 
Update the stored procedure that takes an input as the store_id and returns total sales value for that store and flag value.*/

DROP PROCEDURE IF EXISTS get_total_bussiness_by_store;

DELIMITER $$

CREATE PROCEDURE get_total_bussiness_by_store(IN STORE_ID INT)
BEGIN
	DECLARE total_sales_value FLOAT DEFAULT 0.0;
    DECLARE flag VARCHAR(10) DEFAULT "";
    
	SELECT SUM(P.AMOUNT) INTO total_sales_value
	FROM PAYMENT P
	JOIN STAFF S 
	ON S.STAFF_ID = P.STAFF_ID
	JOIN STORE ST 
	ON ST.STORE_ID = S.STORE_ID
    WHERE ST.STORE_ID = STORE_ID;
    
    SELECT total_sales_value;
    
    IF total_sales_value > 30000
		THEN SET flag = "Green";
	ELSE 
		SET flag = "Red";
	END IF;
    
    SELECT total_sales_value, flag;
END $$

DELIMITER ;

CALL get_total_bussiness_by_store(2);