USE libridata;

-- Visão detalhada dos livros (com autores concatenados)
CREATE OR REPLACE VIEW vw_books_details AS
SELECT 
    b.book_id,
    b.title,
    GROUP_CONCAT(a.name SEPARATOR ', ') AS authors,
    p.name AS publisher,
    b.publication_year,
    b.isbn,
    b.total_copies,
    b.available_copies,
    (b.total_copies - b.available_copies) AS lent_copies
FROM books b
LEFT JOIN book_authors ba ON b.book_id = ba.book_id
LEFT JOIN authors a ON ba.author_id = a.author_id
LEFT JOIN publishers p ON b.publisher_id = p.publisher_id
GROUP BY b.book_id;

-- Visão de empréstimos ativos (não devolvidos) com dias de atraso
CREATE OR REPLACE VIEW vw_active_loans AS
SELECT 
    l.loan_id,
    m.full_name AS member,
    b.title AS book,
    l.loan_date,
    l.due_date,
    DATEDIFF(CURDATE(), l.due_date) AS days_overdue
FROM loans l
JOIN members m ON l.member_id = m.member_id
JOIN books b ON l.book_id = b.book_id
WHERE l.return_date IS NULL;

-- Visão de membros com livros atrasados
CREATE OR REPLACE VIEW vw_members_overdue AS
SELECT 
    m.full_name,
    m.email,
    COUNT(l.loan_id) AS overdue_loans,
    MAX(DATEDIFF(CURDATE(), l.due_date)) AS max_days_late
FROM members m
JOIN loans l ON m.member_id = l.member_id
WHERE l.return_date IS NULL AND l.due_date < CURDATE()
GROUP BY m.member_id;

-- Visão de estatísticas gerais
CREATE OR REPLACE VIEW vw_library_stats AS
SELECT 
    (SELECT COUNT(*) FROM books) AS total_books,
    (SELECT COUNT(*) FROM members WHERE status = 'active') AS active_members,
    (SELECT COUNT(*) FROM loans WHERE return_date IS NULL) AS current_loans,
    (SELECT COUNT(*) FROM vw_active_loans WHERE days_overdue > 0) AS overdue_loans;