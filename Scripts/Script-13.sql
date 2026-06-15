-- Q12: Running cumulative goals per player across the season
SELECT player_id, match_id,
  SUM(1) OVER (
    PARTITION BY player_id
    ORDER BY match_id
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS cumulative_goals
FROM easy.goals
ORDER BY player_id, match_id;