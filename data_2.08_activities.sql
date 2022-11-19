-- Activity 1
use bank;
select * from district;
-- In this activity, we will be using the table district from the bank database and according to the description for the different columns:

-- A4: no. of inhabitants
-- A9: no. of cities
-- A10: the ratio of urban inhabitants
-- A11: average salary
-- A12: the unemployment rate

-- Rank districts by different variables.
select d.A3, d.A2, d.A4,
rank() over(partition by A3 order by A4) as 'rank'
from district d;

-- Do the same but group by region.
select A3,A2, A4
from district
group by A3, A2, A4;


-- -------------------------

-- Activity 2

-- Use the transactions table in the bank database to find the Top 20 account_ids based on the amount.
select * from trans;
select trans_id, type, amount,
rank() over(partition by type order by amount desc) as ranking
from trans;

-- With dense_rank():
select * from trans;
select trans_id, type, amount,
rank() over(partition by type order by amount desc) as ranking,
dense_rank() over(partition by type order by amount desc) as dense_ranking
from trans;

-- Illustrate the difference between rank() and dense_rank().
-- rank(), in case of ties, returns the same result as the row_number() when the position changes, while
-- dense_rank() doesn't skip numbers.

-- ----------------------------

-- Activity 3

-- Get a rank of districts ordered by the number of customers.
select * from district;
select * from client;

select dense_rank() over(order by count(client_id)) as ranking,
d.district_id, count(c.client_id) as client_count
from client c
join district d on c.district_id = d.A1
group by district_id;

-- Get a rank of regions ordered by the number of customers.
select dense_rank() over(order by count(client_id)) as ranking,
d.A3, count(c.client_id) as client_count
from client c
join district d on c.district_id = d.A1;
-- group by d.A3;

-- Get the total amount borrowed by the district together with the average loan in that district.
select* from loan;
select * from account;
select * from district;

select dense_rank() over (order by d.A2) as dense_rnk,
d.A2, sum(l.amount) as total_loan, avg(l.amount) as avg_amount
from loan l
join account a on l.account_id = a.account_id
join district d on a.district_id = d.A1
group by d.A2;

-- Get the number of accounts opened by district and year.
select dense_rank() over(order by d.A2, substring(a.date, 1, 2) desc) as dense_rnk, 
substring(a.date, 1, 2) as year, d.A2
from account a
join district d on a.district_id = d.A1
order by year, d.A2;












