SELECT * FROM Customers;

SELECT * FROM Orders;


#1. City-Wise Sales Performance:

SELECT 
    c.City,
    COUNT(DISTINCT c.CustomerID) AS TotalCustomers,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(o.Amount) AS TotalRevenue,
    ROUND(AVG(o.Amount), 2) AS AvgOrderValue
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.City
ORDER BY TotalRevenue DESC;



#2. Category Revenue Breakdown:

SELECT 
    Category,
    COUNT(OrderID) AS OrdersCount,
    SUM(Amount) AS CategoryRevenue,
    ROUND((SUM(Amount) * 100.0 / (SELECT SUM(Amount) FROM Orders)), 2) AS RevenueContributionPercentage
FROM Orders
GROUP BY Category
ORDER BY CategoryRevenue DESC;



#3. High-Value Customer Segmentation (VIP vs Regular):

WITH CustomerSpend AS (
    SELECT 
        c.CustomerID,
        c.CustomerName,
        c.City,
        SUM(o.Amount) AS TotalSpent
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerID, c.CustomerName, c.City
)
SELECT 
    CustomerID,
    CustomerName,
    City,
    TotalSpent,
    CASE 
        WHEN TotalSpent >= 40000 THEN 'VIP Customer'
        WHEN TotalSpent BETWEEN 15000 AND 39999 THEN 'Regular Customer'
        ELSE 'Low-Value Customer'
    END AS CustomerSegment
FROM CustomerSpend
ORDER BY TotalSpent DESC;
