DROP TABLE IF EXISTS Goals;
DROP TABLE IF EXISTS Players;


-- Step 2: Create Players table
CREATE TABLE Players (
    player_id SERIAL PRIMARY KEY,
    name      VARCHAR(255),
    team_id   INT
);

-- Step 3: Create Goals table
CREATE TABLE Goals (
    goal_id   SERIAL PRIMARY KEY,
    player_id INT,
    match_id  INT,
    minute    INT
);

-- Step 4: Insert Players data
INSERT INTO Players (name, team_id) VALUES
('Salah', 1),
('Haaland', 2),
('De Bruyne', 2),
('Van Dijk', 1);

-- Step 5: Insert Goals data
INSERT INTO Goals (player_id, match_id, minute) VALUES
(1, 1, 12),
(1, 1, 45),
(2, 1, 78),
(3, 2, 23),
(2, 2, 67);

-- Step 6: Run the query
SELECT p.name, p.team_id,
       COUNT(g.goal_id) AS goals,
       RANK() OVER (
           PARTITION BY p.team_id
           ORDER BY COUNT(g.goal_id) DESC
       ) AS team_rank
FROM Players p
LEFT JOIN Goals g ON p.player_id = g.player_id
GROUP BY p.player_id, p.name, p.team_id;