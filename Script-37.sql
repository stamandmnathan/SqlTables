/*
 * Q36 (LC 1076) — HAVING >= Scalar Subquery, Top Group with Ties
 * ===============================================================
 * Goal: Return every team that has the largest squad — including all tied
 * teams — without hardcoding any count and without discarding runners-up
 * when multiple clubs share the top headcount.
 *
 * Players holds one row per player with team_id linking them to their club.
 *
 * APPROACH 1 — HAVING >= scalar subquery:
 * The outer query groups Players by team_id and counts rows per team.
 * HAVING COUNT(*) >= (...) then compares each group's count against the
 * value returned by the scalar subquery.  The subquery itself groups the
 * same table by team_id, orders those counts descending, and takes LIMIT 1
 * — producing the single largest squad size as a scalar value.  Using >=
 * rather than = is semantically explicit: any team whose count equals or
 * exceeds the maximum passes the filter.  In practice = and >= produce
 * identical results here because no count can exceed the maximum, but >=
 * communicates intent more clearly and is robust against edge cases such as
 * floating-point comparisons in other contexts.  Ties are handled naturally:
 * both teams return the same COUNT(*), and both satisfy >= the maximum.
 *
 * APPROACH 2 — RANK() window function:
 * Wrapping COUNT(*) in a subquery with RANK() OVER (ORDER BY COUNT(*) DESC)
 * assigns rank 1 to every team tied for the largest count simultaneously.
 * The outer WHERE rnk = 1 then keeps all of them.  Window functions cannot
 * appear directly in HAVING, which is why the ranking must be computed in an
 * inner subquery first.  This approach is generally preferred in production
 * because it makes the tie-handling logic explicit and avoids re-scanning the
 * table for the scalar maximum.
 *
 * Both approaches produce identical output; the choice between them is one of
 * readability and performance preference.  The HAVING >= scalar subquery is
 * the classic interview pattern; RANK() is the modern idiomatic equivalent.
 */

CREATE TABLE IF NOT EXISTS Players (
    player_id INT PRIMARY KEY,
    team_id   INT  NOT NULL,
    name      TEXT NOT NULL
);

INSERT INTO Players (player_id, team_id, name) VALUES
    (1,  1, 'Alice'),
    (2,  1, 'Bob'),
    (3,  1, 'Carol'),   -- team 1: 3 players
    (4,  2, 'Dan'),
    (5,  2, 'Eve'),
    (6,  2, 'Frank'),   -- team 2: 3 players (tied for most)
    (7,  3, 'Grace'),
    (8,  3, 'Hank');    -- team 3: 2 players

-- Approach 1: HAVING >= scalar subquery
SELECT team_id
FROM Players
GROUP BY team_id
HAVING COUNT(*) >= (
    SELECT COUNT(*) AS cnt
    FROM Players
    GROUP BY team_id
    ORDER BY cnt DESC
    LIMIT 1
);

-- Approach 2: RANK() window function
SELECT team_id
FROM (
    SELECT team_id,
           RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
    FROM Players
    GROUP BY team_id
) ranked
WHERE rnk = 1;

DROP TABLE IF EXISTS Players;