create schema superstore;
use superstore;

/*
Task 1: Understanding the data in hand
A. Describe the data in hand in your own words.
	1. cust_dimen: Details of all the customers
		
        Customer_Name (TEXT): Name of the customer
        Province (TEXT): Province of the customer
        Region (TEXT): Region of the customer
        Customer_Segment (TEXT): Segment of the customer
        Cust_id (TEXT): Unique Customer ID
	
    2. market_fact: Details of every order item sold
		
        Ord_id (TEXT): Order ID
        Prod_id (TEXT): Prod ID
        Ship_id (TEXT): Shipment ID
        Cust_id (TEXT): Customer ID
        Sales (DOUBLE): Sales from the Item sold
        Discount (DOUBLE): Discount on the Item sold
        Order_Quantity (INT): Order Quantity of the Item sold
        Profit (DOUBLE): Profit from the Item sold
        Shipping_Cost (DOUBLE): Shipping Cost of the Item sold
        Product_Base_Margin (DOUBLE): Product Base Margin on the Item sold
        
    3. orders_dimen: Details of every order placed
		
        Order_ID (INT): Order ID
        Order_Date (TEXT): Order Date
        Order_Priority (TEXT): Priority of the Order
        Ord_id (TEXT): Unique Order ID
	
    4. prod_dimen: Details of product category and sub category
		
        Product_Category (TEXT): Product Category
        Product_Sub_Category (TEXT): Product Sub Category
        Prod_id (TEXT): Unique Product ID
	
    5. shipping_dimen: Details of shipping of orders
		
        Order_ID (INT): Order ID
        Ship_Mode (TEXT): Shipping Mode
        Ship_Date (TEXT): Shipping Date
        Ship_id (TEXT): Unique Shipment ID
B. Identify and list the Primary Keys and Foreign Keys for this dataset
	(Hint: If a table don’t have Primary Key or Foreign Key, then specifically mention it in your answer.)
	1. cust_dimen
		Primary Key: Cust_id
        Foreign Key: NA
	
    2. market_fact
		Primary Key: NA
        Foreign Key: Ord_id, Prod_id, Ship_id, Cust_id
	
    3. orders_dimen
		Primary Key: Ord_id
        Foreign Key: NA
	
    4. prod_dimen
		Primary Key: Prod_id, Product_Sub_Category
        Foreign Key: NA
	
    5. shipping_dimen
		Primary Key: Ship_id
        Foreign Key: NA
 */
 

-- Task 2--
--- Write a query to display the Customer_Name and Customer Segment using alias name “Customer Name", "Customer Segment ---

select customer_name, customer_segment from cust_dimen;

--- Write a query to find all the details of the customer from the table cust_dimen order by desc.---

select customer_name, cust_id, customer_segment, province, region 
from cust_dimen
order by cust_id desc;

---- Write a query to get the Order ID, Order date from table orders_dimen where ‘Order Priority’ is high.----

select order_date, order_id, order_priority
from orders_dimen
where order_priority= 'high';

--- Find the total and the average sales (display total_sales and avg_sales)----
select  sales,
  sum(sales) as sum_of_quantity,
  avg(sum(sales)) over () as avg_sum
from market_fact;

--- Write a query to get the maximum and minimum sales from maket_fact table.----

select  max(sales) as MaxSales, min(Sales) as MinSales from market_fact ;

--- Display the number of customers in each region in decreasing order of no_of_customers. The result should contain columns Region, no_of_customers.---

select region ,
  count(region)  as no_of_customer 

  from cust_dimen
group by region
order by no_of_customer desc ;

--- Find the region having maximum customers (display the region name and max(no_of_customers)---

select region ,
  count(region)  as no_of_customer 

  from cust_dimen
group by region
order by no_of_customer desc ;

--- Find all the customers from Atlantic region who have ever purchased ‘TABLES’ and the number of tables purchased (display the customer name, no_of_tables purchased)---


select Customer_Name, 
count(*) as num_tables     
from market_fact s, cust_dimen c, prod_dimen p
where s.Cust_id = c.Cust_id and  
	s.Prod_id = p.Prod_id and     
    p.Product_Sub_Category = 'TABLES' and  
    c.Region = 'ATLANTIC'    
 group by Customer_Name;
 
--- Find all the customers from Ontario province who own Small Business. (display the customer name, no of small business owners)===

select province,customer_segment,
count(customer_segment) as no_of_small_buisness
from cust_dimen  
where province like 'ontario' 
order by customer_segment;

--- Find the number and id of products sold in decreasing order of products sold (display product id, no_of_products sold)---

select Prod_id, sum(order_quantity) as TotalQty from market_fact group by Prod_ID;

--- Display product Id and product sub category whose produt category belongs to Furniture and Technlogy. The result should contain columns product id, product sub category.---
select Prod_id,product_sub_category
from prod_dimen
where product_category in ('furniture','technology')
order by product_sub_category;

-- Display the product categories in descending order of profits (display the product category wise profits i.e. product_category, profits)?---

SELECT  c.product_category, a.profit
FROM prod_dimen c
INNER JOIN market_fact a
ON c.prod_id = a.prod_id 
WHERE a.profit 
order by a.profit desc;

--- Display the product category, product sub-category and the profit within each subcategory in three columns.--
SELECT 
    p.product_category, p.product_sub_category, SUM(m.profit) AS profits
	FROM
    market_fact m
	INNER JOIN
    prod_dimen p ON m.prod_id = p.prod_id
	GROUP BY p.product_category, p.product_sub_category;
    
--- Display the order date, order quantity and the sales for the order--
SELECT  c.order_date, a.ord_id , a.order_quantity,a.sales 
FROM orders_dimen c
INNER JOIN market_fact a
ON c.ord_id = a.ord_id 
WHERE a.sales;

/*-- Display the names of the customers whose name contains the
i) Second letter as ‘R’
ii) Fourth letter as ‘D’ */

SELECT * from cust_dimen ;

SELECT customer_name, LEFT(customer_name,3), left(customer_name,4) 
from cust_dimen
where (customer_name like '%R%' and customer_name like '%d%') ;



/*Where is the least profitable product subcategory shipped the most? 
For the least profitable product sub-category, display the region-wise no_of_shipments and the
profit made in each region in decreasing order of profits (i.e. region, no_of_shipments, profit_in_each_region)
→ Note: You can hardcode the name of the least profitable product subcategory */

 SELECT 
    c.region, COUNT(distinct s.ship_id) AS no_of_shipments, SUM(m.profit) AS profit_in_each_region
	FROM
    market_fact m
	INNER JOIN
    cust_dimen c ON m.cust_id = c.cust_id
	INNER JOIN
    shipping_dimen s ON m.ship_id = s.ship_id
	INNER JOIN
    prod_dimen p ON m.prod_id = p.prod_id
	WHERE
    p.product_sub_category IN 
   -- Query for identifying the least profitable sub-category--
   (	SELECT 							
		p.product_sub_category
        FROM
		market_fact m
		INNER JOIN
		prod_dimen p ON m.prod_id = p.prod_id
        GROUP BY p.product_sub_category
        HAVING SUM(m.profit) <= ALL
		(SELECT 
		SUM(m.profit) AS profits
		FROM
		market_fact m
		INNER JOIN
		prod_dimen p ON m.prod_id = p.prod_id
		GROUP BY p.product_sub_category))
	GROUP BY c.region
	ORDER BY profit_in_each_region DESC;
    
    -- Write a SQL query to find the 3rd highest sales.--
  
SELECT DISTINCT sales 
FROM market_fact  a
WHERE 3 >= 3
ORDER BY a.sales DESC;
 
 --- end ----
