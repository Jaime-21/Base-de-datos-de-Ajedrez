-- =====================
-- SCHEMA: Sistema de Gestión de Torneos de Ajedrez
-- Plataforma: Supabase (PostgreSQL)
-- =====================

CREATE TABLE jugadores (
    id_jugador INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    pais VARCHAR(100),
    elo INT,
    edad INT
);

CREATE TABLE torneos (
    id_torneo INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    ciudad VARCHAR(100),
    fecha_inicio DATE,
    fecha_fin DATE
);

CREATE TABLE partidas (
    id_partida INT PRIMARY KEY,
    id_torneo INT REFERENCES torneos(id_torneo),
    jugador_blancas INT REFERENCES jugadores(id_jugador),
    jugador_negras INT REFERENCES jugadores(id_jugador),
    ganador INT REFERENCES jugadores(id_jugador),
    cantidad_movimientos INT,
    apertura VARCHAR(100),
    resultado VARCHAR(50),
    fecha DATE
);

CREATE TABLE rankings (
    id_ranking INT PRIMARY KEY,
    id_jugador INT UNIQUE REFERENCES jugadores(id_jugador),
    puntos INT,
    victorias INT,
    derrotas INT,
    empates INT
);
