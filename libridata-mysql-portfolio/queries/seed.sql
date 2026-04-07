INSERT INTO users (name, email) VALUES
('Alice', 'alice@email.com'),
('Bob', 'bob@email.com');

INSERT INTO books (title, isbn, published_year) VALUES
('Clean Code', '123', 2008),
('The Pragmatic Programmer', '456', 1999);

INSERT INTO authors (name) VALUES
('Robert C. Martin'),
('Andrew Hunt');

INSERT INTO book_authors VALUES
(1,1),
(2,2);

INSERT INTO loans (user_id, book_id, loan_date, due_date, return_date, status) VALUES
(1,1,'2026-01-01','2026-01-10','2026-01-12','RETURNED'),
(2,2,'2026-02-01','2026-02-10',NULL,'BORROWED');
