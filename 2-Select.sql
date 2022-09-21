
DROP TABLE TestXML
CREATE TABLE TestXML
	(TestID VARCHAR(10) PRIMARY KEY,
	 XMLValue xml)


--Insert Data Into Table

DECLARE @myXML xml

SET @myXML = '<Products_Categories>
				<Category CategoryID="10" CategoryName="Toys">
					<Product ProductID="1">MagicFeary</Product>
					<Product ProductID="2">RaceCar</Product>
				</Category>
				<Category CategoryID="20" CategoryName="Sweets">
					<Product ProductID="214">Mekupelet</Product>
					<Product ProductID="247">Neshikulada</Product>
					<Product ProductID="312">Egozi</Product>
				</Category>
			  </Products_Categories>'


INSERT INTO TestXML VALUES ('Kiosk', @myXML)
---------------------------------------------------------------------------
-- XML Data Type, XQuery And the XML Methods (Query, Value & Exist)
---------------------------------------------------------------------------

--------------------------
-- XQUERY METHODS
--    Query, Value, Exist
--------------------------

-------------------------------------------------
-- QUERY - extract a specific part from our XML.
-------------------------------------------------
select * from TestXML


-- Get all products:
SELECT TestID, XMLValue.query('(/Products_Categories/Category/Product)')
FROM TestXML

-- Specify a condition inside []
-- Get the 4th product:
SELECT TestID, XMLValue.query('(/Products_Categories/Category/Product)[4]')
FROM TestXML

-- Get product 214:
SELECT TestID, XMLValue.query('(/Products_Categories/Category/Product[@ProductID=214])')
FROM TestXML

-- Get product where id>100:
SELECT TestID, XMLValue.query('(/Products_Categories/Category/Product[@ProductID>100])')
FROM TestXML

-- Get all categories:
SELECT TestID, XMLValue.query('(/Products_Categories/Category)')
FROM TestXML

-- Get the Second category with Query:
SELECT TestID, XMLValue.query('(/Products_Categories/Category[2])')
FROM TestXML

-- Get the Toys category:
SELECT TestID, XMLValue.query('(/Products_Categories/Category[@CategoryName="Toys"])')
FROM TestXML

-- Get the text of the second product in the Toys category:
SELECT TestID , XMLValue.query('/Products_Categories/Category')
FROM TestXML
---------------------------------------------------
-- VALUE - Get specific scalar values from the XML
---------------------------------------------------

-- Can do the same using VALUE method
-- * Must specify the XQuery expression and the Data type
-- * The result must be a single value

-- Get the second category name:
SELECT TestID, XMLValue.value('(/Products_Categories/Category/@CategoryName)[2]','varchar(10)')
FROM [TestXML]

SELECT TestID, XMLValue.value('(/Products_Categories/Category/Product)[4]','varchar(10)')
FROM [TestXML]

SELECT TestID, XMLValue.value('(/Products_Categories/Category)[2]','varchar(10)')
FROM [TestXML]

SELECT TestID, XMLValue.value('count(/Products_Categories/Category/Product)','int')
FROM [TestXML]

SELECT TestID, XMLValue.value('concat(	
(/Products_Categories/Category/Product)[1] ,'' ''   ,(/Products_Categories/Category/Product)[1])' , 'varchar(100)')
FROM [TestXML]


-----------------------------------
-- EXIST - Check if a value exists
-----------------------------------
-- * Returns 0 (False) or 1 (True)

--Existing
SELECT TestID, XMLValue.exist('(/Products_Categories/Category[@CategoryName="Toys"])')
FROM TestXML

--Non-existing
SELECT TestID, XMLValue.exist('(/Products_Categories/Category[@CategoryName="Fruits"])')
FROM TestXML
