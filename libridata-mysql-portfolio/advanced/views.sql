CREATE VIEW active_loans AS
SELECT 
    l.id,
    u.name AS user,
    b.title AS book,
    l.due_date
FROM loans l
JOIN users u ON l.user_id = u.id
JOIN books b ON l.book_id = b.id
WHERE l.status = 'BORROWED';
