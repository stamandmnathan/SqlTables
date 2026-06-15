SELECT player_id, match_id
FROM (
  SELECT player_id, match_id,
    LAG(match_id, 1) OVER (PARTITION BY player_id ORDER BY match_id) AS prev1,
    LAG(match_id, 2) OVER (PARTITION BY player_id ORDER BY match_id) AS prev2
  FROM easy.goals
) t
WHERE match_id = prev1 + 1
  AND match_id = prev2 + 2;

SELECT * FROM easy.goals LIMIT 20;