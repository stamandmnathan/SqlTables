-- Q13: Find managers with 5+ direct reports
SELECT name AS manager
FROM easy.players
WHERE player_id IN (
  SELECT manager_id
  FROM easy.players
  GROUP BY manager_id
  HAVING COUNT(*) >= 5
);

-- Add manager_id column to practice
ALTER TABLE easy.players ADD COLUMN manager_id INT;

UPDATE easy.players SET manager_id = 3 WHERE player_id IN (1, 2, 4, 5, 6);
UPDATE easy.players SET manager_id = NULL WHERE player_id = 3;

-- Q13: Now run the actual query
SELECT name AS manager
FROM easy.players
WHERE player_id IN (
  SELECT manager_id
  FROM easy.players
  GROUP BY manager_id
  HAVING COUNT(*) >= 5
);

-- Check how many players exist and their manager assignments
SELECT * FROM easy.players;