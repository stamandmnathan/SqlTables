SELECT player_id, match_id, minute
FROM easy.goals
WHERE (player_id, match_id) IN (
  SELECT player_id, MIN(match_id)
  FROM easy.goals
  GROUP BY player_id
);