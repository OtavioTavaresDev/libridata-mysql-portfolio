-- Exemplos de consultas para demonstrar as funcionalidades

USE libridata;

-- 1. Listar todos os livros com detalhes (view)
SELECT * FROM vw_books_details;

-- 2. Empréstimos ativos e situação de atraso
SELECT * FROM vw_active_loans;

-- 3. Membros com livros atrasados
SELECT * FROM vw_members_overdue;

-- 4. Estatísticas gerais da biblioteca
SELECT * FROM vw_library_stats;

-- 5. Livros disponíveis para empréstimo (com mais de 0 cópias disponíveis)
SELECT title, available_copies FROM books WHERE available_copies > 0;

-- 6. Histórico de empréstimos de um membro específico (ex: João Silva, member_id=1)
SELECT 
    b.title,
    l.loan_date,
    l.due_date,
    l.return_date,
    CASE 
        WHEN l.return_date IS NULL THEN 'Emprestado'
        ELSE 'Devolvido'
    END AS status
FROM loans l
JOIN books b ON l.book_id = b.book_id
WHERE l.member_id = 1;

-- 7. Testar a procedure de empréstimo (comente se for executar)
-- CALL sp_borrow_book(2, 3);  -- membro 3 pega livro 2

-- 8. Testar a procedure de devolução
-- CALL sp_return_book(2);      -- devolve empréstimo ID 2