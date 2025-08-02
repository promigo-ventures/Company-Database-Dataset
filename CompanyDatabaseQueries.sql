SELECT COUNT(emp_id) AS "total employees"
FROM employee; 

SELECT COUNT(super_id)
FROM employee;

SELECT count(emp_id)
FROM employee
WHERE sex = "F" AND birth_day > "1970-01-01";

SELECT AVG(salary)
FROM employee
WHERE sex = "F" AND birth_day > "1970-01-01";

SELECT AVG(salary)
FROM employee
WHERE sex = "M";

SELECT SUM(salary)
FROM employee
WHERE sex = "M";

SELECT SUM(salary)
FROM employee;

SELECT COUNT(sex), sex
FROM employee
GROUP BY sex;

SELECT SUM(total_sales), client_id 
FROM works_with
GROUP BY client_id;


SELECT *
FROM client
WHERE client_name LIKE "%LLC%";

SELECT *
FROM branch_supplier
WHERE supplier_name LIKE "%Labels%";

SELECT *
FROM employee
WHERE birth_day LIKE "____-10%";

SELECT *
FROM client
WHERE client_name LIKE "%school%";


SELECT first_name
FROM employee
UNION
SELECT branch_name
FROM branch
UNION
SELECT client_name
FROM client;

SELECT client_name, c.branch_id
FROM client c
UNION
SELECT supplier_name, bs.branch_id
FROM branch_supplier bs;

SELECT salary
FROM employee
UNION
SELECT total_sales
FROM works_with;

INSERT INTO branch 
VALUES(4, 'Buffalo', NULL, NULL);

SELECT e.emp_id, e.first_name AS manager, b.branch_name
FROM employee e
JOIN branch b
ON e.emp_id = b.mgr_id;

SELECT e.emp_id, e.first_name AS manager, b.branch_name
FROM employee e
LEFT JOIN branch b
ON e.emp_id = b.mgr_id;

SELECT e.emp_id, e.first_name AS manager, b.branch_name
FROM employee e
RIGHT JOIN branch b
ON e.emp_id = b.mgr_id;

SELECT e.first_name, e.last_name
FROM employee e
WHERE e.emp_id IN (
	SELECT w.emp_id
FROM works_with w
WHERE w.total_sales > 30000
);

SELECT c.client_name
FROM client c
WHERE c.branch_id = (
SELECT b.branch_id
FROM branch b
WHERE b.mgr_id = 102
LIMIT 1
);

   DELIMITER $$
   CREATE
   TRIGGER insert_trigger BEFORE INSERT 
	ON employee
	FOR EACH ROW BEGIN
	INSERT INTO trigger_status VALUES("Added new employee");
	END$$
	DELIMITER ;

CREATE TABLE trigger_status(
	trigger_info VARCHAR(50)
);

INSERT INTO employee
VALUES('110', 'Dorathy', 'Godwin', '1973-07-05', 'F', '20000', '106', '1'
);

SELECT *
FROM trigger_status;


DELIMITER $$
CREATE
	TRIGGER employee_sex BEFORE INSERT
	ON employee
	FOR EACH ROW BEGIN
	IF NEW.sex = "M" THEN
    INSERT INTO trigger_status VALUES("Male employee was added");
    ELSEIF NEW.sex = "F" THEN
    INSERT INTO trigger_status VALUES("Female employee was added");
    ELSE
    INSERT INTO trigger_status VALUES("Another employee was added");
    END IF;
END$$
DELIMITER ;

INSERT INTO employee
VALUES('111', 'Ifeyinwa', 'Okafor', '1993-02-28', 'F', '69000', '102', '3'
);

 