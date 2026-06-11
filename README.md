# SqlTables 📊

A collection of daily SQL practice problems, solutions, and notes. Topics range from basic queries to advanced window functions.

---

## 👤 Author
**Nathan St. Amand**
- GitHub: [stamandmnathan](https://github.com/stamandmnathan)
- LinkedIn: [Nathan St. Amand](https://www.linkedin.com/in/nathan-st-amand-071337327/)

---

## 📁 Folder Structure

```
daily-sql/
├── README.md
├── window-functions/       # RANK, DENSE_RANK, ROW_NUMBER, etc.
├── joins/                  # INNER, LEFT, RIGHT, FULL joins
├── subqueries/             # Nested queries and CTEs
├── aggregations/           # GROUP BY, HAVING, COUNT, SUM, etc.
├── tables/                 # CREATE TABLE practice
└── challenges/             # Mixed difficulty problems
```

---

## 🧠 Topics Covered

| Topic | Description |
|-------|-------------|
| Window Functions | `RANK()`, `DENSE_RANK()`, `ROW_NUMBER()`, `PARTITION BY` |
| Joins | Combining tables with various join types |
| Subqueries | Nested queries and filtering with subqueries |
| Aggregations | Grouping and summarizing data |
| Table Creation | `CREATE TABLE`, primary keys, data types |
| Challenges | Real-world style SQL problems |

---

## 🗂️ Example Problems

### Window Functions
```sql
-- Rank players by goals within each team
SELECT p.name,
       p.team_id,
       COUNT(g.goal_id) AS goals,
       RANK() OVER (
           PARTITION BY p.team_id
           ORDER BY COUNT(g.goal_id) DESC
       ) AS team_rank
FROM Players p
LEFT JOIN Goals g ON p.player_id = g.player_id
GROUP BY p.player_id, p.name, p.team_id;
```

### Table Creation
```sql
-- Create a Podcast table
CREATE TABLE Podcast (
    Id          INT PRIMARY KEY AUTO_INCREMENT,
    PodcastName VARCHAR(255),
    AuthorName  VARCHAR(255)
);
```

---

## 🚀 How to Use

1. Clone the repo:
   ```bash
   git clone https://github.com/stamandmnathan/daily-sql.git
   ```
2. Browse folders by topic
3. Open `.sql` files in DBeaver, MySQL Workbench, or any SQL editor

---

## 📅 Goal
Practice at least one SQL problem per day to build consistency and prepare for technical interviews.

---

*Updated regularly — feel free to follow along!*
