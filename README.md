# Sistema de Gestión de Torneos de Ajedrez
**Curso:** Sistemas de Gestión de Bases de Datos — DatAI  
**Actividad:** Entregable Final — Plataforma de Datos en Acción  
**Plataforma:** Supabase (PostgreSQL)

---

## Integrantes
- Alejandro Santa
- Jaime Cotes

---

## Descripción del proyecto

Sistema de gestión y análisis de torneos de ajedrez. La base de datos centraliza información sobre jugadores, torneos, partidas y rankings, permitiendo consultas analíticas sobre rendimiento y estadísticas.

---

## Acceso a la base de datos

**URL del proyecto:**
```
https://xemmevpltwdwcevdnjwg.supabase.co
```

> Credenciales de acceso disponibles bajo solicitud. RLS desactivado intencionalmente para facilitar el acceso académico del evaluador.

---

## Estructura de la base de datos

| Tabla | Filas | Descripción |
|-------|-------|-------------|
| jugadores | 60 | Jugadores con nombre, país, ELO y edad |
| torneos | 25 | Torneos con nombre, ciudad y fechas |
| partidas | 658 | Enfrentamientos con apertura, resultado y movimientos |
| rankings | 60 | Estadísticas acumuladas por jugador |

---

## Contenido del entregable

```
Final_DatAI_SantaCotes/
│
├── README.md                   — este archivo
├── Consultasajedrez.ipynb      — notebook con consultas ejecutadas
└── informe_final.pdf           — informe del proyecto
```

---

## Consultas implementadas

| # | Título | Técnicas |
|---|--------|----------|
| 1 | Ranking general por puntos acumulados | Window Function, JOIN |
| 2 | Top 10 jugadores con más victorias | Agregación, JOIN |
| 3 | Aperturas más usadas y tasa de victoria | CASE, ROUND, GROUP BY |
| 4 | Torneos con mayor actividad y promedio de movimientos | JOIN, AVG, COUNT |
| 5 | Top 3 jugadores por torneo | CTE, Window Function, PARTITION BY |
| 6 | Jugadores por encima del promedio de puntos de su país | CTE, JOIN, filtro con agregación |

---

## Uso de inteligencia artificial

Se utilizó IA generativa como apoyo para el diseño del modelo relacional, generación de datos sintéticos, construcción de consultas SQL y estructuración del informe. Todas las decisiones de diseño fueron revisadas y validadas por el equipo.
