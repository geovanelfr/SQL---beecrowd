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
    s.u1_name,
    s.u2_name
FROM (
    SELECT
        CASE WHEN u1.posts <= u2.posts THEN u1.user_name ELSE u2.user_name END AS u1_name,
        CASE WHEN u1.posts <= u2.posts THEN u1.user_id ELSE u2.user_id END AS u1_id,
        CASE WHEN u1.posts <= u2.posts THEN u2.user_name ELSE u1.user_name END AS u2_name,
        CASE WHEN u1.posts <= u2.posts THEN u2.user_id ELSE u1.user_id END AS u2_id
    FROM
        followers f1
    JOIN
        followers f2 ON f1.user_id_fk = f2.following_user_id_fk
        AND f1.following_user_id_fk = f2.user_id_fk
    JOIN
        users u1 ON f1.user_id_fk = u1.user_id
    JOIN
        users u2 ON f1.following_user_id_fk = u2.user_id
    WHERE
        u1.user_id < u2.user_id
) AS s
ORDER BY
    s.u1_id;
