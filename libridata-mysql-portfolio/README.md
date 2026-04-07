# Libridata – MySQL Library Management System

## Overview
Libridata is a relational database project designed to simulate a real-world library system.  
The goal is to demonstrate strong skills in **data modeling, normalization, query optimization, and business logic implementation using MySQL**.

This project goes beyond basic CRUD operations by focusing on:
- Data integrity
- Real-world constraints
- Analytical queries
- Performance optimization

---

## Problem Statement
Traditional small library systems often lack:
- Historical tracking of loans
- Fine-grained control over inventory
- Analytical insights (usage patterns, delays, etc.)

Libridata solves this by providing a structured and scalable relational model.

---

## Features
- Book catalog management
- User management
- Loan tracking (historical)
- Fine calculation system
- Category hierarchy
- Analytical queries
- Optimized indexing

---

## Database Design

### Core Entities
- Users
- Books
- Authors
- Categories
- Loans
- Fines

---

## Normalization
The database is normalized up to **Third Normal Form (3NF)**:
- No redundant data
- Clear separation of concerns
- Referential integrity enforced

---

## Key Design Decisions

### 1. Historical Loan Tracking
Loans are never overwritten.  
Each transaction is stored permanently for analysis.

### 2. Many-to-Many Relationships
- Books ↔ Authors
- Books ↔ Categories

### 3. Fine System
Fines are calculated based on delay and stored separately.

---

## Indexing Strategy

Indexes are applied to:
- Foreign keys
- Frequently queried columns
- Date-based filtering

Example:
```sql
CREATE INDEX idx_loans_user_id ON loans(user_id);
CREATE INDEX idx_loans_due_date ON loans(due_date);

## How to Run

1. Run schema.sql to create the database
2. Run seed.sql to insert sample data
3. Run queries from queries/analytics.sql
4. Optional:
   - Run triggers.sql
   - Run views.sql
