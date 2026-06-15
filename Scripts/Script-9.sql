-- Create bookings table and insert mock data
CREATE TABLE easy.bookings (
  booking_id INT,
  player_id  INT,
  card_type  VARCHAR(10)
);

INSERT INTO easy.bookings VALUES
(1, 1, 'yellow'),
(2, 2, 'red'),
(3, 1, 'yellow');

-- Q8: Find players who have never received a card (LEFT JOIN anti-join)
SELECT p.name
FROM easy.players p
LEFT JOIN easy.bookings b ON p.player_id = b.player_id
WHERE b.booking_id IS NULL;

-- NOT IN approach (avoid in production — NULL trap)
SELECT name
FROM easy.players
WHERE player_id NOT IN (SELECT player_id FROM easy.bookings);

-- NOT EXISTS approach (also safe, no NULL trap)
SELECT p.name
FROM easy.players p
WHERE NOT EXISTS (
  SELECT 1
  FROM easy.bookings b
  WHERE b.player_id = p.player_id
);