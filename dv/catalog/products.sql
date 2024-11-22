-- @param product_id the ID of the product
-- @type product_id integer
-- @default product_id null

-- @return product information

SELECT ProductID, Name, Description, Price
FROM (
    VALUES
        (1, 'Laptop', 'High-end gaming laptop', 1500.00),
        (2, 'Smartphone', 'Latest model smartphone', 800.00),
        (3, 'Headphones', 'Noise-cancelling headphones', 200.00)
) AS Products (ProductID, Name, Description, Price)
WHERE :product_id IS NULL OR Products.ProductID = :product_id;
