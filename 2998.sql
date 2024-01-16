--- URI Online Judge SQL
--- Copyright URI Online Judge
--- www.urionlinejudge.com.br
--- Problem 2998

CREATE TABLE clients (
    id integer PRIMARY KEY,
    name varchar(50),
    investment numeric
);


CREATE TABLE operations (
    id integer PRIMARY KEY,
    client_id integer,
    month integer,
    profit numeric,
    FOREIGN KEY (client_id) REFERENCES clients(id)
);

insert into clients (id,name,investment) values
(1,'Daniel',500),
(2,'Oliveira',2000),
(3,'Lucas',1000);


INSERT INTO operations (id, client_id, month, profit) VALUES
(1,1,1,230),
(2,2,1,1000),
(3,2,2,1000),
(4,3,1,100),
(5,3,2,300),
(6,3,3,900),
(7,3,4,400);

/*  Execute this query to drop the tables */
-- DROP TABLE operations;
-- DROP TABLE clients;

-- RESPOSTA --

SELECT
  c.name,
  c.investment,
  MIN(o.month) AS month_of_payback,
  CASE WHEN SUM(o.profit) >= c.investment THEN SUM(o.profit) - c.investment ELSE 0 END AS return
FROM
  clients c
JOIN
  operations o ON c.id = o.client_id
WHERE
  c.investment <= (
    SELECT COALESCE(SUM(profit), 0)
    FROM operations
    WHERE client_id = c.id AND month <= o.month
  )
GROUP BY
  c.id, c.name, c.investment
ORDER BY
  return DESC