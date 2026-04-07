USE libridata;
DELIMITER //

-- Procedure para realizar um empréstimo (com transação)
CREATE PROCEDURE sp_borrow_book(
    IN p_book_id INT UNSIGNED,
    IN p_member_id INT UNSIGNED
)
BEGIN
    DECLARE available INT;
    DECLARE member_status VARCHAR(20);

    -- Verifica status do membro
    SELECT status INTO member_status FROM members WHERE member_id = p_member_id;
    IF member_status != 'active' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Membro não está ativo para empréstimos.';
    END IF;

    START TRANSACTION;
    
    SELECT available_copies INTO available FROM books WHERE book_id = p_book_id FOR UPDATE;
    
    IF available > 0 THEN
        INSERT INTO loans (book_id, member_id) VALUES (p_book_id, p_member_id);
        UPDATE books SET available_copies = available_copies - 1 WHERE book_id = p_book_id;
        COMMIT;
        SELECT CONCAT('Empréstimo do livro ID ', p_book_id, ' para membro ID ', p_member_id, ' realizado.') AS message;
    ELSE
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Livro não disponível para empréstimo.';
    END IF;
END //

-- Procedure para devolver um livro
CREATE PROCEDURE sp_return_book(IN p_loan_id INT UNSIGNED)
BEGIN
    DECLARE v_book_id INT UNSIGNED;
    DECLARE v_return_date DATE DEFAULT CURDATE();
    
    SELECT book_id INTO v_book_id FROM loans WHERE loan_id = p_loan_id AND return_date IS NULL;
    
    IF v_book_id IS NOT NULL THEN
        START TRANSACTION;
        UPDATE loans SET return_date = v_return_date WHERE loan_id = p_loan_id;
        UPDATE books SET available_copies = available_copies + 1 WHERE book_id = v_book_id;
        COMMIT;
        SELECT CONCAT('Livro do empréstimo ID ', p_loan_id, ' devolvido com sucesso.') AS message;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Empréstimo não encontrado ou já devolvido.';
    END IF;
END //

-- Trigger para impedir empréstimo se membro estiver suspenso (redundante com procedure, mas demonstra uso)
CREATE TRIGGER trg_check_member_status
BEFORE INSERT ON loans
FOR EACH ROW
BEGIN
    DECLARE member_status VARCHAR(20);
    SELECT status INTO member_status FROM members WHERE member_id = NEW.member_id;
    IF member_status = 'suspended' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Membro suspenso não pode realizar empréstimos.';
    END IF;
END //

-- Trigger para atualizar status do membro se houver atrasos excessivos (exemplo)
CREATE TRIGGER trg_update_member_status_after_return
AFTER UPDATE ON loans
FOR EACH ROW
BEGIN
    DECLARE overdue_count INT;
    -- Se o livro foi devolvido com atraso, verifica histórico
    IF NEW.return_date IS NOT NULL AND NEW.return_date > OLD.due_date THEN
        SELECT COUNT(*) INTO overdue_count
        FROM loans
        WHERE member_id = NEW.member_id AND return_date > due_date;
        
        IF overdue_count >= 3 THEN
            UPDATE members SET status = 'suspended' WHERE member_id = NEW.member_id;
        END IF;
    END IF;
END //

DELIMITER ;