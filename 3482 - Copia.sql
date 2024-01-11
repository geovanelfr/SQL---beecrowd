--- URI Online Judge SQL
--- Copyright URI Online Judge
--- www.urionlinejudge.com.br
--- Problem 3482

CREATE TABLE users (
  user_id numeric PRIMARY KEY,
  user_name varchar(50),
  posts numeric
);


CREATE TABLE followers (
  follower_id numeric PRIMARY KEY,
  user_id_fk numeric,
  following_user_id_fk numeric,
  FOREIGN KEY (user_id_fk) REFERENCES users(user_id),
  FOREIGN KEY (following_user_id_fk) REFERENCES users(user_id)
);


INSERT INTO users
VALUES
  (1, 'Francisco', 23),
  (2, 'Brenda', 51),
  (3, 'Helena', 12),
  (4, 'Miguel', 70),
  (5, 'Laura', 55),
  (6, 'Arthur', 2),
  (7, 'Alice', 3);


INSERT INTO followers
VALUES
  (1, 1, 5),
  (2, 2, 4),
  (3, 3, 7),
  (4, 3, 6),
  (5, 4, 2),
  (6, 4, 5),
  (7, 5, 1),
  (8, 5, 3),
  (9, 5, 4),
  (10, 5, 2),
  (11, 7, 3);

  
  /*  Execute this query to drop the tables */
-- DROP TABLE followers;
-- DROP TABLE users;

-- RESPOSTA --

SELECT
	x.u1_name,
    x.u2_name
FROM(
	SELECT
        LEAST(u1.name, u2.name) AS u1_name,
        GREATEST(u1.name, u2.name) AS u2_name
    FROM
        followers f
    JOIN
        users u1 ON f.user_id_fk = u1.user_id
    JOIN
        users u2 ON f.following_user_id_fk = u2.user_id
    WHERE
        EXISTS (
            SELECT 1
            FROM followers f2
            WHERE f2.user_id_fk = f.following_user_id_fk
            AND f2.following_user_id_fk = f.user_id_fk
        )
    ORDER BY
        u1.user_id
)x 
GROUP BY u1_name, u2_name;