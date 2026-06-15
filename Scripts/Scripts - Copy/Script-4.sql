-- Step 1: Drop all tables
DROP TABLE IF EXISTS Goals;
DROP TABLE IF EXISTS Players;
DROP TABLE IF EXISTS Teams;

-- Step 2: Create Teams table
CREATE TABLE Teams (
    team_id  SERIAL PRIMARY KEY,
    name     VARCHAR(255),
    league   VARCHAR(255)
);

-- Step 3: Create Players table
CREATE TABLE Players (
    player_id SERIAL PRIMARY KEY,
    name      VARCHAR(255),
    position  VARCHAR(10),
    salary    INT,
    team_id   INT
);

-- Step 4: Create Goals table
CREATE TABLE Goals (
    goal_id   SERIAL PRIMARY KEY,
    player_id INT,
    match_id  INT,
    minute    INT
);

-- Step 5: Insert Teams data
INSERT INTO Teams (name, league) VALUES
('Liverpool',   'Premier League'),
('Man City',    'Premier League'),
('Arsenal',     'Premier League'),
('Barcelona',   'La Liga'),
('Real Madrid', 'La Liga'),
('Atletico',    'La Liga');

-- Step 6: Insert Players data
INSERT INTO Players (name, position, salary, team_id) VALUES
('Salah',        'FWD', 125000, 1),
('Van Dijk',     'DEF', 110000, 1),
('Trent',        'DEF',  95000, 1),
('Haaland',      'FWD', 120000, 2),
('De Bruyne',    'MID', 130000, 2),
('Dias',         'DEF',  90000, 2),
('Saka',         'FWD', 100000, 3),
('Fernandes',    'MID', 105000, 3),
('Martinelli',   'FWD',  95000, 3),
('Lewandowski',  'FWD', 120000, 4),
('Pedri',        'MID', 100000, 4),
('Yamal',        'FWD',  85000, 4),
('Mbappe',       'FWD', 150000, 5),
('Vinicius',     'FWD', 130000, 5),
('Bellingham',   'MID', 125000, 5),
('Griezmann',    'MID', 110000, 6),
('Morata',       'FWD',  95000, 6),
('Koke',         'MID',  90000, 6);

-- Step 7: Insert Goals data
INSERT INTO Goals (player_id, match_id, minute) VALUES
(1, 1, 12), (1, 2, 34), (1, 3, 56),   -- Salah 3 goals
(4, 1, 23), (4, 2, 67), (4, 3, 89), (4, 4, 45),  -- Haaland 4 goals
(7, 2, 11), (7, 3, 22),               -- Saka 2 goals
(8, 1, 33),                            -- Fernandes 1 goal
(9, 2, 44), (9, 3, 55),               -- Martinelli 2 goals
(10, 1, 10), (10, 2, 20), (10, 3, 30), (10, 4, 40), (10, 5, 50), -- Lewandowski 5 goals
(12, 1, 15), (12, 2, 25),             -- Yamal 2 goals
(11, 3, 35), (11, 4, 45),             -- Pedri 2 goals
(13, 1, 5), (13, 2, 15), (13, 3, 25), (13, 4, 35), (13, 5, 45), (13, 6, 55), -- Mbappe 6 goals
(14, 1, 60), (14, 2, 70), (14, 3, 80), (14, 4, 90), -- Vinicius 4 goals
(15, 2, 33), (15, 3, 44),             -- Bellingham 2 goals
(16, 1, 22), (16, 2, 33), (16, 3, 44), -- Griezmann 3 goals
(17, 1, 11), (17, 2, 22), (17, 3, 33); -- Morata 3 goals  <- tied for 3rd in La Liga

-- Step 8: Run the DENSE_RANK query
SELECT league, name, goals, rnk
FROM (
    SELECT t.league, p.name,
           COUNT(g.goal_id) AS goals,
           DENSE_RANK() OVER (
               PARTITION BY t.league
               ORDER BY COUNT(g.goal_id) DESC
           ) AS rnk
    FROM Players p
    JOIN Teams t      ON p.team_id   = t.team_id
    LEFT JOIN Goals g ON p.player_id = g.player_id
    GROUP BY t.league, p.player_id, p.name
) ranked
WHERE rnk <= 3
ORDER BY league, rnk;