CREATE TABLE IF NOT EXISTS JOGO (
    idJogo INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nomeJogo VARCHAR(255) NOT NULL,
    anoLancamento INT NOT NULL,
    descricaoJogo TEXT,
    idadeMinima INT,
    desenvolvedor VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS PLATAFORMA (
    idPlataforma INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nomePlataforma VARCHAR(255) NOT NULL,
    tipoPlataforma VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS CATEGORIA (
    idCategoria INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nomeCategoria VARCHAR(100) NOT NULL
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



INSERT INTO JOGO (nomeJogo, anoLancamento, descricaoJogo, idadeMinima, desenvolvedor) 
VALUES 
    ('Elden Ring', 2022, 'Um RPG de ação em mundo aberto, onde os jogadores exploram um vasto reino e enfrentam inimigos desafiadores.', 16, 'FromSoftware'),
    ('God of War Ragnarök', 2022, 'Continuação da saga de Kratos e Atreus, com uma nova história baseada na mitologia nórdica.', 18, 'Santa Monica Studio'),
    ('The Legend of Zelda: Breath of the Wild', 2017, 'Um jogo de aventura e exploração em um mundo aberto, com mecânicas de física e ambientes interativos.', 10, 'Nintendo');

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

-- SELECT * FROM JOGO;
-- SELECT * FROM PLATAFORMA;
-- SELECT * FROM CATEGORIA;
-- SELECT * FROM JOGO_PLATAFORMA;
-- SELECT * FROM JOGO_CATEGORIA;