BEGIN TRY
    DROP TABLE [dbo].[sp500hst]
END TRY
BEGIN CATCH
END CATCH
GO
CREATE TABLE [dbo].[sp500hst] (
    [Date] [VARCHAR](10) NULL,
    [Ticker] [VARCHAR](10) NULL,
    [Open] [VARCHAR](10) NULL,
    [High] [VARCHAR](10) NULL,
    [Low] [VARCHAR](10) NULL,
    [Close] [VARCHAR](10) NULL,
    [Volume] [VARCHAR](10) NULL
) ON [PRIMARY]
GO
BULK INSERT [dbo].[sp500hst] FROM 'C:\dd\sp500hst.txt' WITH (FIELDTERMINATOR = ',')
GO
SELECT * FROM [dbo].[sp500hst] WHERE [Date] = '20090821' ORDER BY [Ticker]
FOR XML PATH('StockData'),ROOT('StockMarketData')
GO

--http://www.w3schools.com/xsl/xsl_w3celementref.asp

--ORDER BY
--GROUP BY
--Cannot be an index key.
--Cannot compare uses the XML type.


--create table txml
--(x xml)

--declare @x xml 
--set @x  = (select * from Employees
--for xml auto)

--insert into txml values(@x)

--select  * from txml

------------------------------------------
select firstname , lastname , employeeid 
from employees 
--for xml path 
--for xml raw
for xml auto
 

-- ישנם 3 שיטות של שליפה 
--AUTO
--RAW
--PATH

select top 10 *
from orders 
--for xml auto 
--for xml raw('MyOrders') , root('Orders') --attributes
FOR XML PATH('StockData'),ROOT('StockMarketData')

select top 10 *
from orders 
for xml raw('MyOrders') , elements , root('ddd') --elements 

select top 100  firstname , lastname , orderid , orderdate 
from orders , employees 
where orders.employeeid = employees.EmployeeID
order by OrderID
for XML PATH

select top 100  orderid  as '@Invoice' , --attribute
--		lastname as '@lastname' , --attributes
		firstname as  [fullname/firstname] ,
		lastname as  [fullname/lastname]  ,
		orderdate  as [details/orderdate]
from orders , employees 
where orders.employeeid = employees.EmployeeID
order by orderid 
for XML PATH -- , root('ggg')


--SELECT ALL ORDERS with CustomerName, customerCity, CustomerID and OrderID as Attribute.
select 
orderid  as '@orderid',
CompanyName 'CustDetails/CompanyName', 
City 'CustDetails/CustCity',
customers.CustomerID  'CustDetails/CustomerID'
	from Customers join Orders
	on ( Customers.CustomerID = Orders.CustomerID)
order by customers.CustomerID
for xml path , root('AllOrders')

select 
customers.CustomerID as '@CustomerID',
CompanyName 'CustDetails/CompanyName', 
City 'CustDetails/CustCity',
orderid  'CustDetails/orderid'
	from Customers join Orders
	on ( Customers.CustomerID = Orders.CustomerID)
order by customers.CustomerID
for xml path('Customer') , root('AllOrders')

--each column is Element
select 
customers.CustomerID ,
CompanyName , 
City ,
orderid 
	from Customers join Orders
	on ( Customers.CustomerID = Orders.CustomerID)
order by customers.CustomerID
for xml path('Customer') , root('AllOrders')
--------------------------------
declare @xml xml
set @xml = '<row orderid="10643">
    <CustDetails>
      <CompanyName>Alfreds Futterkiste</CompanyName>
      <CustCity>Berlin</CustCity>
      <CustomerID>ALFKI</CustomerID>
    </CustDetails>
  </row>
  <row orderid="10692">
    <CustDetails>
      <CompanyName>Alfreds Futterkiste</CompanyName>
      <CustCity>Berlin</CustCity>
      <CustomerID>ALFKI</CustomerID>
    </CustDetails>
  </row>'
--------------------------------
declare @x xml 
set @x = (select * from Employees for xml auto)

select @x
 
---------------------------------------
--תרגיל : 

--זהו באמצעות טבלאות מערכת היכן והאם קיים שדה אקסמלי ב 
--AdvWorks
--שמות הטבלאות:
--select * from sys.columns
--where system_type_id  = 36
--and  object_id = '462624691'

--select * from sys.tables
--where object_id = '462624691'

--select * from sys.systypes
