
-- Criando o esquema dbex se não existir
CREATE SCHEMA IF NOT EXISTS dbex;

-- 1. Tabela Pessoa
-- Objetivo: Armazenar os dados das pessoas cadastradas no sistema.
CREATE TABLE IF NOT EXISTS dbex.pessoa (
    cpf CHAR(11) PRIMARY KEY,
    email VARCHAR(50) NOT NULL,
    nome VARCHAR(150) NOT NULL,
    data_nasc DATE NOT NULL,
    endereco VARCHAR(300) NOT NULL,
    telefone VARCHAR(15),
    CONSTRAINT pessoa_un UNIQUE (email, nome)
);

-- 2. Tabela Paciente (Subclasse de Pessoa)
-- Objetivo: Armazenar os dados específicos dos pacientes.
CREATE TABLE IF NOT EXISTS dbex.paciente (
    cpf_pessoa CHAR(11) PRIMARY KEY,
    senha VARCHAR(20) NOT NULL,
    plano_saude BOOLEAN NOT NULL DEFAULT FALSE,
    CONSTRAINT paciente_pessoa_fk FOREIGN KEY (cpf_pessoa) 
        REFERENCES dbex.pessoa(cpf) ON DELETE CASCADE
);

-- 3. Tabela Médico (Subclasse de Pessoa)
-- Objetivo: Armazenar os dados específicos dos médicos.
CREATE TABLE IF NOT EXISTS dbex.medico (
    cpf_pessoa CHAR(11) PRIMARY KEY,
    crm VARCHAR(10) NOT NULL UNIQUE,
    CONSTRAINT medico_pessoa_fk FOREIGN KEY (cpf_pessoa) 
        REFERENCES dbex.pessoa(cpf) ON DELETE CASCADE
);

-- 4. Tabela Especialidade
-- Objetivo: Armazenar as especialidades médicas cadastradas.
CREATE TABLE IF NOT EXISTS dbex.especialidade (
    id SERIAL PRIMARY KEY,
    descricao VARCHAR(300) NOT NULL
);

-- 5. Tabela Médico-Especialidade (Tabela associativa para relacionamento N:M)
-- Objetivo: Mapear o relacionamento de muitos-para-muitos entre médicos e suas especialidades.
CREATE TABLE IF NOT EXISTS dbex.medicoespecialidade (
    cpf_medico CHAR(11),
    id_especialidade INT,
    PRIMARY KEY (cpf_medico, id_especialidade),
    CONSTRAINT me_medico_fk FOREIGN KEY (cpf_medico) 
        REFERENCES dbex.medico(cpf_pessoa) ON DELETE CASCADE,
    CONSTRAINT me_especialidade_fk FOREIGN KEY (id_especialidade) 
        REFERENCES dbex.especialidade(id) ON DELETE CASCADE
);

-- 6. Tabela Agendamento
-- Objetivo: Armazenar os registros de consultas agendadas entre pacientes e médicos.
CREATE TABLE IF NOT EXISTS dbex.agendamento (
    cpf_paciente CHAR(11),
    cpf_medico CHAR(11),
    dh_consulta TIMESTAMP,
    dh_agendamento TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    valor_consulta FLOAT NOT NULL DEFAULT 0.0,
    PRIMARY KEY (cpf_paciente, cpf_medico, dh_consulta),
    CONSTRAINT agendamento_paciente_fk FOREIGN KEY (cpf_paciente) 
        REFERENCES dbex.paciente(cpf_pessoa) ON DELETE CASCADE,
    CONSTRAINT agendamento_medico_fk FOREIGN KEY (cpf_medico) 
        REFERENCES dbex.medico(cpf_pessoa) ON DELETE CASCADE
);
