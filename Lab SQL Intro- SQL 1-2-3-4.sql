-- 1. 
-- Use sakila database
use sakila;

-- 2.
-- Get all the data from tables actor, film and customer.
select * from actor;
 
select * from film;

select * from customer;

-- 3. 
-- Get film titles.
select title from sakila.film;

-- 4
 /* Get unique list of film languages under the alias language. Note that we are not asking you to obtain the language per each film, 
-- but this is a good time to think about how you might get that information in the future.*/
select distinct name as language from sakila.language;

-- or in one row
select group_concat(distinct name) as language from language;

-- 5
-- 5.1 Find out how many stores does the company have?
select count(distinct store_id) as "quantity of stores" from sakila.store; 
-- or
select count(store_id) as "quantity of stores" from sakila.store; 

-- 5.2 
-- Find out how many employees staff does the company have?
select count(staff_id) as "quantity of employees" from sakila.staff;

-- 5.3 
-- Return a list of employee first names only?
select first_name from staff where staff_id in (select distinct staff_id from staff);
-- or
select first_name from sakila.staff



-- Lab | SQL Queries 2

-- 1.
-- Select all the actors with the first name ‘Scarlett’.
select *
from sakila.actor
where first_name = 'Scarlett';

-- 2.
-- Select all the actors with the last name ‘Johansson’.
select *
from sakila.actor
where last_name = 'Johansson'; 

-- 3. 
-- How many films (movies) are available for rent?
-- just checking the number of rows in the table 
select count(return_date) as available 
from sakila.rental;

-- 4. 
-- How many films have been rented?
select sum(case when return_date is null then 1 else 0 end) as 'rented'
from sakila.rental;

-- or for both last questions 3 and 4
select sum(case when return_date is null then 1 else 0 end) as 'rented',
count(return_date) as 'returned-available'
from sakila.rental;

-- 5.
-- What is the shortest and longest rental period?

SELECT min(rental_duration) as sortest_rental_period, max(rental_duration) as longest_rental_period from sakila.film;

/*SELECT rental_date, return_date FROM sakila.rental, 
DATEDIFF (return_date, rental_date) AS date_difference 
where date_difference > 10 order by date_difference asc;


select date_format(convert(rental_date,date), '%Y-%M-%D') as rental_date,
date_format(convert(return_date,date), '%Y-%M-%D') as return_date,
date_format(rental_date, '%Y') as year_of_rental_date,
date_format(return_date, '%Y') as year_of_return_date,
-- (year_of_return_date)-(year_of_rental_date) as year_difference,
rental_date-return_date as rental_period
order by rental_period desc,
from sakila.rental;*/

-- 6.
-- What are the shortest and longest movie duration? Name the values max_duration and min_duration.
select max(length) as max_duration,
min(length) as min_duration
from sakila.film;

-- 7. 
-- What's the average movie duration?
select avg(length)
from sakila.film;

-- 8.
-- What's the average movie duration expressed in format (hours, minutes)?
select floor(avg(length)/60) as hours,
avg(length)%60 as minutes
from sakila.film;
-- or
select date_format(sec_to_time(avg(length)*60), '%H:%i') as average_movie_duration
from sakila.film;

-- 9.
-- How many movies longer than 3 hours?
select count(length) from sakila.film 
where length > 180;

-- 10.
-- Get the name and email formatted. Example: Mary SMITH - mary.smith@sakilacustomer.org.
select concat(lower(first_name),'.',lower(last_name), '@sakilacustomer.org') as 'concat' 
from sakila.customer;
-- or
select *, lower(email)
from sakila.customer;

-- 11.
-- What's the length of the longest film title?

-- if the question is about the longest duration of the film then: 
select * from sakila.film
order by length desc
limit 1;
select 'the length of the longest film title is 185 minutes';
-- or
select concat('the length of the longest film title is:', max(length), ' minutes') as the_length_of_the_longest_film_title
from sakila.film;

-- if the question is about the longest film according to the number of letters then: 
select max(length(title)) from sakila.film;
select title from sakila.film
where length(title)=27;


-- Lab | SQL Queries 3


-- 1. 
-- How many distinct (different) actors' last names are there?
select count(distinct last_name) as "quantity of distinct_actors" from sakila.actor; 

-- 2.
-- In how many different languages where the films originally produced? (Use the column language_id from the film table)
select count(distinct language_id) as "quantity of different_languages" from sakila.film; 

-- 3.
-- How many movies were released with "PG-13" rating?
select count(rating) as number_of_rating_PG_13
from sakila.film
where rating = 'PG-13';

-- 4.
-- Get 10 the longest movies from 2006.
select title, length, release_year
from sakila.film
where release_year = 2006
order by length desc 
limit 10;

-- 5.
-- How many days has been the company operating (check DATEDIFF() function)?
select datediff(max(last_update), min(rental_date)) as operating_days
from sakila.rental;

-- 6.
-- Show rental info with additional columns month and weekday. Get 20.
select *, date_format(rental_date, '%M') as 'month',
date_format(rental_date, '%W') as 'weekday' from sakila.rental
limit 20;

-- 7.
-- Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
select * , date_format(rental_date, '%M') as 'month',
date_format(rental_date, '%W') as 'weekday',
case
when date_format(rental_date, '%W') > 5 then 'weekend' else 'workday' end as day_type
from sakila.rental;
-- or
select * , date_format(rental_date, '%M') as 'month',
date_format(rental_date, '%W') as 'weekday',
case
when date_format(rental_date, '%W') = 'Monday'='Tuesday'='Wednesday'='Thursday'='Friday' then 'weekend' else 'workday' end as day_type
from sakila.rental;

-- 8.
-- How many rentals were in the last month of activity?
select max(rental_date) from sakila.rental;
select count(rental_date), date_format(rental_date, '%M') as 'month',  date_format(rental_date, '%Y') as 'year' from sakila.rental
where  date_format(rental_date, '%M') = 'February' and date_format(rental_date, '%Y')=2006;

-- Lab | SQL Queries 4

-- 1.
-- Get film ratings.
select title, rating from sakila.film; 

-- 2.
-- Get release years.
select title, release_year from sakila.film;
-- or
select concat('the release year of the film with title ', title, ' is ', release_year) 
from sakila.film;

-- 3. 
-- Get all films with ARMAGEDDON in the title.
select * 
from sakila.film
where title like '%ARMAGEDDON%';
-- or
select title
from sakila.film
where title like '%ARMAGEDDON%';

-- 4.
-- Get all films with APOLLO in the title
select * 
from sakila.film
where title like '%APOLLO%';

-- 5.
-- Get all films which title ends with APOLLO.
select * 
from sakila.film
where title like '%APOLLO';

-- 6.
-- Get all films with word DATE in the title.
select * 
from sakila.film
where title like '%DATE%';
-- or
select * 
from sakila.film
where title regexp 'DATE';

-- 7.
-- Get 10 films with the longest title.
select title, length(title) from sakila.film
order by length(title) desc
limit 10;
-- or
select title, length(title) from sakila.film
where length(title)>21 
order by length(title) desc
limit 10;

-- 8.
-- Get 10 the longest films.
select title, length from sakila.film
order by length desc
limit 10;

-- 9.
-- How many films include Behind the Scenes content?
select count(title) from sakila.film
where special_features regexp 'Behind the Scenes';
	
-- 10.
-- List films ordered by release year and title in alphabetical order.
select release_year, title from sakila.film
order by release_year, title asc;
-- or
select release_year, title from sakila.film
group by title;