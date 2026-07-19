-- Comando C1. Comando para listar todos os usuários cadastrados na tabela "USER".
SELECT email_user, avatar, full_name, title, username 
FROM "USER";

-- Comando C2. Comando para listar a sigla e o nome dos times com timezone igual a -3.
SELECT team_identifier, name 
FROM TEAM 
WHERE timezone = -3;

-- Comando C3. Comando para listar o identificador, título e status de tarefas concluídas com prioridade máxima (prioridade = 1).
SELECT identifier, title, status, priority 
FROM ISSUE 
WHERE status = 'Done' AND priority = 1;

-- Comando C4. Comando para exibir o total de issues agrupadas por status, filtrando por prioridade 1 ou 2.
SELECT status, COUNT(*) AS quantidade_issues
FROM ISSUE
WHERE priority IN (1, 2)
GROUP BY status;

-- Comando C5. Comando para buscar os projetos liderados por membros com cargo de 'Software Engineer'.
SELECT project_identifier, name, description, status 
FROM PROJECT 
WHERE lead IN (
    SELECT email_user 
    FROM "USER" 
    WHERE title = 'Software Engineer'
);
