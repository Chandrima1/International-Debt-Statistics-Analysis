/* 1. */
create table public.international_debt
(
  country_name varchar(100),
  country_code varchar(100),
  indicator_name varchar(100),
  indicator_code varchar(100),
  debt decimal(150)
);
select * from international_debt;
copy public.international_debt from 'C:\Users\prama\Downloads\international_debt.csv' delimiter ',' csv header;

/*2. total number of distinct countries */

select 
count(distinct country_name) as total_distinct_countries
from international_debt;

/*3. distinct debt indicators */

select 
distinct indicator_code as distinct_debt_indicator 
from international_debt 
order by distinct_debt_indicator;

/*4. total debt owned by the countries */

select 
Round (sum(debt)/1000000, 2) from international_debt as total_debt;
/* in millions*/

/* 5. country with the highest debt */

select  sum(debt) as total_debt from international_debt 
group by country_name
order by total_debt DESC;

/* 6. indicator wise avg amount of debt */

select indicator_name, indicator_code, avg(debt) as Avg_debt
from international_debt
group by indicator_name, indicator_code
order by Avg_debt desc;

/*7.  highest amount of principal repayments */

select indicator_name,country_name, debt
from international_debt 
where debt = (
SELECT 
MAX(debt)
FROM international_debt
WHERE indicator_code ='DT.AMT.DLXF.CD');

SELECT 
                 indicator_code,country_name,MAX(debt) as max_debt
             FROM international_debt
             WHERE indicator_code ='DT.AMT.DLXF.CD'
			 group by country_name, indicator_code
			 order by max_debt desc ;

/* 8. the most common debt indicator */

select indicator_code, count(indicator_code) as indicator_count
from international_debt
group by indicator_code
order by indicator_count desc;

/*9. other debt issues and conclusion */

select indicator_code, country_name, max(debt) as max_debt
from international_debt
group by indicator_code, country_name
order by max_debt desc;