
-- MOST BORROWED BOOKS
SELECT b.title, COUNT(*) AS total_loans
FROM loans l
JOIN books b ON l.book_id = b.id
GROUP BY b.title
ORDER BY total_loans DESC;

-- USERS WITH LATE RETURNS
SELECT u.name, COUNT(*) AS late_returns
FROM loans l
JOIN users u ON l.user_id = u.id
WHERE l.return_date > l.due_date
GROUP BY u.name;

-- AVERAGE DELAY
SELECT AVG(DATEDIFF(return_date, due_date)) AS avg_delay
FROM loans
WHERE return_date > due_date;
