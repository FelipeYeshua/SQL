CREATE DATABASE ceub_universidade;
USE ceub_universidade;

-- 1. Departamento
CREATE TABLE Departamento (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL
);

-- 2. Professor
CREATE TABLE Professor (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    IdDepartamento INT,
    FOREIGN KEY (IdDepartamento) REFERENCES Departamento(Id)
);

-- 3. Curso
CREATE TABLE Curso (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Nivel ENUM('Graduação', 'Pós', 'Mestrado', 'Doutorado') DEFAULT 'Graduação',
    IdDepartamento INT,
    FOREIGN KEY (IdDepartamento) REFERENCES Departamento(Id)
);

-- 4. Disciplina
CREATE TABLE Disciplina (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CargaHoraria INT CHECK (CargaHoraria > 0),
    IdCurso INT NOT NULL,
    FOREIGN KEY (IdCurso) REFERENCES Curso(Id)
);

-- 5. Aluno
CREATE TABLE Aluno (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Matricula VARCHAR(20) UNIQUE NOT NULL,
    Ativo BOOLEAN DEFAULT TRUE
);

-- 6. Turma
CREATE TABLE Turma (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Ano INT NOT NULL,
    Semestre TINYINT CHECK (Semestre IN (1, 2)),
    IdDisciplina INT,
    IdProfessor INT,
    FOREIGN KEY (IdDisciplina) REFERENCES Disciplina(Id),
    FOREIGN KEY (IdProfessor) REFERENCES Professor(Id)
);

-- 7. MatriculaAluno
CREATE TABLE MatriculaAluno (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    IdAluno INT,
    IdTurma INT,
    DataMatricula DATE,
    FOREIGN KEY (IdAluno) REFERENCES Aluno(Id) ON DELETE CASCADE,
    FOREIGN KEY (IdTurma) REFERENCES Turma(Id) ON DELETE CASCADE
);

-- 8. Avaliacao
CREATE TABLE Avaliacao (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Tipo ENUM('Prova', 'Trabalho', 'Projeto'),
    Peso DECIMAL(3,2),
    IdTurma INT,
    FOREIGN KEY (IdTurma) REFERENCES Turma(Id)
);

-- 9. Nota
CREATE TABLE Nota (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    IdAvaliacao INT,
    IdAluno INT,
    Nota DECIMAL(4,2) CHECK (Nota >= 0 AND Nota <= 10),
    FOREIGN KEY (IdAvaliacao) REFERENCES Avaliacao(Id),
    FOREIGN KEY (IdAluno) REFERENCES Aluno(Id)
);

-- 10. Presenca
CREATE TABLE Presenca (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    IdAluno INT,
    IdTurma INT,
    DataAula DATE,
    Presente BOOLEAN,
    FOREIGN KEY (IdAluno) REFERENCES Aluno(Id),
    FOREIGN KEY (IdTurma) REFERENCES Turma(Id)
);


