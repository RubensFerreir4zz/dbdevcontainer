-- Comando D1. Comando para listar o nome do projeto e o nome completo do seu respectivo líder.
SELECT p.name AS nome_projeto, u.full_name AS lider_projeto
FROM PROJECT p
INNER JOIN "USER" u ON p.lead = u.email_user;

-- Comando D2. Comando para exibir o título da issue, o nome do time responsável e o nome do projeto associado.
SELECT i.title AS titulo_issue, t.name AS nome_time, p.name AS nome_projeto
FROM ISSUE i
INNER JOIN TEAM t ON i.team_identifier = t.team_identifier
INNER JOIN PROJECT p ON i.project_identifier = p.project_identifier;

-- Comando D3. Comando para listar todos os times e seus ciclos de sprint ativos (incluindo times sem ciclo).
SELECT t.name AS nome_time, c.name AS nome_ciclo
FROM TEAM t
LEFT OUTER JOIN CYCLE c ON t.id_cycle = c.id_cycle;

-- Comando D4. Comando para listar a associação de todas as issues e todos os ciclos cadastrados usando FULL OUTER JOIN.
SELECT i.title AS titulo_issue, c.name AS nome_ciclo
FROM ISSUE i
FULL OUTER JOIN CYCLE c ON i.id_cycle = c.id_cycle;
