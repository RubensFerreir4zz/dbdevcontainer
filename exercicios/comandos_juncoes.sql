-- 1. Listar todos os dados de todas as pessoas cadastradas.
-- Objetivo: Obter todas as informações de todas as pessoas registradas no banco de dados.
SELECT * FROM dbex.pessoa;

-- 2. Listar nome, e-mail e data de nascimento das pessoas cadastradas.
-- Objetivo: Listar especificamente o nome, e-mail e data de nascimento de todas as pessoas.
SELECT nome, email, data_nasc FROM dbex.pessoa;

-- 3. Listar nome, e-mail e data de nascimento da 3ª à 8ª pessoa cadastrada.
-- Objetivo: Realizar paginação pulando as 2 primeiras pessoas e retornando as próximas 6 (da 3ª à 8ª), ordenando por CPF para garantir determinismo.
SELECT nome, email, data_nasc 
FROM dbex.pessoa 
ORDER BY cpf 
LIMIT 6 OFFSET 2;

-- 4. Listar nome, e-mail e idade das pessoas cadastradas.
-- Objetivo: Exibir o nome, e-mail e calcular a idade aproximada em anos a partir da data de nascimento de cada pessoa utilizando a função AGE.
SELECT nome, email, EXTRACT(YEAR FROM AGE(data_nasc)) AS idade 
FROM dbex.pessoa;

-- 5. Listar a quantidade de agendamentos.
-- Objetivo: Obter o número total de consultas agendadas cadastradas no sistema.
SELECT COUNT(*) AS total_agendamentos FROM dbex.agendamento;

-- 6. Listar a data/hora das consultas e os respectivos valores com desconto de 5%. Os valores devem ser precedidos com "R$". Por exemplo: R$ 150.00.
-- Objetivo: Listar a data/hora e o valor das consultas aplicando um desconto de 5%, formatado com o prefixo "R$ ".
SELECT dh_consulta, 
       'R$ ' || TO_CHAR(valor_consulta * 0.95, 'FM999990.00') AS valor_com_desconto
FROM dbex.agendamento;

-- 7. Listar nome, cpf e e-mail dos pacientes que não possuem plano de saúde.
-- Objetivo: Obter nome, CPF e e-mail de todos os pacientes sem plano de saúde (plano_saude = FALSE).
SELECT pe.nome, pe.cpf, pe.email
FROM dbex.pessoa pe
INNER JOIN dbex.paciente pa ON pe.cpf = pa.cpf_pessoa
WHERE pa.plano_saude = FALSE;

-- 8. Listar os dados dos agendamentos registrados para o mesmo mês da consulta.
-- Objetivo: Filtrar os agendamentos cuja data de agendamento e data da consulta ocorram no mesmo mês (e ano).
SELECT * 
FROM dbex.agendamento
WHERE DATE_TRUNC('month', dh_agendamento) = DATE_TRUNC('month', dh_consulta);

-- 9. Listar cpf, nome e e-mail dos pacientes que não possuem telefone.
-- Objetivo: Retornar CPF, nome e e-mail de pacientes sem telefone cadastrado.
SELECT pe.cpf, pe.nome, pe.email
FROM dbex.pessoa pe
INNER JOIN dbex.paciente pa ON pe.cpf = pa.cpf_pessoa
WHERE pe.telefone IS NULL OR pe.telefone = '';

-- 10. Listar a data das consultas cujo o valor está entre R$ 50.00 e R$ 100.00.
-- Objetivo: Listar as datas em que as consultas agendadas possuem um valor entre R$ 50.00 e R$ 100.00 (inclusivo).
SELECT CAST(dh_consulta AS DATE) AS data_consulta
FROM dbex.agendamento
WHERE valor_consulta BETWEEN 50.00 AND 100.00;

-- 11. Listar cpf, nome e e-mail dos pacientes que moram em "Natal".
-- Objetivo: Filtrar e listar CPF, nome e e-mail de pacientes que moram em "Natal".
SELECT pe.cpf, pe.nome, pe.email
FROM dbex.pessoa pe
INNER JOIN dbex.paciente pa ON pe.cpf = pa.cpf_pessoa
WHERE pe.endereco ILIKE '%Natal%';

-- 12. Listar cpf, nome, e-mail e data de nascimento dos pacientes ordenados pela data de nascimento.
-- Objetivo: Retornar os dados pessoais dos pacientes de forma ordenada pela sua data de nascimento.
SELECT pe.cpf, pe.nome, pe.email, pe.data_nasc
FROM dbex.pessoa pe
INNER JOIN dbex.paciente pa ON pe.cpf = pa.cpf_pessoa
ORDER BY pe.data_nasc ASC;

-- 13. Listar a quantidade de pacientes que não possuem plano de saúde.
-- Objetivo: Contar o número de pacientes cadastrados que não possuem plano de saúde (plano_saude = FALSE).
SELECT COUNT(*) AS total_pacientes_sem_plano
FROM dbex.paciente
WHERE plano_saude = FALSE;

-- 14. Listar o maior e o menor valor das consultas agendadas para cada dia que contém consulta.
-- Objetivo: Agrupar por data (dia) da consulta e retornar o maior e o menor valor cobrado em cada dia.
SELECT CAST(dh_consulta AS DATE) AS dia_consulta,
       MAX(valor_consulta) AS maior_valor,
       MIN(valor_consulta) AS menor_valor
FROM dbex.agendamento
GROUP BY CAST(dh_consulta AS DATE)
ORDER BY dia_consulta;

-- 15. Listar a média dos valores das consultas agendadas para o mês de Dezembro.
-- Objetivo: Calcular a média dos valores de todas as consultas agendadas cuja consulta ocorre no mês de Dezembro.
SELECT AVG(valor_consulta) AS media_valores_dezembro
FROM dbex.agendamento
WHERE EXTRACT(MONTH FROM dh_consulta) = 12;

-- 16. Listar nome e e-mail das pessoas que agendaram alguma consulta para o dia do seu aniversário.
-- Objetivo: Listar o nome e e-mail dos pacientes com consulta no dia do aniversário.
SELECT DISTINCT pe.nome, pe.email
FROM dbex.pessoa pe
INNER JOIN dbex.paciente pa ON pe.cpf = pa.cpf_pessoa
INNER JOIN dbex.agendamento a ON pa.cpf_pessoa = a.cpf_paciente
WHERE EXTRACT(DAY FROM pe.data_nasc) = EXTRACT(DAY FROM a.dh_consulta)
  AND EXTRACT(MONTH FROM pe.data_nasc) = EXTRACT(MONTH FROM a.dh_consulta);

-- 17. Listar o nome, e-mail, cpf dos médicos e as suas respectivas especialidades.
-- Objetivo: Listar as informações básicas de cada médico junto com suas especialidades por extenso.
SELECT pe.nome, pe.email, pe.cpf, esp.descricao AS especialidade
FROM dbex.pessoa pe
INNER JOIN dbex.medico m ON pe.cpf = m.cpf_pessoa
INNER JOIN dbex.medicoespecialidade me ON m.cpf_pessoa = me.cpf_medico
INNER JOIN dbex.especialidade esp ON me.id_especialidade = esp.id;

-- 18. Listar a quantidade de consultas para cada médico.
-- Objetivo: Contar a quantidade de consultas por médico, incluindo os que possuem zero agendamentos.
SELECT pe.nome, m.crm, COUNT(a.cpf_medico) AS quantidade_consultas
FROM dbex.medico m
INNER JOIN dbex.pessoa pe ON m.cpf_pessoa = pe.cpf
LEFT OUTER JOIN dbex.agendamento a ON m.cpf_pessoa = a.cpf_medico
GROUP BY pe.nome, m.crm;
