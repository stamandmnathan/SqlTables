-- Create a practice table with the right structure
CREATE TABLE easy.players_hierarchy (
  player_id   INT,
  name        VARCHAR(100),
  team_id     INT,
  manager_id  INT,
  salary      INT
);

INSERT INTO easy.players_hierarchy VALUES
(1, 'Rashford',  1, 3, 80000),
(2, 'Fernandes', 1, 3, 90000),
(3, 'Ten Hag',   1, NULL, 85000),
(4, 'Salah',     2, 6, 200000),
(5, 'Nunez',     2, 6, 95000),
(6, 'Slot',      2, NULL, 100000);

-- Q6: Find players who earn more than their manager
SELECT p.name AS player, p.salary AS player_salary,
       m.name AS manager, m.salary AS manager_salary
FROM easy.players_hierarchy AS p
INNER JOIN easy.players_hierarchy AS m ON p.team_id = m.team_id
                                      AND m.player_id = p.manager_id
WHERE p.salary > m.salary;