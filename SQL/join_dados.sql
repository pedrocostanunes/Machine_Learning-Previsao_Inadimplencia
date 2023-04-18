# Criando database para receber as tabelas
CREATE DATABASE analise_risco;
USE analise_risco;

# Tabelas carregadas via arquivos DUMP disponibilzados
# Vizualizando as tabelas carregadas
SELECT * FROM dados_mutuarios;
SELECT * FROM emprestimos;
SELECT * FROM historicos_banco;
SELECT * FROM ids;

# Fazendo o Join de todas as tabelas com os dados necessários em uma nova tabela 
# (não vamos precisar dos IDs para o modelo)
CREATE TABLE analise_risco_dados 
AS SELECT dm.person_age, dm.person_income, dm.person_emp_length, dm.person_home_ownership,
e.loan_intent, e.loan_grade, e.loan_amnt, e.loan_int_rate, e.loan_status, e.loan_percent_income,
hb.cb_person_default_on_file, hb.cb_person_cred_hist_length
FROM ids i
JOIN dados_mutuarios dm ON dm.person_id = i.person_id
JOIN emprestimos e ON e.loan_id = i.loan_id
JOIN historicos_banco hb ON hb.cb_id = i.cb_id;

# Vizualizando a tabela criada com os dados necessários
SELECT * FROM analise_risco_dados;

# Exportação de dados para .csv feita pelo "TableDataExportWizard" para tratamento em python
