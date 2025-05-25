CREATE DATABASE impostor CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE impostor;

CREATE TABLE subject (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    height FLOAT,
    weight FLOAT,
    birthdate DATE,
    haircolor VARCHAR(50),
    eyecolor VARCHAR(50)
);

CREATE TABLE detective (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    years_experience INT,
    birthdate DATE
);

CREATE TABLE questions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    question TEXT,
    detective_id INT,
    time DATETIME,
    FOREIGN KEY (detective_id) REFERENCES detective(id)
);

CREATE TABLE answers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    answer TEXT,
    subject_id INT,
    question_id INT,
    FOREIGN KEY (subject_id) REFERENCES subject(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO subject (name, height, weight, birthdate, haircolor, eyecolor) VALUES
('Kovács Anna', 165.2, 58.0, '1990-05-12', 'barna', 'zöld'),
('Szabó Péter', 178.4, 75.5, '1985-11-03', 'fekete', 'kék'),
('Tóth Eszter', 160.0, 50.2, '1992-07-21', 'szőke', 'barna'),
('Nagy Ádám', 182.3, 82.1, '1989-02-18', 'barna', 'kék'),
('Farkas Dániel', 170.5, 68.0, '1995-12-30', 'fekete', 'zöld'),
('Balogh Réka', 168.8, 60.4, '1993-09-25', 'vörös', 'barna'),
('Lukács Zsolt', 176.0, 74.3, '1987-04-04', 'szőke', 'barna'),
('Pintér Márta', 162.7, 55.0, '1994-03-16', 'barna', 'szürke'),
('Simon Levente', 185.6, 89.2, '1986-07-08', 'fekete', 'zöld'),
('Barta Noémi', 159.9, 53.1, '1991-06-11', 'szőke', 'kék');

INSERT INTO detective (name, years_experience, birthdate) VALUES
('Nyomozó Béla', 10, '1980-04-01'),
('Kiss Dóra', 5, '1988-09-17'),
('Horváth Gábor', 15, '1975-12-22');

INSERT INTO questions (question, detective_id, time) VALUES
('Hol voltál tegnap este?', 1, '2025-05-13 18:30:00'),
('Ismersz valakit a társaságból, aki furcsán viselkedett?', 2, '2025-05-13 19:00:00'),
('Mit gondolsz, ki lehet az áruló?', 3, '2025-05-14 09:15:00'),
('Láttál valami szokatlant az elmúlt napokban?', 1, '2025-05-14 10:00:00');

INSERT INTO answers (answer, subject_id, question_id) VALUES
('Otthon voltam, filmeket néztem.', 1, 1),
('Igen, Péter elég ideges volt.', 3, 2),
('Szerintem Dániel gyanús.', 2, 3),
('Nem, semmi furcsát nem vettem észre.', 4, 4),
('Azt hiszem, valaki kotorászott a táskámban.', 5, 4),
('Lehet, hogy Eszter volt az.', 6, 3),
('Nem is voltam ott, csak másnap reggel érkeztem.', 7, 1),
('Talán valaki szándékosan hallgat.', 8, 2);

SELECT s.name AS válaszadó, a.answer
FROM answers a
JOIN subject s ON a.subject_id = s.id
WHERE a.answer LIKE '%gyanús%' OR a.answer LIKE '%lehet, hogy%';

SELECT s.name AS válaszadó, a.answer
FROM answers a
JOIN subject s ON a.subject_id = s.id
WHERE a.answer LIKE '%nem vettem észre%' OR a.answer LIKE '%nem is voltam ott%';

SELECT q.question, d.name AS nyomozó
FROM questions q
JOIN detective d ON q.detective_id = d.id
WHERE q.question LIKE '%ki lehet az áruló%';

SELECT s.name AS válaszadó, q.time
FROM answers a
JOIN subject s ON a.subject_id = s.id
JOIN questions q ON a.question_id = q.id
ORDER BY q.time ASC
LIMIT 1;

SELECT s2.name AS említett_személy, COUNT(*) AS említések_száma
FROM subject s2
JOIN answers a ON a.answer LIKE CONCAT('%', s2.name, '%')
GROUP BY s2.name
ORDER BY említések_száma DESC;