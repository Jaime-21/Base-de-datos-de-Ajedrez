Primera consulta

SELECT
nombre,
elo
FROM jugadores
ORDER BY elo DESC;


Segunda consulta

SELECT
apertura,
COUNT(*) AS veces_usada
FROM partidas
GROUP BY apertura
ORDER BY veces_usada DESC;



Tercera consulta

SELECT
j.nombre,
COUNT(p.id_partida) AS victorias

FROM jugadores j
JOIN partidas p
ON j.id_jugador = p.ganador

GROUP BY j.nombre
ORDER BY victorias DESC;






Cuarta consulta


SELECT
    t.nombre,
    COUNT(p.id_partida) AS partidas

FROM torneos t

JOIN partidas p
ON t.id_torneo = p.id_torneo

GROUP BY t.nombre

ORDER BY partidas DESC;




Quinta consulta


WITH elite AS (
    SELECT nombre, elo
    FROM jugadores
    WHERE elo > 2770
)

SELECT *
FROM elite;