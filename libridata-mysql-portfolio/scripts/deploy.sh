#!/bin/bash
# Script para implantar rapidamente o banco de dados LibriData
# Uso: ./deploy.sh [senha_do_usuario_lib_admin]

if [ -z "$1" ]; then
    echo "Forneça a senha do usuário 'lib_admin': ./deploy.sh senha"
    exit 1
fi

MYSQL_CMD="mariadb -u lib_admin -p$1"

echo "Removendo banco antigo..."
$MYSQL_CMD < sql/00_drop_database.sql

echo "Criando novo banco de dados..."
$MYSQL_CMD < sql/01_create_database.sql

echo "Criando tabelas..."
$MYSQL_CMD libridata < sql/02_create_tables.sql

echo "Inserindo dados de exemplo..."
$MYSQL_CMD libridata < sql/03_insert_sample_data.sql

echo "Criando views..."
$MYSQL_CMD libridata < sql/04_views.sql

echo "Criando procedures e triggers..."
$MYSQL_CMD libridata < sql/05_procedures_triggers.sql

echo "Implantação concluída com sucesso!"