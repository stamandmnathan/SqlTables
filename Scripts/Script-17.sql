-- Create appearances table with mock data
CREATE TABLE easy.appearances (
  appearance_id INT,
  player_id     INT,
  match_id      INT
);

INSERT INTO easy.appearances VALUES
(1, 1, 1), (2, 1, 2), (3, 1, 3),
(4, 2, 1), (5, 2, 2), (6, 2, 3),
(7, 3, 1), (8, 3, 2);

-- Q16: Player(s) with most appearances — tie-safe using HAVING >= subquery
SELECT player_id
FROM easy.appearances
GROUP BY player_id
HAVING COUNT(*) >= (
  SELECT COUNT(*) AS cnt
  FROM easy.appearances
  GROUP BY player_id
  ORDER BY cnt DESC
  LIMIT 1
);

-- RANK() alternative — also tie-safe
SELECT player_id
FROM (
  SELECT player_id,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
  FROM easy.appearances
  GROUP BY player_id
) t
WHERE rnk = 1;

-- LIMIT 1 alone (WRONG — picks one arbitrarily if tied)
SELECT player_id
FROM easy.appearances
