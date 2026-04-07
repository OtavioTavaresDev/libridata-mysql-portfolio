DELIMITER $$

CREATE TRIGGER calculate_fine
AFTER UPDATE ON loans
FOR EACH ROW
BEGIN
    IF NEW.return_date > NEW.due_date THEN
        INSERT INTO fines (loan_id, amount)
        VALUES (NEW.id, DATEDIFF(NEW.return_date, NEW.due_date) * 2.00);
    END IF;
END$$

DELIMITER ;
