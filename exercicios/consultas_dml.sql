

-- Limpar dados existentes para permitir reexecução limpa do script
DELETE FROM dbex.agendamento;
DELETE FROM dbex.medicoespecialidade;
DELETE FROM dbex.medico;
DELETE FROM dbex.paciente;
DELETE FROM dbex.especialidade;
DELETE FROM dbex.pessoa;


-- 1. Inserindo dados na tabela Pessoa
INSERT INTO dbex.pessoa (cpf, email, nome, data_nasc, endereco, telefone) VALUES
('122', 'pp@email.com', 'Pedro I', '1479-01-10', 'R. Vasco', '5501'),
('123', 'ps@email.com', 'Pedro II', '1516-02-10', 'R. Flamengo', '5501'),
('121', 'dj@email.com', 'D João VI', '1415-12-01', 'R. Portugal', NULL),
('124', 'jj@email.com', 'JJ Xavier', '1746-11-12', 'R. Minas', '5502');

-- 2. Inserindo dados na tabela Paciente
INSERT INTO dbex.paciente (cpf_pessoa, senha, plano_saude) VALUES
('122', 'senha1', FALSE),
('123', 'senha2', TRUE),
('124', 'senha3', TRUE);

-- 3. Inserindo dados na tabela Médico
INSERT INTO dbex.medico (cpf_pessoa, crm) VALUES
('121', '111'),
('124', '112');

-- 4. Inserindo dados na tabela Especialidade
INSERT INTO dbex.especialidade (id, descricao) VALUES
(11, 'Pediatra'),
(12, 'Cardiologista'),
(13, 'Ortopedista');

-- Ajustar sequência do serial se necessário (PostgreSQL)
SELECT setval('dbex.especialidade_id_seq', COALESCE((SELECT MAX(id) FROM dbex.especialidade), 1));

-- 5. Inserindo dados na tabela Médico-Especialidade
INSERT INTO dbex.medicoespecialidade (cpf_medico, id_especialidade) VALUES
('121', 11), -- D João VI é Pediatra
('124', 11), -- JJ Xavier é Pediatra
('124', 12); -- JJ Xavier é Cardiologista

-- 6. Inserindo dados na tabela Agendamento
INSERT INTO dbex.agendamento (cpf_paciente, cpf_medico, dh_consulta, dh_agendamento, valor_consulta) VALUES
('122', '121', '1782-04-14 16:00:00', '1782-03-14 10:04:45', 80.0),
('122', '124', '1782-04-15 10:00:00', '1782-03-14 10:04:45', 100.0),
('122', '124', '1783-05-17 08:00:00', '1783-05-10 16:32:00', 100.0),
('123', '121', '1783-05-17 08:30:00', '1783-05-09 09:05:56', 0.0); -- Pedro II tem plano de saúde, logo o valor é R$ 0.00

-- 7. Comandos de UPDATE demonstrativos
-- Objetivo: Atualizar o telefone de Pedro I.
UPDATE dbex.pessoa 
SET telefone = '5503' 
WHERE cpf = '122';

-- Objetivo: Atualizar o plano de saúde de Pedro I para TRUE (adquiriu plano).
UPDATE dbex.paciente 
SET plano_saude = TRUE 
WHERE cpf_pessoa = '122';

-- 8. Comandos de DELETE demonstrativos
-- Objetivo: Excluir um agendamento específico (Pedro I com médico JJ Xavier em 17/05/1783).
DELETE FROM dbex.agendamento 
WHERE cpf_paciente = '122' 
  AND cpf_medico = '124' 
  AND dh_consulta = '1783-05-17 08:00:00';
