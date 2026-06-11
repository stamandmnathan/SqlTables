
-- Step 1: Drop and recreate Players table with position and salary
DROP TABLE IF EXISTS Goals;
DROP TABLE IF EXISTS Players;

-- Step 2: Create Players table with position and salary
CREATE TABLE Players (
    player_id SERIAL PRIMARY KEY,
    name      VARCHAR(255),
    position  VARCHAR(10),
    salary    INT,
    team_id   INT
);

-- Step 3: Insert Players data
INSERT INTO Players (name, position, salary, team_id) VALUES
('Alisson',     'GK',  120000, 1),
('Ederson',     'GK',  115000, 2),
('Van Dijk',    'DEF', 110000, 1),
('Trent',       'DEF',  95000, 1),
('Dias',        'DEF',  90000, 2),
('De Bruyne',   'MID', 130000, 2),
('Salah',       'FWD', 125000, 1),
('Haaland',     'FWD', 120000, 2),
('Saka',        'FWD', 100000, 3),
('Fernandes',   'MID', 105000, 3);

-- Step 4: Run the ROW_NUMBER query
SELECT name, position, salary,
       ROW_NUMBER() OVER (
           PARTITION BY position
           ORDER BY salary DESC
       ) AS position_salary_rank
FROM Players;