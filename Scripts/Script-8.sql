-- Create a practice table with email
CREATE TABLE easy.players_email (
  player_id INT,
  name      VARCHAR(100),
  email     VARCHAR(100)
);

INSERT INTO easy.players_email VALUES
(1, 'Rashford',  'rashford@mufc.com'),
(2, 'Fernandes', 'fernandes@mufc.com'),
(3, 'Rashford2', 'rashford@mufc.com'),
(4, 'Salah',     'salah@lfc.com'),
(5, 'Salah2',    'salah@lfc.com');

-- Q7: Find duplicate emails
SELECT email
FROM easy.players_email
GROUP BY email
HAVING COUNT(email) > 1;