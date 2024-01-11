--- URI Online Judge SQL
--- Copyright URI Online Judge
--- www.urionlinejudge.com.br
--- Problem 2988

CREATE TABLE teams (
    id integer PRIMARY KEY,
    name varchar(50)
);

GRANT SELECT ON teams TO sql_user;

CREATE TABLE matches  (
    id integer PRIMARY KEY,
    team_1 integer,
    team_2 integer,
    team_1_goals integer,
    team_2_goals integer,
    FOREIGN KEY (team_1) REFERENCES teams(id),
    FOREIGN KEY (team_2) REFERENCES teams(id)
);

GRANT SELECT ON matches TO sql_user;insert into teams
    (id, name)
values
    (1,'CEARA'),
    (2,'FORTALEZA'),
    (3,'GUARANY DE SOBRAL'),
    (4,'FLORESTA');

insert into  matches
    (id, team_1, team_2, team_1_goals, team_2_goals)
values
    (1,4,1,0,4),
    (2,3,2,0,1),
    (3,1,3,3,0),
    (4,3,4,0,1),
    (5,1,2,0,0),
    (6,2,4,2,1);

/* Execute this query to drop the table */
-- DROP TABLE matches;

-- RESPOSTA --

SELECT
    t.name,
    count(1) AS matches,
    SUM(R.VICTORIES) AS victories,
    SUM(R.DEFEATS) AS defeats,
    SUM(R.DRAWS) AS draws,
    SUM(R.SCORE) AS score
FROM(

    SELECT
        team_1 as team_id,
        team_1_goals as gols,
        CASE WHEN team_1_goals > team_2_goals THEN 1 ELSE 0 END AS VICTORIES,
        CASE WHEN team_1_goals < team_2_goals THEN 1 ELSE 0 END AS DEFEATS,
        CASE WHEN team_1_goals = team_2_goals THEN 1 ELSE 0 END AS DRAWS,
        CASE
            WHEN TEAM_1_GOALS > TEAM_2_GOALS THEN 3
            WHEN TEAM_1_GOALS < TEAM_2_GOALS THEN 0
            WHEN TEAM_1_GOALS = TEAM_2_GOALS THEN 1
            ELSE 0
        END AS SCORE        
    FROM
        matches 
        
    UNION ALL
    
    SELECT
        team_2 as team_id,
        team_2_goals as gols,
        CASE WHEN team_2_goals > team_1_goals THEN 1 ELSE 0 END AS VICTORIES,
        CASE WHEN team_2_goals < team_1_goals THEN 1 ELSE 0 END AS DEFEATS,
        CASE WHEN team_2_goals = team_1_goals THEN 1 ELSE 0 END AS DRAWS,
        CASE
            WHEN TEAM_2_GOALS > TEAM_1_GOALS THEN 3
            WHEN TEAM_2_GOALS < TEAM_1_GOALS THEN 0
            WHEN TEAM_2_GOALS = TEAM_1_GOALS THEN 1
            ELSE 0
        END AS SCORE        
    FROM
    matches 
) AS R
INNER JOIN teams t ON t.id = R.team_id
GROUP BY t.name
ORDER BY score DESC;
