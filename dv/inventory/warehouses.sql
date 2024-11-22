-- @param warehouse_id the ID of the warehouse
-- @type warehouse_id integer
-- @default warehouse_id null

-- @return warehouse information

SELECT WarehouseID, WarehouseLocation, ManagerName
FROM (
    VALUES
        (1, 'Warehouse A', 'John Doe'),
        (2, 'Warehouse B', 'Jane Smith')
) AS Warehouses (WarehouseID, WarehouseLocation, ManagerName)
WHERE :warehouse_id IS NULL OR Warehouses.WarehouseID = :warehouse_id;
