
DROP TABLE IF EXISTS rankings CASCADE;
DROP TABLE IF EXISTS partidas CASCADE;
DROP TABLE IF EXISTS torneos CASCADE;
DROP TABLE IF EXISTS jugadores CASCADE;



CREATE TABLE jugadores (
    id_jugador SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    pais VARCHAR(50),
    elo INT,
    edad INT
);

CREATE TABLE torneos (
    id_torneo SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(50),
    fecha_inicio DATE,
    fecha_fin DATE
);

CREATE TABLE partidas (
    id_partida SERIAL PRIMARY KEY,
    id_torneo INT REFERENCES torneos(id_torneo),

    jugador_blancas INT REFERENCES jugadores(id_jugador),
    jugador_negras INT REFERENCES jugadores(id_jugador),

    ganador INT REFERENCES jugadores(id_jugador),

    cantidad_movimientos INT,
    apertura VARCHAR(100),

    resultado VARCHAR(20),

    fecha DATE
);

CREATE TABLE rankings (
    id_ranking SERIAL PRIMARY KEY,

    id_jugador INT REFERENCES jugadores(id_jugador),

    puntos INT DEFAULT 0,
    victorias INT DEFAULT 0,
    derrotas INT DEFAULT 0,
    empates INT DEFAULT 0
);


INSERT INTO jugadores (nombre, pais, elo, edad)
VALUES
('Magnus Carlsen', 'Noruega', 2830, 35),
('Hikaru Nakamura', 'Estados Unidos', 2789, 37),
('Fabiano Caruana', 'Estados Unidos', 2781, 34),
('Ding Liren', 'China', 2762, 33),
('Ian Nepomniachtchi', 'Rusia', 2758, 35),
('Alireza Firouzja', 'Francia', 2755, 22),
('Anish Giri', 'Paises Bajos', 2749, 31),
('Wesley So', 'Estados Unidos', 2745, 32),
('Levon Aronian', 'Armenia', 2740, 43),
('Viswanathan Anand', 'India', 2730, 56);



INSERT INTO torneos (nombre, ciudad, fecha_inicio, fecha_fin)
VALUES
('World Chess Championship', 'Londres', '2026-01-10', '2026-01-20'),
('Grandmaster Invitational', 'Paris', '2026-02-05', '2026-02-12'),
('Elite Chess Cup', 'New York', '2026-03-01', '2026-03-10'),
('International Open', 'Madrid', '2026-04-15', '2026-04-22');


INSERT INTO partidas
(
    id_torneo,
    jugador_blancas,
    jugador_negras,
    ganador,
    cantidad_movimientos,
    apertura,
    resultado,
    fecha
)
VALUES

(1, 1, 2, 1, 45, 'Defensa Siciliana', '1-0', '2026-01-11'),

(1, 3, 4, 3, 52, 'Gambito de Dama', '1-0', '2026-01-12'),

(1, 5, 6, 6, 61, 'Defensa Francesa', '0-1', '2026-01-13'),

(1, 7, 8, NULL, 40, 'Apertura Española', '1/2-1/2', '2026-01-14'),

(2, 1, 3, 1, 38, 'Defensa India de Rey', '1-0', '2026-02-06'),

(2, 2, 5, 2, 49, 'Sistema Londres', '1-0', '2026-02-06'),

(2, 4, 6, 6, 57, 'Defensa Caro-Kann', '0-1', '2026-02-07'),

(2, 9, 10, 9, 44, 'Apertura Inglesa', '1-0', '2026-02-08'),

(3, 1, 4, 1, 50, 'Defensa Siciliana', '1-0', '2026-03-02'),

(3, 2, 3, NULL, 35, 'Gambito de Rey', '1/2-1/2', '2026-03-03'),

(3, 5, 7, 5, 63, 'Defensa Nimzoindia', '1-0', '2026-03-04'),

(3, 6, 8, 6, 41, 'Defensa Francesa', '1-0', '2026-03-05'),

(4, 1, 5, 1, 47, 'Defensa Siciliana', '1-0', '2026-04-16'),

(4, 2, 6, 2, 39, 'Apertura Italiana', '1-0', '2026-04-17'),

(4, 3, 7, 3, 55, 'Defensa Escandinava', '1-0', '2026-04-18'),

(4, 4, 8, NULL, 46, 'Apertura Reti', '1/2-1/2', '2026-04-19');



INSERT INTO rankings
(id_jugador, puntos, victorias, derrotas, empates)
VALUES

(1, 8, 4, 0, 0),
(2, 5, 2, 1, 1),
(3, 5, 2, 1, 1),
(4, 1, 0, 2, 1),
(5, 2, 1, 2, 0),
(6, 6, 3, 1, 0),
(7, 1, 0, 2, 1),
(8, 1, 0, 1, 2),
(9, 2, 1, 0, 0),
(10, 0, 0, 1, 0);



SELECT
    nombre,
    pais,
    elo
FROM jugadores
ORDER BY elo DESC;


SELECT
    j.nombre,
    COUNT(p.id_partida) AS victorias
FROM jugadores j
JOIN partidas p
ON j.id_jugador = p.ganador
GROUP BY j.nombre
ORDER BY victorias DESC;


SELECT
    apertura,
    COUNT(*) AS veces_usada
FROM partidas
GROUP BY apertura
ORDER BY veces_usada DESC;


SELECT
    AVG(cantidad_movimientos) AS promedio_movimientos
FROM partidas;



SELECT
    nombre,
    elo,

    RANK() OVER (ORDER BY elo DESC) AS ranking_mundial

FROM jugadores;



WITH jugadores_elite AS
(
    SELECT
        nombre,
        elo
    FROM jugadores
    WHERE elo > 2770
)

SELECT *
FROM jugadores_elite;



SELECT
    t.nombre,
    COUNT(p.id_partida) AS total_partidas

FROM torneos t

JOIN partidas p
ON t.id_torneo = p.id_torneo

GROUP BY t.nombre

ORDER BY total_partidas DESC;


SELECT
    p.id_partida,

    jb.nombre AS jugador_blancas,

    jn.nombre AS jugador_negras,

    CASE
        WHEN p.ganador IS NULL THEN 'Empate'
        ELSE g.nombre
    END AS ganador,

    p.apertura,
    p.resultado,
    p.fecha

FROM partidas p

JOIN jugadores jb
ON p.jugador_blancas = jb.id_jugador

JOIN jugadores jn
ON p.jugador_negras = jn.id_jugador

LEFT JOIN jugadores g
ON p.ganador = g.id_jugador

ORDER BY p.fecha;


INSERT INTO jugadores (nombre, pais, elo, edad)
VALUES
('Gukesh Dommaraju', 'India', 2785, 19),
('Praggnanandhaa', 'India', 2768, 20),
('Arjun Erigaisi', 'India', 2750, 22),
('Nodirbek Abdusattorov', 'Uzbekistan', 2765, 21),
('Wei Yi', 'China', 2748, 26),
('Richard Rapport', 'Hungria', 2725, 29),
('Teimour Radjabov', 'Azerbaiyan', 2710, 39),
('Shakhriyar Mamedyarov', 'Azerbaiyan', 2732, 40),
('Jan-Krzysztof Duda', 'Polonia', 2741, 28),
('Maxime Vachier-Lagrave', 'Francia', 2753, 35);
 



INSERT INTO torneos (nombre, ciudad, fecha_inicio, fecha_fin)
VALUES
('Rapid Masters', 'Berlin', '2026-05-01', '2026-05-05'),
('Blitz Arena', 'Tokyo', '2026-06-10', '2026-06-12'),
('Continental Chess League', 'Buenos Aires', '2026-07-03', '2026-07-10'),
('Grand Prix Finals', 'Dubai', '2026-08-15', '2026-08-22');



INSERT INTO partidas
(
    id_torneo,
    jugador_blancas,
    jugador_negras,
    ganador,
    cantidad_movimientos,
    apertura,
    resultado,
    fecha
)
VALUES

(5, 11, 12, 11, 48, 'Defensa Siciliana', '1-0', '2026-05-01'),
(5, 13, 14, NULL, 42, 'Apertura Inglesa', '1/2-1/2', '2026-05-01'),
(5, 15, 16, 15, 56, 'Defensa Francesa', '1-0', '2026-05-02'),
(5, 17, 18, 18, 61, 'Defensa Caro-Kann', '0-1', '2026-05-02'),
(5, 19, 20, 19, 39, 'Sistema Londres', '1-0', '2026-05-03'),

(6, 1, 11, 1, 44, 'Defensa Siciliana', '1-0', '2026-06-10'),
(6, 2, 12, 2, 37, 'Gambito de Dama', '1-0', '2026-06-10'),
(6, 3, 13, NULL, 40, 'Defensa Nimzoindia', '1/2-1/2', '2026-06-10'),
(6, 4, 14, 14, 58, 'Defensa Escandinava', '0-1', '2026-06-11'),
(6, 5, 15, 5, 63, 'Apertura Italiana', '1-0', '2026-06-11'),
(6, 6, 16, 6, 52, 'Defensa Francesa', '1-0', '2026-06-11'),
(6, 7, 17, 17, 49, 'Apertura Reti', '0-1', '2026-06-12'),
(6, 8, 18, NULL, 35, 'Defensa India de Rey', '1/2-1/2', '2026-06-12'),

(7, 9, 19, 9, 41, 'Apertura Española', '1-0', '2026-07-03'),
(7, 10, 20, 20, 54, 'Defensa Siciliana', '0-1', '2026-07-03'),
(7, 11, 13, 11, 46, 'Defensa Francesa', '1-0', '2026-07-04'),
(7, 12, 14, NULL, 39, 'Apertura Inglesa', '1/2-1/2', '2026-07-04'),
(7, 15, 17, 15, 60, 'Defensa Caro-Kann', '1-0', '2026-07-05'),
(7, 16, 18, 18, 43, 'Sistema Londres', '0-1', '2026-07-05'),
(7, 19, 1, 1, 51, 'Defensa Siciliana', '0-1', '2026-07-06'),
(7, 20, 2, 2, 36, 'Gambito de Rey', '0-1', '2026-07-06'),

(8, 3, 11, 3, 47, 'Defensa Nimzoindia', '1-0', '2026-08-15'),
(8, 4, 12, 12, 55, 'Defensa Escandinava', '0-1', '2026-08-15'),
(8, 5, 13, NULL, 44, 'Apertura Italiana', '1/2-1/2', '2026-08-16'),
(8, 6, 14, 6, 62, 'Defensa Siciliana', '1-0', '2026-08-16'),
(8, 7, 15, 15, 53, 'Defensa Francesa', '0-1', '2026-08-17'),
(8, 8, 16, NULL, 38, 'Apertura Inglesa', '1/2-1/2', '2026-08-17'),
(8, 9, 17, 17, 50, 'Defensa Caro-Kann', '0-1', '2026-08-18'),
(8, 10, 18, 18, 45, 'Sistema Londres', '0-1', '2026-08-18');



INSERT INTO rankings
(id_jugador, puntos, victorias, derrotas, empates)
VALUES

(11, 6, 3, 1, 0),
(12, 4, 1, 1, 2),
(13, 3, 1, 1, 1),
(14, 5, 2, 1, 1),
(15, 7, 3, 0, 1),
(16, 2, 1, 2, 0),
(17, 6, 3, 1, 0),
(18, 7, 3, 0, 1),
(19, 4, 2, 2, 0),
(20, 3, 1, 2, 0);
