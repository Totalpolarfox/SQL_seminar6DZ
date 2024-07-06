/*
1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов.
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
*/
DROP FUNCTION format_duration;

DELIMITER $$
CREATE FUNCTION format_duration(seconds INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE days INT;
    DECLARE hours INT;
    DECLARE minutes INT;
    DECLARE result VARCHAR(100);
    
    IF seconds = 0 THEN
        RETURN 'now';
    END IF;
    
    SET days = FLOOR(seconds / (60 * 60 * 24));
    SET seconds = seconds % (60 * 60 * 24);
    
    SET hours = FLOOR(seconds / (60 * 60));
    SET seconds = seconds % (60 * 60);
    
    SET minutes = FLOOR(seconds / 60);
    SET seconds = seconds % 60;
    
    SET result = '';
    
    IF days > 0 THEN
        SET result = CONCAT(result, days, ' day');
        IF days > 1 THEN
            SET result = CONCAT(result, 's');
        END IF;
        SET result = CONCAT(result, ' ');
    END IF;
    
    IF hours > 0 THEN
        SET result = CONCAT(result, hours, ' hour');
        IF hours > 1 THEN
            SET result = CONCAT(result, 's');
        END IF;
        SET result = CONCAT(result, ' ');
    END IF;
    
    IF minutes > 0 THEN
        SET result = CONCAT(result, minutes, ' minute');
        IF minutes > 1 THEN
            SET result = CONCAT(result, 's');
        END IF;
        SET result = CONCAT(result, ' ');
    END IF;
    
    IF seconds > 0 THEN
        SET result = CONCAT(result, seconds, ' second');
        IF seconds > 1 THEN
            SET result = CONCAT(result, 's');
        END IF;
    END IF;
    
    RETURN TRIM(result);
END $$
DELIMITER ;

SELECT format_duration(5735267);

/*
2. Создайте процедуру.
Выведите только чётные числа от 1 до 10.
Пример: 2,4,6,8,10
*/

DROP PROCEDURE get_even_numbers;

DELIMITER $$
CREATE PROCEDURE get_even_numbers(num INT)
BEGIN
	DECLARE result VARCHAR(200) DEFAULT '2';
    DECLARE x INT DEFAULT '4';
    
    REPEAT
		SET result = CONCAT(result, ', ', x);
        SET x = x + 2;
		UNTIL x > num
	END REPEAT;
    
    SELECT result;
END $$
DELIMITER ;

CALL get_even_numbers(10)
