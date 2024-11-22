-- @param warehouse_id the ID of the warehouse
-- @type warehouse_id integer
-- @default warehouse_id null

-- @param product_id the ID of the product
-- @type product_id integer
-- @default product_id null

-- @return stock levels of products in each warehouse

SELECT Inventory.WarehouseID, Warehouses.WarehouseLocation, Inventory.ProductID, Products.Name AS ProductName, Inventory.StockLevel
FROM (
    VALUES
        (1, 1, 50),   -- WarehouseID, ProductID, StockLevel
        (1, 2, 100),
        (2, 1, 30),
        (2, 3, 200)
) AS Inventory (WarehouseID, ProductID, StockLevel)
INNER JOIN (
    VALUES
        (1, 'Warehouse A', 'John Doe'),
        (2, 'Warehouse B', 'Jane Smith')
) AS Warehouses (WarehouseID, WarehouseLocation, ManagerName)
    ON Inventory.WarehouseID = Warehouses.WarehouseID
INNER JOIN (
    VALUES
        (1, 'Laptop', 'High-end gaming laptop', 1500.00),
        (2, 'Smartphone', 'Latest model smartphone', 800.00),
        (3, 'Headphones', 'Noise-cancelling headphones', 200.00)
) AS Products (ProductID, Name, Description, Price)
    ON Inventory.ProductID = Products.ProductID
WHERE (:warehouse_id IS NULL OR Inventory.WarehouseID = :warehouse_id)
  AND (:product_id IS NULL OR Inventory.ProductID = :product_id);
