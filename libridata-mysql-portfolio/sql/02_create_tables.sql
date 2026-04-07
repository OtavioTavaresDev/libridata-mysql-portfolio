USE libridata;

-- Tabela de Autores
CREATE TABLE authors (
    author_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birth_year SMALLINT,
    country VARCHAR(50)
) ENGINE=InnoDB;

-- Tabela de Editoras
CREATE TABLE publishers (
    publisher_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(80) NOT NULL UNIQUE,
    city VARCHAR(50)
) ENGINE=InnoDB;

-- Tabela de Livros
CREATE TABLE books (
    book_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    publication_year SMALLINT,
    publisher_id INT UNSIGNED,
    total_copies TINYINT UNSIGNED DEFAULT 1,
    available_copies TINYINT UNSIGNED DEFAULT 1,
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id) ON DELETE SET NULL,
    CONSTRAINT chk_copies CHECK (available_copies <= total_copies)
) ENGINE=InnoDB;

-- Tabela associativa Livros-Autores (relacionamento N:N)
CREATE TABLE book_authors (
    book_id INT UNSIGNED,
    author_id INT UNSIGNED,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Tabela de Membros da Biblioteca
CREATE TABLE members (
    member_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    registration_date DATE DEFAULT (CURRENT_DATE),
    status ENUM('active','suspended','expired') DEFAULT 'active'
) ENGINE=InnoDB;

-- Tabela de Empréstimos
CREATE TABLE loans (
    loan_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    book_id INT UNSIGNED NOT NULL,
    member_id INT UNSIGNED NOT NULL,
    loan_date DATE DEFAULT (CURRENT_DATE),
    due_date DATE GENERATED ALWAYS AS (loan_date + INTERVAL 14 DAY) STORED,
    return_date DATE NULL,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    CONSTRAINT chk_return_date CHECK (return_date IS NULL OR return_date >= loan_date)
) ENGINE=InnoDB;