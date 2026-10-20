CREATE DATABASE SUPERSTORE;
USE SUPERSTORE;
alter table order_file2
modify Ship_date DATE;
alter table order_file2
modify discount DECIMAL(10,2);
select*from order_file2 limit 5;
-- total sales
select sum(sales) as total_sales
from order_file2;
-- top 5 higest selling products 
select product_id,sum(sales) as total_sales
from order_file2
group by product_id
order by total_sales desc
limit 5;
-- kis region me sabse jada profit hai
select region,sum(profit) as total_profit
from order_file2
group by region
order by total_profit desc
limit 1;
-- negative profit (loss)
select *from order_file2
where profit <0;

-- TOP CUSTOMERS BY REVENUE
select customer_name ,sum(sales) as total_sales
from order_file2
group by customer_name
order by total_sales desc limit 10;
-- category wise performance
select category, sum(sales) as total_sales,
sum(profit) as total_profit from order_file2
group by category;
 -- what is the impact of discount on profit 
 select discount, ROUND(AVG(profit),2) as avg_profit
 FROM order_file2
 group by discount
 order by discount;
-- SABSE JADA QUANTITY KIS PRODUCT KI BIKTI HAI 
SELECT product_id ,sum(quantity) as total_qty
from order_file2
group by product_id
order by total_qty desc
limit 5;
-- country-wise sales ranking 
select country, sum(sales) as total_sales,
rank() over(order by sum(sales) desc) as rank_no
from order_file2
group by country;
-- running total of sales 
select order_date,sum(sales) as daily_sales,
sum(sum(sales))
over(order by order_date) as running_total
from order_file2
group by order_date;
-- repeat vs new customers 
select customer_name, count(order_id) as total_orders
from order_file2
group by customer_name
having total_orders >1;
-- profit ratio (profit/sales)
select category,sum(profit)/sum(sales) as profit_ratio
from order_file2
group by category ;

-- most profitable sub-category in each region 
select *from(
select region, sub_category,
sum(profit) as total_profit,
rank() over (partition by region
order by sum(profit) desc) as rnk
from order_file2
group by region,sub_category) t
where rnk =1;
