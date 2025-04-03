-- 1. Find the movie with highest profit (vs order by)
SELECT * 
FROM sub_query.movies
WHERE (gross - budget) = (SELECT MAX(gross - budget) 
FROM movies);

-- 2. Find how many movies have a rating > the avg of all the movies ratings.
-- (Find the count of above average movies).

SELECT COUNT(*)
FROM movies 
WHERE score > (SELECT AVG(score) FROM movies);

-- 3. Find the highest rated movies of 2000.
SELECT * FROM movies
WHERE year = 2000 AND score = ( SELECT MAX(score) 
								FROM sub_query.movies 
                                WHERE year = 2000);

-- 4. Find the highest rated movies among all whose number of votes are > the dataset avg votes.

SELECT * FROM movies
WHERE score = (SELECT MAX(scores) FROM movies 
				WHERE votes > (SELECT AVG(votes) 
                FROM movies));
				
-- Every inner query gives scalary value. 

-- Independent SubQuery - Row SubQuery (One Col Multiple rows)
-- USE zomato

-- 1. Find all users who never ordered.
SELECT * FROM users
WHERE user_id NOT IN (SELECT DISTINCT(user_id) FROM orders);

-- 2. Find all the movies made by the 3 directors (in terms of total gross income)
-- USE sub_query
WITH top_directors AS (
	SELECT director
	FROM movies
	GROUP BY director
	ORDER BY SUM(gross) 
    DESC LIMIT 3
)
SELECT * FROM movies
WHERE director IN (SELECT * FROM top_directors);

-- 3. Find all movies of all those actors whose filmography's avg rating > 8.5 
-- (take 25000 votes as cutoff).

SELECT * FROM movies 
WHERE star IN (
	SELECT star
	FROM movies
	WHERE votes > 25000
	GROUP BY star
	HAVING AVG(score) > 8.5
);

-- Independent Subquery - Table Subquery (Multicol MultiRow)
-- 1. Find the most profitable movie of each year.
-- SELECT * FROM movies
-- WHERE (
-- 	year, gross-budget
-- ) IN (
-- 	SELECT year, MAX(gross-budget)
-- 	FROM movies
-- 	GROUP BY year
-- );

-- 2. Find the highest rated movie of each votes cutoff of 25000.
SELECT * FROM movies
WHERE (genre, score) IN (
	SELECT genre,
	MAX(score)
	FROM movies
	WHERE votes > 25000
);

-- 3. Find the highest grossing movies of top 5 actor/director combo in term of total gross income.
WITH top_duos AS (
	SELECT star, director, MAX(gross)
	FROM movies
	GROUP BY star, director
	ORDER BY SUM(gross) DESC LIMIT 5
)
SELECT * FROM movies
WHERE (star, director, gross) IN (SELECT * FROM top_duos);


-- Correlated Sub-query : Outer query depends on the inner query.
-- 1. Find all the movies that have a rating higher than the average rating of movies in the 
-- same genre.

SELECT * FROM movies m1
WHERE score > (
	SELECT AVG(score) FROM movies m2
	WHERE m2.genre = m1.genre
);


-- 2. Find the favorite food of each customer. 
WITH fav_food AS (
	SELECT name, f_name, COUNT(*) AS 'frequency'
	FROM users t1 JOIN orders t2 ON t1.user_id = t2.user_id
	JOIN order_details t3  ON t2.order_id = t3.order_id
	JOIN food t4 ON t3.f_id = t4.f_id
	GROUP BY t2.user_id, t3.f_id
)
SELECT * FROM fav_food f1
WHERE frequency = (SELECT MAX(frequency)
					FROM fav_food f2
					WHERE f2.user_id = f1.user_id)



