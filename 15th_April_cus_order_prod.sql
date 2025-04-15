USE SQL_PRACTICE;

select * from customers;
select * from orders;
select * from products;

-- 1. Find the total quantity of each product sold.
select t2.product_id, sum(t1.quantity) as 'total_quantity_sold'
from orders t1
join products t2
on t1.product_id = t2.product_id
group by product_id
order by total_quantity_sold DESC LIMIT 5;

-- 2. List the top 5 countries with the highest number of orders.
select c1.country, SUM(o1.quantity), COUNT(o1.order_id)
from orders o1
right join customers c1
on c1.customer_id = o1.customer_id
group by c1.country
order by SUM(o1.quantity) desc limit 5
