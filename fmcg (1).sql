select *
from fmcg


alter table fmcg
add column territories varchar

update fmcg
set territories= case
                     when countries='Nigeria'then 'anglophone'
                     when countries='Ghana'then 'anglophone'
                     else 'francophone' 
              
			     end
     

--------1. Within the space of the last three years, what was the profit worth of the breweries, inclusive of the anglophone and the francophone territories?            
select years,brands, territories,sum(profit) as profit_sales
from fmcg
group by years,brands,territories
order by years 


  
----------2. Compare the total profit between these two territories in order for the territory manager, Mr. Stone made a strategic decision that will aid profit maximization in 2020. 
select  territories,sum(profit) as profit_sales
from fmcg
group by territories
order by profit_sales


------3. Country that generated the highest profit in 2019  
select countries, sum(profit) 
from fmcg
where years= '2019'
group by countries
order by sum(profit) desc
limit 1


-----4. Help him find the year with the highest profit.  
select years ,sum(profit)
from fmcg
group by years
order by sum(profit) desc
limit 1


-----5. Which month in the three years was the least profit generated?  

select month,years,sum(profit)
from fmcg
group by month,years
order by sum(profit)
limit 1



-------6. What was the minimum profit in the month of December 2018?  
select month,years,profit
from fmcg
where month ='December'and years='2018'
group by month,years, profit
order by profit 
limit 1


----7. Compare the profit in percentage for each of the month in 2019  

select month, sum(profit) as monthly_profit,round(SUM(profit) * 100.0 / 
(select sum(profit) from fmcg where years = '2019'), 2) AS monthly_profit_percentage
from fmcg
where years = '2019'
group by month
order by monthly_profit_percentage desc

------8. Which particular brand generated the highest profit in Senegal? 

select brands,sum(profit)
from fmcg
where countries = 'Senegal'
group by brands
order by sum(profit) desc
limit 1



-------9. Calculate profit over the month. 

select month,sum(profit)
from fmcg
group by month 
order by sum(profit) desc



-------10. Within the last two years, the brand manager wants to know the top three brands consumed in the francophone countries. 
select  brands, sum(quantity) as most_consumed
from fmcg
where  years in ('2018','2019') and territories='francophone'
group by  brands
order by sum(quantity) desc
limit 3



-----11. Find out the top two choice of consumer brands in Ghana

select brands,sum(quantity)
from fmcg
where countries ='Ghana'
group by brands
order by sum(quantity) desc
limit 2



-----12. Find out the details of beers consumed in the past three years in the most oil reached country in West Africa.(Nigeria)
---- beer = ('trophy','budweiser','castle lite', 'eagle lager','hero') 
select years,brands, plant_cost,unit_price,sum(quantity)as quantity,sum(cost)as cost,sum(profit)as profit
from fmcg
where countries='Nigeria' and brands  in  ('trophy','budweiser','castle lite', 'eagle lager','hero') 
group by years,brands,unit_price,plant_cost
order by years


-------- 13. Favorites malt brand in Anglophone region between 2018 and 2019.  
--------malt brand =('beta malt','grand malt')
select  territories, sum(quantity),brands
from fmcg
where territories='anglophone' and brands in ('beta malt','grand malt') and years in ('2018','2019')
group by territories,brands
order by sum(quantity) desc



----14. Which brands sold the highest in 2019 in Nigeria?  

select brands,sum(quantity)as favorite
from fmcg
where countries='Nigeria' and years='2019'
group by brands
order by sum(quantity) desc
limit 1


--------15. Favorites brand in South-South region in Nigeria. 
select brands,region,sum(quantity)
from fmcg
where region= 'southsouth'
group by brands,region
order by sum(quantity) desc
limit 1



--------16. Beer consumption in Nigeria. 
select  countries,sum(quantity)as bear_consumption
from fmcg
where countries='Nigeria' and brands  in  ('trophy','budweiser','castle lite', 'eagle lager','hero') 
group by countries


----17. Level of consumption of Budweiser in the regions in Nigeria . 

select region,sum(quantity) as consumption_level
from fmcg
where countries='Nigeria'and brands='budweiser'
group by region
order by consumption_level desc



------18. Level of consumption of Budweiser in the regions in Nigeria in 2019 (Decision on Promo) .  

select years,region,sum(quantity) as consumption_level
from fmcg
where countries='Nigeria'and brands='budweiser' and years='2019'
group by region,years
order by consumption_level desc



------19. Country with the highest consumption of beer.  

select countries,sum(quantity) as highest_beer_comsumer
from fmcg
where brands  in  ('trophy','budweiser','castle lite', 'eagle lager','hero') 
group by countries
order by highest_beer_comsumer desc
limit 1




--20. Highest sales personnel of Budweiser in Senegal  

select sales_rep, count(sales_rep)* sum(quantity) as sales
from fmcg
where brands ='budweiser' and countries= 'Senegal'
group by sales_rep
order by count(sales_rep) desc
limit 1




------21. Country with the highest profit of the fourth quarter in 2019
---forth quarter= ('December','November','October','September')
select countries,sum(profit) as highest_profit
from fmcg
where month in ('December','November','October','September') and years='2019'
group by countries
order by highest_profit desc
limit 1