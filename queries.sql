-- top_10_total_income
select
    e.first_name ||''|| e.last_name as seller,
    count (s.sales_id) as operations,
    round (sum (p.price * s.quantity),0) as income
from employees e 
inner join sales s 
on s.sales_person_id = e.employee_id 
inner join products p 
on p.product_id = s.product_id
group by e.first_name ||''|| e.last_name 
order by income
limit 10;

--lowest_average_income.csv
select
    e.first_name ||''|| e.last_name as seller,
    round (avg(p.price*s.quantity),0) as average_income
from sales s
inner join employees e on e.employee_id = s.sales_person_id 
inner join products p on p.product_id = s.product_id 
group by e.first_name, e.last_name 
having round (avg(p.price*s.quantity),0) < (
    select round(avg(p2.price*s2.quantity),0)
    from sales s2
    inner join products p2 on p2.product_id = s2.product_id
)
order by average_income;

-- day_of_the_week_income
SELECT
    e.first_name || ' ' || e.last_name AS seller,
    TRIM(TO_CHAR(s.sale_date, 'day')) AS day_of_week,
    FLOOR(SUM(s.quantity * p.price)) AS income
FROM sales s
JOIN employees e ON s.sales_person_id = e.employee_id
JOIN products p ON s.product_id = p.product_id
GROUP BY 
    e.first_name, 
    e.last_name, 
    TO_CHAR(s.sale_date, 'day'),
    EXTRACT(dow FROM s.sale_date)
ORDER BY 
    CASE EXTRACT(dow FROM s.sale_date)
        WHEN 1 THEN 1
        WHEN 2 THEN 2
        WHEN 3 THEN 3
        WHEN 4 THEN 4
        WHEN 5 THEN 5
        WHEN 6 THEN 6
        WHEN 0 THEN 7
    END,
    seller;
