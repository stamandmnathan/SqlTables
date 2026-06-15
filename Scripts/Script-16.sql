-- Add scout_id column for practice
ALTER TABLE easy.players ADD COLUMN scout_id INT;

UPDATE easy.players SET scout_id = 2 WHERE player_id IN (1, 2);
UPDATE easy.players SET scout_id = 1 WHERE player_id = 3;
-- remaining players left as NULL (no scout)

-- Q15: Players NOT scouted by scout 2 (including unscouted players)
SELECT name
FROM easy.players
WHERE scout_id IS NULL OR scout_id <> 2;

-- Naive version (WRONG — silently drops NULL scout_id rows)
SELECT name
FROM easy.players
WHERE scout_id != 2;