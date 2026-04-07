USE libridata;

-- Autores
INSERT INTO authors (name, birth_year, country) VALUES
('Machado de Assis', 1839, 'Brasil'),
('Clarice Lispector', 1920, 'Brasil'),
('George Orwell', 1903, 'Reino Unido'),
('J.K. Rowling', 1965, 'Reino Unido'),
('Carla Madeira', 1964, 'Brasil'),
('Itamar Vieira Junior', 1979, 'Brasil');

-- Editoras
INSERT INTO publishers (name, city) VALUES
('Companhia das Letras', 'São Paulo'),
('Rocco', 'Rio de Janeiro'),
('Penguin Books', 'Londres'),
('Bloomsbury', 'Londres'),
('Todavia', 'São Paulo');

-- Livros
INSERT INTO books (title, isbn, publication_year, publisher_id, total_copies, available_copies) VALUES
('Dom Casmurro', '9788535910663', 1899, 1, 3, 2),
('A Hora da Estrela', '978853250812X', 1977, 2, 2, 1),
('1984', '9780451524935', 1949, 3, 4, 3),
('Harry Potter e a Pedra Filosofal', '9788532511010', 1997, 4, 5, 5),
('Tudo é Rio', '9786580309312', 2014, 5, 2, 2),
('Torto Arado', '9786580309177', 2019, 5, 3, 3);

-- Relacionamentos Livro-Autor
INSERT INTO book_authors (book_id, author_id) VALUES
(1, 1),  -- Dom Casmurro - Machado
(2, 2),  -- A Hora da Estrela - Clarice
(3, 3),  -- 1984 - Orwell
(4, 4),  -- HP - Rowling
(5, 5),  -- Tudo é Rio - Carla Madeira
(6, 6);  -- Torto Arado - Itamar Vieira

-- Membros
INSERT INTO members (full_name, email, phone) VALUES
('João Silva', 'joao@email.com', '11988887777'),
('Maria Souza', 'maria@email.com', '21977776666'),
('Carlos Pereira', 'carlos@email.com', NULL),
('Ana Costa', 'ana.costa@email.com', '31966665555');

-- Empréstimos (alguns ativos, alguns devolvidos)
INSERT INTO loans (book_id, member_id, loan_date, return_date) VALUES
(1, 1, CURDATE() - INTERVAL 5 DAY, NULL),                             -- ativo
(3, 2, CURDATE() - INTERVAL 20 DAY, CURDATE() - INTERVAL 5 DAY),      -- devolvido
(4, 3, CURDATE() - INTERVAL 2 DAY, NULL),                             -- ativo
(2, 1, CURDATE() - INTERVAL 16 DAY, NULL),                            -- ativo (atrasado!)
(5, 4, CURDATE() - INTERVAL 10 DAY, CURDATE() - INTERVAL 2 DAY);      -- devolvido