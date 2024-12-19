-- Database created for project budget management system
CREATE DATABASE PROJECT;

USE PROJECT;

-- CREATING TABLES --

-- 1. Creating table users to manage the number of users and their details 
CREATE TABLE Users (
    User_id INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(100) UNIQUE, 
    Email_id VARCHAR(100) UNIQUE,
    Pincode INT,
    Created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

-- 2. Creating table categories to allot expenses into 
CREATE TABLE Categories (
    category_no INT PRIMARY KEY AUTO_INCREMENT,
    Category_name VARCHAR(250),
    User_id INT,
    Budget INT,
    FOREIGN KEY (User_id) REFERENCES Users(User_id)
);

-- 3. Creating table income to store user income and savings
CREATE TABLE Income (
    Income_amt DECIMAL(10,2),
    Savings DECIMAL(10,2),
    User_id INT,
    FOREIGN KEY (User_id) REFERENCES Users(User_id)
);

-- 4. Creating a table to monitor savings 
CREATE TABLE Savings (
    savings_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    goal DECIMAL(10, 2),
    current_savings DECIMAL(10, 2),
    target_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- 5. Creating table expenditure to monitor how much money is spent 
CREATE TABLE Expenditure (
    expenditure_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    category_name VARCHAR(250),
    expense_amount DECIMAL(10, 2),
    date_of_expense DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- 6. Creating Recurring Transactions Table
CREATE TABLE RecurringTransactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    category_id INT,
    amount DECIMAL(10, 2),
    frequency VARCHAR(50),
    next_due_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_no)
);

-- 7. Creating Goals Progress Table
CREATE TABLE GoalsProgress (
    goal_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    description VARCHAR(255),
    target_amount DECIMAL(10, 2),
    current_amount DECIMAL(10, 2),
    start_date DATE,
    due_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- 8. Creating Notifications Table
CREATE TABLE Notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    message TEXT,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- 9. Creating Debt Payments Table
CREATE TABLE DebtPayments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    payment_date DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- 10. Creating Wishlist Table
CREATE TABLE Wishlist (
    wishlist_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    item_name VARCHAR(250),
    estimated_cost DECIMAL(10, 2),
    priority INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- INSERTING DATASET INTO TABLES --

-- 1. Inserting demo users into the user table 
INSERT INTO Users (Username, Email_id, Pincode) VALUES 
('John Doe', 'John.doe@gmail.com', 12345),
('Jane Doe', 'Jane.Doe@gmail.com', 123456),
('Harry Ford', 'harry.ford@gmail.com', 12344);

-- 2. Inserting values into the category table 
INSERT INTO Categories (User_id, Category_name, Budget) VALUES
(1, 'Alcohol & Bars', 50),
(1, 'Auto Insurance', 75),
(1, 'Coffee Shops', 15),
(1, 'Electronics & Software', 0),
(1, 'Entertainment', 25),
(1, 'Fast Food', 15),
(1, 'Gas & Fuel', 75),
(1, 'Groceries', 150),
(1, 'Haircut', 30),
(1, 'Home Improvement', 250),
(1, 'Internet', 75),
(1, 'Mobile Phone', 65),
(1, 'Mortgage & Rent', 1100),
(1, 'Movies & DVDs', 0),
(1, 'Music', 11),
(1, 'Restaurants', 150),
(1, 'Shopping', 100),
(1, 'Television', 15),
(1, 'Utilities', 150),
(2, 'Alcohol & Bars', 50),
(2, 'Auto Insurance', 75),
(2, 'Coffee Shops', 15),
(2, 'Electronics & Software', 0),
(2, 'Entertainment', 25),
(2, 'Fast Food', 15),
(2, 'Gas & Fuel', 75),
(2, 'Groceries', 150),
(2, 'Internet', 75),
(2, 'Mobile Phone', 65),
(2, 'Mortgage & Rent', 1100),
(2, 'Movies & DVDs', 0),
(2, 'Music', 11),
(2, 'Restaurants', 150),
(2, 'Shopping', 100),
(3, 'Groceries', 150),
(3, 'Haircut', 30),
(3, 'Home Improvement', 250),
(3, 'Internet', 75),
(3, 'Mobile Phone', 65),
(3, 'Mortgage & Rent', 1100),
(3, 'Movies & DVDs', 0),
(3, 'Music', 11),
(3, 'Restaurants', 150);

-- 3. Inserting values into the savings table 
INSERT INTO Savings (user_id, goal, current_savings, target_date) VALUES
(1, 500.00, 200.00, '2024-12-31'),
(2, 1000.00, 300.00, '2025-05-30'),
(3, 750.00, 400.00, '2025-03-15');

-- 4. Inserting values into the income table 
INSERT INTO Income (User_id, Income_amt, Savings) VALUES
(1, 10000.00, 200), 
(2, 10000.00, 300),
(3, 15000, 400);

-- 5. Inserting values into the expenditure table 
INSERT INTO Expenditure (user_id, category_name, expense_amount, date_of_expense) VALUES 
(1, 'Groceries', 100.00, '2024-10-01'),
(1, 'Entertainment', 50.00, '2024-10-03'),
(1, 'Gas & Fuel', 40.00, '2024-10-04'),
(2, 'Groceries', 150.00, '2024-10-01'),
(2, 'Restaurants', 75.00, '2024-10-05'),
(2, 'Fast Food', 20.00, '2024-10-07'),
(3, 'Mobile Phone', 65.00, '2024-10-02'),
(3, 'Utilities', 100.00, '2024-10-06'),
(3, 'Internet', 75.00, '2024-10-08');

-- CREATING VIEWS --

-- View to display user data
CREATE VIEW UserDisplay AS
SELECT u.User_id, u.Username, i.Income_amt, c.Category_name, c.Budget, s.current_savings
FROM Users u
JOIN Income i ON u.User_id = i.User_id
JOIN Categories c ON u.User_id = c.User_id
JOIN Savings s ON u.User_id = s.user_id;

-- View to compare actual budget spent and amount left
CREATE VIEW Budget_Expenditure_Comparison AS
SELECT u.Username, 
       c.Category_name, 
       c.Budget AS Budgeted_Amount, 
       IFNULL(SUM(e.expense_amount), 0) AS Actual_Expenditure,
       (c.Budget - IFNULL(SUM(e.expense_amount), 0)) AS Remaining_Budget
FROM Categories c
LEFT JOIN Expenditure e ON c.User_id = e.user_id AND c.Category_name = e.category_name
INNER JOIN Users u ON c.User_id = u.User_id
GROUP BY u.Username, c.Category_name, c.Budget;

-- View to check if anyone is over budget
CREATE VIEW Over_Budget AS
SELECT 
    u.Username, 
    c.Category_name, 
    c.Budget AS Budgeted_Amount, 
    IFNULL(SUM(e.expense_amount), 0) AS Actual_Expenditure,
    (IFNULL(SUM(e.expense_amount), 0) - c.Budget) AS Over_Amount
FROM Categories c
LEFT JOIN Expenditure e ON c.User_id = e.User_id AND c.Category_name = e.category_name
INNER JOIN Users u ON c.User_id = u.User_id
GROUP BY u.Username, c.Category_name, c.Budget
HAVING Actual_Expenditure > Budgeted_Amount;

-- STORING PROCEDURES --

DELIMITER $$

-- 1. Procedure to add new income entry
CREATE PROCEDURE AddIncome (
    IN p_user_id INT, 
    IN p_income_amt DECIMAL(10, 2), 
    IN p_savings DECIMAL(10, 2)
)
BEGIN
    INSERT INTO Income (User_id, Income_amt, Savings) VALUES (p_user_id, p_income_amt, p_savings);
END $$

-- 2. Procedure to add a new expenditure entry
CREATE PROCEDURE AddExpenditure (
    IN p_user_id INT, 
    IN p_category_name VARCHAR(250), 
    IN p_expense_amount DECIMAL(10, 2), 
    IN p_date_of_expense DATE
)
BEGIN
    INSERT INTO Expenditure (user_id, category_name, expense_amount, date_of_expense) VALUES (p_user_id, p_category_name, p_expense_amount, p_date_of_expense);
END $$

-- 3. Procedure to update budget for a specific category
CREATE PROCEDURE UpdateCategoryBudget (
    IN p_user_id INT, 
    IN p_category_name VARCHAR(250), 
    IN p_new_budget INT
)
BEGIN
    UPDATE Categories SET Budget = p_new_budget WHERE User_id = p_user_id AND Category_name = p_category_name;
END $$

-- 4. Procedure to delete an expenditure entry
CREATE PROCEDURE DeleteExpenditure (
    IN p_expenditure_id INT
)
BEGIN
    DELETE FROM Expenditure WHERE expenditure_id = p_expenditure_id;
END $$

-- 5. Procedure to get total savings for a user
CREATE PROCEDURE GetTotalSavings (
    IN p_user_id INT
)
BEGIN
    SELECT SUM(goal - current_savings) AS Total_Savings FROM Savings WHERE user_id = p_user_id;
END $$

DELIMITER ;
-- USING BASIC AND ADVANCED QUERIES FOR DATA EXTRACTION AND DISPLAY --

-- DISPLAYING TABLES --
SELECT * FROM Users;
SELECT * FROM Categories;
SELECT * FROM Savings;
SELECT * FROM Income;

-- DISPLAYING DATA OF INDIVIDUAL USERS 
SELECT * FROM UserDisplay WHERE User_id = 1;
SELECT * FROM UserDisplay WHERE User_id = 2;
SELECT * FROM UserDisplay WHERE User_id = 3;

-- Checking total sum of budget set by all users 
SELECT u.Username, SUM(c.Budget) AS Total_Budget
FROM Users u
INNER JOIN Categories c ON u.User_id = c.User_id
GROUP BY u.Username;

-- Query to compare two users
SELECT u1.Username AS User1, 
       u2.Username AS User2, 
       c1.Category_name, 
       c1.Budget AS User1_Budget, 
       c2.Budget AS User2_Budget
FROM Categories c1
INNER JOIN Categories c2 ON c1.Category_name = c2.Category_name
INNER JOIN Users u1 ON c1.User_id = u1.User_id
INNER JOIN Users u2 ON c2.User_id = u2.User_id
WHERE u1.User_id = 1 AND u2.User_id = 2;

-- Ranking users by spending 
SELECT u.Username, 
       SUM(c.Budget) AS Total_Budget, 
       RANK() OVER (ORDER BY SUM(c.Budget) DESC) AS Spending_Rank
FROM Users u
INNER JOIN Categories c ON u.User_id = c.User_id
GROUP BY u.Username;

-- Displaying Budget Expenditure Comparison
SELECT * FROM Budget_Expenditure_Comparison;

-- Displaying Over Budget Information
SELECT * FROM Over_Budget;
