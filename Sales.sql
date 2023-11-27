Select *
From [dbo].[Sales ]

sp_rename '[dbo].[Sales ].Order ID', 'Order_id', 'COLUMN';
sp_rename '[dbo].[Sales ].Quantity Ordered', 'Quantity_Ordered', 'COLUMN';
sp_rename '[dbo].[Sales ].Price Each', 'Price_Each', 'COLUMN';
sp_rename '[dbo].[Sales ].Order Date', 'Order_Date', 'COLUMN';
sp_rename '[dbo].[Sales ].Purchase Address', 'Purchase_Address', 'COLUMN';

Update [dbo].[Sales ]
SET Order_Date = Convert (Date,Order_Date)

Alter Table [dbo].[Sales ]
Add OrderDateConverted Date;

Update [dbo].[Sales ]
SET OrderDateConverted = Convert (date,Order_Date)

Alter table [dbo].[Sales ]
drop column Order_Date;

-- Calculating TotalOrders/Cities/Products

Select Count(Distinct Order_id) As Total_Orders,
Count (Distinct City) As Total_Cities,
Count (Distinct Product) As Total_Products
from [dbo].[Sales ]


-- Calculating Total Orders in each City

Select city,Count(Distinct Order_id) As TotalOrdersbyCities,
Count(*)*100/Sum (count(*))Over() As TotalOrdersbyCitiesPercent
from [dbo].[Sales ]
group by city
Order by TotalOrdersbyCities DESC

-- Calculating Total Sales in each city

Select city,Sum(Sales) As TotalSales,
Count(*)*100/Sum (count(*))Over() As TotalSalesPercent
from [dbo].[Sales ]
group by city
Order by TotalSales DESC


-- Calculating Total Sales and Total Orders each month
select CASE
	WHEN Month = 1 THEN 'January'
	WHEN Month = 2 THEN 'February'
	WHEN Month = 3 THEN 'March'
	WHEN Month = 4 THEN 'April'
	WHEN Month = 5 THEN 'May'
	WHEN Month = 6 THEN 'June'
    WHEN Month = 7 THEN 'July'
	WHEN Month = 8 THEN 'August'
    WHEN Month = 9 THEN 'September'
	WHEN Month = 10 THEN 'October'
    WHEN Month = 11 THEN 'November'
	WHEN Month = 12 THEN 'December'
   ELSE 'Undefined' END As MonthName, 
sum(Sales) AS TotalSales, 
count(distinct(order_id)) AS TotalOrders
FROM [dbo].[Sales ]
group by Month
Order by TotalOrders DESC

-- Calculating Total Sales and Total Quantities Sold by Day

select OrderDateConverted,
sum(Sales) AS TotalSales, 
sum(Quantity_ordered) AS TotalQuantitySold
FROM [dbo].[Sales ]
group by OrderDateConverted
Order by  TotalSales Desc

--Calculating Total Sales and Total Quantities Ordered for Each Product

Select Product,
Sum (sales) As Totalsales,
Sum(Quantity_Ordered) As TotalQuantityOrdered
From  [dbo].[Sales ]
Group by Product,Sales
Order By Totalsales Desc

-- Calculating The Most Expensive Products

Select Top 5 Product, Max(Price_Each) As MaxPriceProducts
from [dbo].[Sales ]
Group by product
Order by MaxPriceProducts DESC

-- Calculating The Cheapest Products

Select Top 5 Product, MIN(Price_Each) As MinPriceProducts
from [dbo].[Sales ]
Group by product
Order by MinPriceProducts ASC







