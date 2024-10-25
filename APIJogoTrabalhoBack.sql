CREATE TABLE JOGO (
    idJogo INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nomeJogo VARCHAR(255) NOT NULL,
    anoLancamento INT NOT NULL,
    descricaoJogo TEXT,
    idadeMinima INT
);

CREATE TABLE DESENVOLVEDOR (
    idDesenvolvedor INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nomeDesenvolvedor VARCHAR(255) NOT NULL,
    CNPJDesenvolvedor VARCHAR(18) UNIQUE
);

CREATE TABLE PLATAFORMA (
    idPlataforma INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nomePlataforma VARCHAR(255) NOT NULL,
    tipoPlataforma VARCHAR(50)
);

CREATE TABLE CATEGORIA (
    idCategoria INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nomeCategoria VARCHAR(100) NOT NULL
);

CREATE TABLE DLC (
    idDLC INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nomeDLC VARCHAR(255) NOT NULL,
    descricaoDLC TEXT
);

CREATE TABLE REQUISITOS_MINIMO_SISTEMA (
    idRequisitos INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    processador VARCHAR(255),
    RAM VARCHAR(50),
    placaVideo VARCHAR(255),
    sistemaOperacional VARCHAR(100)
);

CREATE TABLE JOGO_DESENVOLVEDOR (
    idJogo INT REFERENCES JOGO(idJogo) ON DELETE CASCADE ON UPDATE CASCADE,
    idDesenvolvedor INT REFERENCES DESENVOLVEDOR(idDesenvolvedor) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (idJogo, idDesenvolvedor)
);

CREATE TABLE JOGO_PLATAFORMA (
    idJogo INT REFERENCES JOGO(idJogo) ON DELETE CASCADE ON UPDATE CASCADE,
    idPlataforma INT REFERENCES PLATAFORMA(idPlataforma) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (idJogo, idPlataforma)
);

CREATE TABLE JOGO_CATEGORIA (
    idJogo INT REFERENCES JOGO(idJogo) ON DELETE CASCADE ON UPDATE CASCADE,
    idCategoria INT REFERENCES CATEGORIA(idCategoria) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (idJogo, idCategoria)
);

CREATE TABLE JOGO_REQUISITOS (
    idJogo INT REFERENCES JOGO(idJogo) ON DELETE CASCADE ON UPDATE CASCADE,
    idRequisitos INT REFERENCES REQUISITOS_MINIMO_SISTEMA(idRequisitos) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (idJogo, idRequisitos)
);

CREATE TABLE JOGO_DLC (
    idJogo INT REFERENCES JOGO(idJogo) ON DELETE CASCADE ON UPDATE CASCADE,
    idDLC INT REFERENCES DLC(idDLC) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (idJogo, idDLC)
);


INSERT INTO JOGO (nomeJogo, anoLancamento, descricaoJogo, idadeMinima) 
VALUES 
    ('Elden Ring', 2022, 'Um RPG de ação em mundo aberto, onde os jogadores exploram um vasto reino e enfrentam inimigos desafiadores.', 16),
    ('God of War Ragnarök', 2022, 'Continuação da saga de Kratos e Atreus, com uma nova história baseada na mitologia nórdica.', 18),
    ('The Legend of Zelda: Breath of the Wild', 2017, 'Um jogo de aventura e exploração em um mundo aberto, com mecânicas de física e ambientes interativos.', 10);

INSERT INTO DESENVOLVEDOR (nomeDesenvolvedor, CNPJDesenvolvedor) 
VALUES 
    ('FromSoftware', '12.345.678/0001-01'),
    ('Santa Monica Studio', '23.456.789/0001-02'),
    ('Nintendo', '34.567.890/0001-03');

INSERT INTO PLATAFORMA (nomePlataforma, tipoPlataforma) 
VALUES 
    ('PC', 'Computador'),
    ('PlayStation 5', 'Console'),
    ('Nintendo Switch', 'Console');

INSERT INTO CATEGORIA (nomeCategoria) 
VALUES 
    ('Ação'),
    ('Aventura'),
    ('RPG');

INSERT INTO DLC (nomeDLC, descricaoDLC) 
VALUES 
    ('Elden Ring: Shadow of the Erdtree', 'Expansão que adiciona novas áreas, inimigos e histórias ao jogo base.'),
    ('God of War Ragnarök: The Lost Pages', 'DLC que expande a narrativa com novas missões e personagens.'),
    ('The Legend of Zelda: Breath of the Wild - The Champions Ballad', 'Expansão que adiciona novas histórias e desafios para os campeões de Hyrule.');

INSERT INTO REQUISITOS_MINIMO_SISTEMA (processador, RAM, placaVideo, sistemaOperacional) 
VALUES 
    ('Intel Core i5-8400', '12GB', 'NVIDIA GTX 1060', 'Windows 10'),
    ('AMD Ryzen 3 1200', '8GB', 'NVIDIA GTX 1060', 'Windows 10'),
    ('Intel Core i5-6400', '8GB', 'NVIDIA GTX 660', 'Windows 10');	

INSERT INTO JOGO_DESENVOLVEDOR (idJogo, idDesenvolvedor) 
VALUES 
    (1, 1),  -- Elden Ring - FromSoftware
    (2, 2),  -- God of War Ragnarök - Santa Monica Studio
    (3, 3);  -- The Legend of Zelda: Breath of the Wild - Nintendo

INSERT INTO JOGO_PLATAFORMA (idJogo, idPlataforma) 
VALUES 
    (1, 1),  -- Elden Ring - Computador
    (2, 2),  -- God of War Ragnarök - PlayStation 5
    (3, 3);  -- The Legend of Zelda: Breath of the Wild - Nintendo Switch

INSERT INTO JOGO_CATEGORIA (idJogo, idCategoria) 
VALUES 
    (1, 3),  -- Elden Ring - RPG
    (2, 1),  -- God of War Ragnarök - Ação
    (3, 2);  -- The Legend of Zelda: Breath of the Wild - Aventura

INSERT INTO JOGO_REQUISITOS (idJogo, idRequisitos) 
VALUES 
    (1, 1),  -- Elden Ring - Requisitos Mínimos 1
    (2, 2),  -- God of War Ragnarök - Requisitos Mínimos 2
    (3, 3);  -- The Legend of Zelda: Breath of the Wild - Requisitos Mínimos 3

INSERT INTO JOGO_DLC (idJogo, idDLC) 
VALUES 
    (1, 1),  -- Elden Ring - DLC 1
    (2, 2),  -- God of War Ragnarök - DLC 2
    (3, 3);  -- The Legend of Zelda: Breath of the Wild - DLC 3

-- SELECT * FROM JOGO;
-- SELECT * FROM DESENVOLVEDOR;
-- SELECT * FROM PLATAFORMA;
-- SELECT * FROM CATEGORIA;
-- SELECT * FROM DLC;
-- SELECT * FROM REQUISITOS_MINIMO_SISTEMA;
-- SELECT * FROM JOGO_DESENVOLVEDOR;
-- SELECT * FROM JOGO_PLATAFORMA;
-- SELECT * FROM JOGO_CATEGORIA;
-- SELECT * FROM JOGO_REQUISITOS;
-- SELECT * FROM JOGO_DLC;