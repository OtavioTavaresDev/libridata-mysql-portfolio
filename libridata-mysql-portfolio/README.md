# LibriData – Sistema de Gerenciamento de Biblioteca em MySQL

![MySQL](https://img.shields.io/badge/MySQL-8.0+-blue?logo=mysql)
![MariaDB](https://img.shields.io/badge/MariaDB-10.6+-brown?logo=mariadb)
![License](https://img.shields.io/badge/license-MIT-green)

**Banco de dados relacional completo para controle de acervo, membros e empréstimos de uma biblioteca.**

Projeto desenvolvido para demonstrar proficiência em **modelagem de dados**, **integridade transacional** e **automação de processos via SQL** (Stored Procedures, Views, Triggers).

---

## 📌 Funcionalidades Principais

- ✅ Cadastro de livros, autores, editoras e membros.
- ✅ Controle de empréstimos com **cálculo automático de data de devolução** (`GENERATED COLUMN`).
- ✅ Atualização automática de `available_copies` via **procedures transacionais**.
- ✅ **Views** para relatórios gerenciais (empréstimos ativos, atrasos, estatísticas).
- ✅ **Triggers** para validação de regras de negócio (membro suspenso, penalidade por atraso).
- ✅ **Script de deploy** pronto para reconstruir o ambiente.

---

## 🛠️ Tecnologias Utilizadas

- **MySQL / MariaDB** (compatível com ambos)
- SQL Avançado:
  - DDL (Constraints, Foreign Keys, Check, Generated Columns)
  - DML (Inserções, atualizações)
  - **Stored Procedures** com `TRANSACTION`
  - **Views** complexas com `GROUP_CONCAT`
  - **Triggers** (BEFORE/AFTER)
- Shell Script (para deploy automatizado)

---

## 🚀 Como Executar Localmente (Arch Linux / Qualquer distro)

### 1. Instalar e configurar o MariaDB (MySQL)

```bash
sudo pacman -S mariadb
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl enable --now mariadb
sudo mysql_secure_installation