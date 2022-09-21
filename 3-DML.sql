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
----------------------------------------------------------------------
-- MODIFY
----------------------------------------------------------------------

-- Change values in the XML:
--  1. INSERT  - Add a new value or node.
--  2. REPLACE - Change a value or a node.
--  3. DELETE  - Delete a value or a node.

-- * All methods can affect only one node. (Therefore specify [1] when needed)

----------------------------------------------------------------------
-- INSERT
----------------------------------------------------------------------

-----------------------------------
-- Add an attribute:
-- Add a discount attribute as the last attribute to the first category:

DECLARE @myXMLDoc XML
SELECT @myXMLDoc = XMLValue
FROM [TestXML]

SET @myXMLDoc.modify('insert attribute OnDiscount {"Yes"} 
as last into (/Products_Categories/Category)[2]')

SELECT @myXMLDoc

-----------------------------------
-- Add an element:
-- Add a "PesekZman" element as the first element of the "Sweets" category:

DECLARE @myXMLDoc XML
SELECT @myXMLDoc = XMLValue
FROM [TestXML]

SET @myXMLDoc.modify('insert element Product {"PesekZman"}
as last
into (/Products_Categories/Category[@CategoryName="Sweets"])[1]')
SELECT @myXMLDoc

-- Note that we must specify the occurance counter ([1]) even if there is only one occurence.

-----------------------------------
-- Add a whole literal:
-- Add "PesekZman" before "Egozi" to the Sweets category:
DECLARE @myXMLDoc XML
SELECT @myXMLDoc = XMLValue
FROM [TestXML]

SET @myXMLDoc.modify('insert <Product ProductID="500">PesekZman</Product>
before (/Products_Categories/Category/Product[text()="Egozi"])[1]')

SELECT @myXMLDoc


----------------------------------------------------------------------
-- REPLACE
----------------------------------------------------------------------

-- Change the name (Text) of the 2nd product to Barbi:

DECLARE @myXMLDoc XML
SELECT @myXMLDoc = XMLValue
FROM [TestXML]

SET @myXMLDoc.modify('replace value of (/Products_Categories/Category/Product/text())[2]
                      with "Barbi"')
SELECT @myXMLDoc

-- Change the name (Text) of product 247 to Barbi:

DECLARE @myXMLDoc XML
SELECT @myXMLDoc = XMLValue
FROM [TestXML]

SET @myXMLDoc.modify('replace value of (/Products_Categories/Category/Product[@ProductID=247]/text())[1]
                      with "Barbi"')
SELECT @myXMLDoc

----------------------------------------------------------------------
-- DELETE
----------------------------------------------------------------------

-- Delete the second product

DECLARE @myXMLDoc XML
SELECT @myXMLDoc = XMLValue
FROM [TestXML]

--SET @myXMLDoc.modify('delete (/Products_Categories/Category/Product)[2]')
--SET @myXMLDoc.modify('delete (/Products_Categories/Category)[2]') -- Delete category 2
--SET @myXMLDoc.modify('delete (/Products_Categories/Category/Product[text()="Egozi"])')
SET @myXMLDoc.modify('delete (/Products_Categories/Category/Product[@ProductID=247])')
--SET @myXMLDoc.modify('delete (/Products_Categories/Category[@CategoryID=20]/@CategoryName)')
--SET @myXMLDoc.modify('delete (/Products_Categories/Category[@CategoryID=20]/Product)[2]')
SELECT @myXMLDoc