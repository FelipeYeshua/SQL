SELECT * 
FROM Aluno 
WHERE status = 'ativo' 
ORDER BY nome;

SELECT T.id AS turma_id, T.nome AS turma, D.nome AS disciplina, P.nome AS professor
FROM Turma T
JOIN Disciplina D ON T.disciplina_id = D.id
JOIN Professor P ON T.professor_id = P.id;

INSERT INTO Aluno (nome, matricula, status) 
VALUES ('Eduardo Ramos', '2023004', 'ativo');

INSERT INTO Matricula (aluno_id, turma_id)
SELECT A.id, T.id
FROM Aluno A, Turma T
WHERE A.nome = 'Eduardo Ramos' AND T.nome = 'Estrutura de Dados';

INSERT INTO Presenca (aluno_id, turma_id, data, presente)
SELECT A.id, T.id, CURRENT_DATE + INTERVAL '7 days', FALSE
FROM Aluno A
JOIN Matricula M ON A.id = M.aluno_id
JOIN Turma T ON M.turma_id = T.id
WHERE A.nome = 'Eduardo Ramos' AND T.nome = 'Estrutura de Dados';

INSERT INTO Nota (aluno_id, turma_id, tipo_avaliacao, nota)
SELECT A.id, T.id, 'Prova', 7.5
FROM Aluno A
JOIN Matricula M ON A.id = M.aluno_id
JOIN Turma T ON M.turma_id = T.id
WHERE A.nome = 'Eduardo Ramos' AND T.nome = 'Estrutura de Dados';

SELECT A.nome AS aluno, N.tipo_avaliacao, N.nota
FROM Nota N
JOIN Aluno A ON N.aluno_id = A.id
JOIN Turma T ON N.turma_id = T.id
WHERE T.nome = 'Estrutura de Dados';

SELECT DISTINCT A.nome
FROM Presenca P
JOIN Aluno A ON P.aluno_id = A.id
WHERE P.presente = FALSE;

DELETE FROM Matricula 
WHERE aluno_id = (SELECT id FROM Aluno WHERE nome = 'Bruno Silva');

SELECT A.nome AS aluno, T.nome AS turma, D.nome AS disciplina, P.nome AS professor
FROM Matricula M
JOIN Aluno A ON M.aluno_id = A.id
JOIN Turma T ON M.turma_id = T.id
JOIN Disciplina D ON T.disciplina_id = D.id
JOIN Professor P ON T.professor_id = P.id;