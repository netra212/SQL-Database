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
-- 





