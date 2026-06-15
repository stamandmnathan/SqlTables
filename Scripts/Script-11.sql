
INSERT INTO easy.home_match_stats VALUES
(1, 1, '2024-01-01', 0),
(2, 1, '2024-01-08', 1),
(3, 1, '2024-01-15', 3),
(4, 1, '2024-01-22', 2),
(5, 2, '2024-01-01', 1),
(6, 2, '2024-01-08', 1),
(7, 2, '2024-01-15', 4),
(8, 2, '2024-01-22', 2);

-- STEP 1: Preview all rows with previous conceded alongside
SELECT team_id, match_date, goals_conceded,
  LAG(goals_conceded) OVER (PARTITION BY team_id ORDER BY match_date) AS prev_conceded
FROM easy.home_match_stats;

-- STEP 2: Filter only matches where defensive performance got worse
SELECT team_id, match_date, goals_conceded, prev_conceded
FROM (
  SELECT team_id, match_date, goals_conceded,
    LAG(goals_conceded) OVER (PARTITION BY team_id ORDER BY match_date) AS prev_conceded
  FROM easy.home_match_stats
) t
WHERE goals_conceded > prev_conceded;

-- STEP 3: Also show days since last home match using DATEDIFF equivalent in PostgreSQL
SELECT team_id, match_date, goals_conceded, prev_conceded,