-- Comando B1. Um comando INSERT para inserir 5 registros em cada uma das tabelas que compõem o modelo relacional.
-- 1. Inserindo dados na tabela: WORKSPACE
INSERT INTO WORKSPACE (name, url_workspace) VALUES
('Desenvolvimento', 'linear.app/devs'),
('Marketing', 'linear.app/marketing'),
('Suporte', 'linear.app/support'),
('Produto', 'linear.app/product'),
('Operações', 'linear.app/ops');

-- 2. Inserindo dados na tabela: "USER"
INSERT INTO "USER" (email_user, avatar, full_name, title, username) VALUES
('rubens@email.com', 'https://linear.app/avatars/rubens.png', 'Rubens Ferreira', 'Security Architect', 'rubensf'),
('mateus@email.com', 'https://linear.app/avatars/mateus.png', 'Mateus Felipe', 'Software Engineer', 'mateusf'),
('ana@email.com', 'https://linear.app/avatars/ana.png', 'Ana Souza', 'Marketing Specialist', 'anas'),
('carlos@email.com', 'https://linear.app/avatars/carlos.png', 'Carlos Lima', 'Support Agent', 'carlosl'),
('julia@email.com', 'https://linear.app/avatars/julia.png', 'Júlia Medeiros', 'Product Manager', 'juliam');

-- 3. Inserindo dados na tabela: WORKSPACE_REGION
INSERT INTO WORKSPACE_REGION (region, url_workspace) VALUES
('us-east-1', 'linear.app/devs'),
('sa-east-1', 'linear.app/devs'),
('eu-west-1', 'linear.app/marketing'),
('us-west-2', 'linear.app/support'),
('ap-northeast-1', 'linear.app/ops');

-- 4. Inserindo dados na tabela: USER_WORKSPACE
INSERT INTO USER_WORKSPACE (email_user, url_workspace) VALUES
('rubens@email.com', 'linear.app/devs'),
('mateus@email.com', 'linear.app/devs'),
('ana@email.com', 'linear.app/marketing'),
('carlos@email.com', 'linear.app/support'),
('julia@email.com', 'linear.app/product');

-- 5. Inserindo dados na tabela: CYCLE
INSERT INTO CYCLE (name, description, start_date, end_date) VALUES
('Ciclo de Alpha', 'Ciclo inicial de testes internos', '2026-07-01', '2026-07-14'),
('Ciclo de Beta', 'Ciclo de validação de funcionalidades com parceiros', '2026-07-15', '2026-07-28'),
('Ciclo de Lançamento', 'Ajustes finais e preparação para deploy em produção', '2026-07-29', '2026-08-11'),
('Ciclo de Manutenção', 'Resolução de incidentes e correções pós-lançamento', '2026-08-12', '2026-08-25'),
('Ciclo de Expansão', 'Planejamento e rascunhos de novas features', '2026-08-26', '2026-09-08');

-- 6. Inserindo dados na tabela: TEAM
INSERT INTO TEAM (team_identifier, name, icon, description, timezone, url_workspace, id_cycle) VALUES
('SAF', 'Segurança e Auditoria', 'https://linear.app/icons/safety.png', 'Time focado em segurança e conformidade', -3, 'linear.app/devs', 2),
('ENG', 'Engenharia de Plataforma', 'https://linear.app/icons/platform.png', 'Time focado em infraestrutura e tooling', -3, 'linear.app/devs', 2),
('MKT', 'Marketing Digital', 'https://linear.app/icons/marketing.png', 'Campanhas publicitárias e SEO', 0, 'linear.app/marketing', NULL),
('SUP', 'Suporte Técnico', 'https://linear.app/icons/support.png', 'Atendimento técnico de Nível 2 e Nível 3', -5, 'linear.app/support', NULL),
('PRD', 'Gestão de Produto', 'https://linear.app/icons/product.png', 'Desenho de novos fluxos e escopo', -3, 'linear.app/product', 3);

-- 7. Inserindo dados na tabela: PROJECT
INSERT INTO PROJECT (name, description, status, priority, lead, target_date, start_date, url_workspace, team_identifier) VALUES
('Refatoração da API', 'Melhorar performance dos endpoints de issues', 'In Progress', 1, 'mateus@email.com', '2026-08-15', '2026-07-20', 'linear.app/devs', 'ENG'),
('Nova Interface Web', 'Migração de componentes antigos para React/Tailwind', 'Planning', 2, 'rubens@email.com', '2026-09-30', '2026-08-01', 'linear.app/devs', 'SAF'),
('Campanha de E-mail', 'Automatizar envio de newsletters corporativas', 'Completed', 3, 'ana@email.com', '2026-07-18', '2026-07-05', 'linear.app/marketing', 'MKT'),
('Central de Ajuda', 'Criar FAQ e base de conhecimento integrada', 'In Progress', 2, 'carlos@email.com', '2026-08-30', '2026-07-15', 'linear.app/support', 'SUP'),
('Roadmap 2027', 'Planejamento estratégico de funcionalidades para 2027', 'Planning', 1, 'julia@email.com', '2026-12-15', '2026-09-01', 'linear.app/product', 'PRD');

-- 8. Inserindo dados na tabela: DEPENDE_PROJETO
INSERT INTO DEPENDE_PROJETO (project_identifier_1, project_identifier_2) VALUES
(2, 1), 
(4, 1), 
(5, 2), 
(2, 4), 
(5, 1); 

-- 9. Inserindo dados na tabela: ISSUE
INSERT INTO ISSUE (identifier, title, description, status, priority, team_identifier, email_user, project_identifier, id_cycle, issue_identifier, due_date, recurrent) VALUES
('ENG-101', 'Configurar Docker Compose', 'Criar arquivo base e variáveis de ambiente', 'Done', 1, 'ENG', 'mateus@email.com', 1, 2, NULL, '2026-07-20', FALSE),
('ENG-102', 'Otimizar queries do dashboard', 'Melhorar velocidade dos selects com índices', 'In Progress', 2, 'ENG', 'mateus@email.com', 1, 2, 'ENG-101', '2026-07-25', FALSE),
('SAF-30', 'Auditoria de Acesso', 'Revisar permissões de escrita dos endpoints', 'Todo', 1, 'SAF', 'rubens@email.com', 2, 2, NULL, '2026-08-10', FALSE),
('MKT-01', 'Redigir texto da newsletter', 'Produzir material de divulgação do novo layout', 'Done', 3, 'MKT', 'ana@email.com', 3, NULL, NULL, '2026-07-15', FALSE),
('SUP-50', 'Integrar Zendesk com Linear', 'Sincronizar tickets de suporte com issues do time', 'Todo', 2, 'SUP', 'carlos@email.com', 4, NULL, NULL, '2026-08-20', FALSE);

-- 10. Inserindo dados na tabela: LABEL
INSERT INTO LABEL (name) VALUES
('bug'),
('feature'),
('secur'),
('docs'),
('perf');

-- 11. Inserindo dados na tabela: ISSUE_LABEL
INSERT INTO ISSUE_LABEL (issue_identifier, name_label) VALUES
('ENG-102', 'perf'),
('ENG-101', 'feature'),
('SAF-30', 'secur'),
('MKT-01', 'docs'),
('SUP-50', 'feature');

-- 12. Inserindo dados na tabela: PROJECT_LABEL
INSERT INTO PROJECT_LABEL (project_identifier, name_label) VALUES
(1, 'perf'),
(2, 'feature'),
(2, 'secur'),
(4, 'docs'),
(5, 'feature');

--------------------------------------------

-- Comando B2. Comando para atualizar a timezone de todos os times para o padrão -3.
UPDATE TEAM
SET timezone = -3;

-- Comando B3. Comando para prorrogar a data de término de todos os projetos em planejamento (status = 'Planning').
UPDATE PROJECT
SET target_date = '2027-01-31'
WHERE status = 'Planning';

-- Comando B4. Comando para priorizar as tarefas críticas com status em andamento e prioridade igual a 2.
UPDATE ISSUE
SET priority = 1
WHERE status = 'In Progress' AND priority = 2;

-- Comando B5. Comando para atualizar o status e a descrição de um projeto específico.
UPDATE PROJECT
SET status = 'Completed', description = 'Refatoração da API finalizada com sucesso e homologada'
WHERE project_identifier = 1;

-- Comando B6. Comando para acrescentar um sufixo à descrição do time SAF usando o seu antigo valor.
UPDATE TEAM
SET description = description || ' (Foco principal)'
WHERE team_identifier = 'SAF';

-- Comando B7. Comando para formatar os títulos de todas as tarefas em letras maiúsculas usando a função UPPER.
UPDATE ISSUE
SET title = UPPER(title);

-- Comando B9. Comando para remover da tabela ISSUE as tarefas marcadas como recorrentes.
DELETE FROM ISSUE
WHERE recurrent = TRUE;

-- Comando B10. Comando para remover da tabela ISSUE as tarefas com prazo anterior a '2026-07-01' e com status 'Todo'.
DELETE FROM ISSUE
WHERE due_date < '2026-07-01' AND status = 'Todo';

-- Comando B11. Comando para remover da tabela ISSUE as tarefas com títulos muito curtos usando a função LENGTH.
DELETE FROM ISSUE
WHERE LENGTH(title) < 5;

-- Comando B8. Comando para remover todos os registros da tabela associativa PROJECT_LABEL.
DELETE FROM PROJECT_LABEL;
