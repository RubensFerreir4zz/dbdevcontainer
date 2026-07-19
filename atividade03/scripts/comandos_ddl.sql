-- 1. Criação da Tabela: WORKSPACE
-- Área de trabalho de um projeto.
CREATE TABLE WORKSPACE (
    name VARCHAR(150) NOT NULL,
    url_workspace VARCHAR(150) NOT NULL,
    CONSTRAINT workspace_pk PRIMARY KEY (name),
    CONSTRAINT workspace_url_un UNIQUE (url_workspace)
);

-- 2. Criação da Tabela: USER
-- Armazena os dados dos usuários cadastrados.
-- Obs: Professor, tive que usar "USER" com aspas, porque USER é uma palavra reservada
CREATE TABLE "USER" (
    email_user VARCHAR(100) NOT NULL,
    avatar VARCHAR(255),
    full_name VARCHAR(100),
    title VARCHAR(50),
    username VARCHAR(50) NOT NULL,
    CONSTRAINT user_pk PRIMARY KEY (email_user),
    CONSTRAINT user_username_un UNIQUE (username)
);

-- 3. Criação da Tabela: WORKSPACE_REGION
-- Define as regiões/timezones geográficas associadas ao workspace.
CREATE TABLE WORKSPACE_REGION (
    region VARCHAR(100) NOT NULL,
    url_workspace VARCHAR(150) NOT NULL,
    CONSTRAINT workspace_region_pk PRIMARY KEY (region, url_workspace),
    CONSTRAINT workspace_region_workspace_fk FOREIGN KEY (url_workspace)
        REFERENCES WORKSPACE (url_workspace) ON DELETE CASCADE
);

-- 4. Criação da Tabela: USER_WORKSPACE
-- Relação entre User e Workspace.
CREATE TABLE USER_WORKSPACE (
    email_user VARCHAR(100) NOT NULL,
    url_workspace VARCHAR(150) NOT NULL,
    CONSTRAINT user_workspace_pk PRIMARY KEY (email_user, url_workspace),
    CONSTRAINT user_workspace_user_fk FOREIGN KEY (email_user)
        REFERENCES "USER" (email_user) ON DELETE CASCADE,
    CONSTRAINT user_workspace_workspace_fk FOREIGN KEY (url_workspace)
        REFERENCES WORKSPACE (url_workspace) ON DELETE CASCADE
);

-- 5. Criação da Tabela: CYCLE
-- Representa os ciclos (sprints ou iterações) de tempo de trabalho.
CREATE TABLE CYCLE (
    id_cycle SERIAL NOT NULL,
    name VARCHAR(150) NOT NULL,
    description VARCHAR(250) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    CONSTRAINT cycle_pk PRIMARY KEY (id_cycle)
);

-- 6. Criação da Tabela: TEAM
-- Time dentro de um workspace.
CREATE TABLE TEAM (
    team_identifier VARCHAR(7) NOT NULL,
    name VARCHAR(150) NOT NULL,
    icon VARCHAR(255) NOT NULL,
    description VARCHAR(250),
    timezone INT NOT NULL,
    url_workspace VARCHAR(150) NOT NULL,
    id_cycle INT,
    CONSTRAINT team_pk PRIMARY KEY (team_identifier),
    CONSTRAINT team_workspace_fk FOREIGN KEY (url_workspace)
        REFERENCES WORKSPACE (url_workspace) ON DELETE CASCADE,
    CONSTRAINT team_cycle_fk FOREIGN KEY (id_cycle)
        REFERENCES CYCLE (id_cycle) ON DELETE SET NULL
);

-- 7. Criação da Tabela: PROJECT
-- Projetos que agrupam issues dentro de um workspace.
CREATE TABLE PROJECT (
    project_identifier SERIAL NOT NULL,
    name VARCHAR(150) NOT NULL,
    description VARCHAR(250),
    status VARCHAR(50) NOT NULL,
    priority INT,
    lead VARCHAR(100) NOT NULL,
    target_date DATE,
    start_date DATE,
    url_workspace VARCHAR(150) NOT NULL,
    team_identifier VARCHAR(7) NOT NULL,
    CONSTRAINT project_pk PRIMARY KEY (project_identifier),
    CONSTRAINT project_user_lead_un UNIQUE (lead),
    CONSTRAINT project_user_lead_fk FOREIGN KEY (lead)
        REFERENCES "USER" (email_user) ON DELETE CASCADE,
    CONSTRAINT project_workspace_fk FOREIGN KEY (url_workspace)
        REFERENCES WORKSPACE (url_workspace) ON DELETE CASCADE,
    CONSTRAINT project_team_fk FOREIGN KEY (team_identifier)
        REFERENCES TEAM (team_identifier) ON DELETE CASCADE
);

-- 8. Criação da Tabela: DEPENDE_PROJETO
-- Relação de dependência entre projetos.
CREATE TABLE DEPENDE_PROJETO (
    project_identifier_1 INT NOT NULL,
    project_identifier_2 INT NOT NULL,
    CONSTRAINT depende_projeto_pk PRIMARY KEY (project_identifier_1, project_identifier_2),
    CONSTRAINT depende_projeto1_fk FOREIGN KEY (project_identifier_1)
        REFERENCES PROJECT (project_identifier) ON DELETE CASCADE,
    CONSTRAINT depende_projeto2_fk FOREIGN KEY (project_identifier_2)
        REFERENCES PROJECT (project_identifier) ON DELETE CASCADE
);

-- 9. Criação da Tabela: ISSUE
-- Unidade de tarefa individual (Issue). Suporta sub-issues através de autorreferenciamento.
CREATE TABLE ISSUE (
    identifier VARCHAR(50) NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    status VARCHAR(50) NOT NULL,
    priority INT,
    team_identifier VARCHAR(7) NOT NULL,
    email_user VARCHAR(100),
    project_identifier INT,
    id_cycle INT,
    issue_identifier VARCHAR(50),
    due_date DATE,
    recurrent BOOLEAN NOT NULL DEFAULT FALSE,
    CONSTRAINT issue_pk PRIMARY KEY (identifier),
    CONSTRAINT issue_team_fk FOREIGN KEY (team_identifier)
        REFERENCES TEAM (team_identifier) ON DELETE CASCADE,
    CONSTRAINT issue_user_fk FOREIGN KEY (email_user)
        REFERENCES "USER" (email_user) ON DELETE SET NULL,
    CONSTRAINT issue_project_fk FOREIGN KEY (project_identifier)
        REFERENCES PROJECT (project_identifier) ON DELETE SET NULL,
    CONSTRAINT issue_cycle_fk FOREIGN KEY (id_cycle)
        REFERENCES CYCLE (id_cycle) ON DELETE SET NULL,
    CONSTRAINT issue_parent_fk FOREIGN KEY (issue_identifier)
        REFERENCES ISSUE (identifier) ON DELETE SET NULL
);

-- 10. Criação da Tabela: LABEL
-- Etiquetas (Labels) para classificar issues ou projetos.
CREATE TABLE LABEL (
    name VARCHAR(7) NOT NULL,
    CONSTRAINT label_pk PRIMARY KEY (name)
);

-- 11. Criação da Tabela: ISSUE_LABEL
-- Tabela associativa entre issues e labels.
CREATE TABLE ISSUE_LABEL (
    issue_identifier VARCHAR(50) NOT NULL,
    name_label VARCHAR(7) NOT NULL,
    CONSTRAINT issue_label_pk PRIMARY KEY (issue_identifier, name_label),
    CONSTRAINT issue_label_issue_fk FOREIGN KEY (issue_identifier)
        REFERENCES ISSUE (identifier) ON DELETE CASCADE,
    CONSTRAINT issue_label_label_fk FOREIGN KEY (name_label)
        REFERENCES LABEL (name) ON DELETE CASCADE
);

-- 12. Criação da Tabela: PROJECT_LABEL
-- Tabela associativa entre projetos e labels.
CREATE TABLE PROJECT_LABEL (
    project_identifier INT NOT NULL,
    name_label VARCHAR(7) NOT NULL,
    CONSTRAINT project_label_pk PRIMARY KEY (project_identifier, name_label),
    CONSTRAINT project_label_project_fk FOREIGN KEY (project_identifier)
        REFERENCES PROJECT (project_identifier) ON DELETE CASCADE,
    CONSTRAINT project_label_label_fk FOREIGN KEY (name_label)
        REFERENCES LABEL (name) ON DELETE CASCADE
);
