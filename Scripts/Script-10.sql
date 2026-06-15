-- STEP 1: Always run SELECT first to preview what will be deleted
SELECT g1.goal_id, g1.player_id, g1.match_id, g1.minute
FROM easy.goals AS g1
JOIN easy.goals AS g2
  ON g1.player_id = g2.player_id
 AND g1.match_id  = g2.match_id
 AND g1.minute    = g2.minute
 AND g1.goal_id   > g2.goal_id;

-- STEP 2: Insert duplicate data to practice on
INSERT INTO easy.goals VALUES
(100, 1, 1, 45),
(101, 1, 1, 45),
(102, 2, 2, 60),
(103, 2, 2, 60);

-- STEP 3: Delete duplicates, keep lowest goal_id (PostgreSQL syntax)
DELETE FROM easy.goals AS g1
USING easy.goals AS g2
WHERE g1.player_id = g2.player_id
  AND g1.match_id  = g2.match_id
  AND g1.minute    = g2.minute
  AND g1.goal_id   > g2.goal_id;

-- STEP 4: Verify duplicates are gone
SELECT * FROM easy.goals WHERE goal_id IN (100, 101, 102, 103);