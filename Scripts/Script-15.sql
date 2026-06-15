CREATE TABLE easy.bonuses (
  bonus_id     INT,
  player_id    INT,
  bonus_amount INT
);

INSERT INTO easy.bonuses VALUES
(1, 1, 5000),
(2, 2, 15000),
(3, 3, 8000);

-- Q14: Players with bonus under 10k OR no bonus at all (LEFT JOIN + NULL filter)
SELECT p.name, b.bonus_amount
FROM easy.players p
LEFT JOIN easy.bonuses b ON p.player_id = b.player_id
WHERE b.bonus_amount < 10000 OR b.bonus_amount IS NULL;

SELECT p.name, COALESCE(b.bonus_amount, 0) AS bonus_amount
FROM easy.players p
LEFT JOIN easy.bonuses b ON p.player_id = b.player_id
WHERE COALESCE(b.bonus_amount, 0) < 10000;