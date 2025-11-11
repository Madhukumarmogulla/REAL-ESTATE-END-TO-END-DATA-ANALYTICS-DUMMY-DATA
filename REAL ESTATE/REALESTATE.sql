CREATE SCHEMA realestate;
use realestate;

CREATE TABLE Property_Details (
    Property_ID VARCHAR(10) PRIMARY KEY,
    Property_Type VARCHAR(50),
    Address VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(2),
    Zip_Code VARCHAR(10),
    Sq_Footage INT,
    Built_Year INT,
    Num_Bedrooms INT,
    Num_Bathrooms INT,
    Zoning VARCHAR(20)
);

CREATE TABLE Transaction_History (
    Transaction_ID VARCHAR(10) PRIMARY KEY,
    Property_ID VARCHAR(10),
    Transaction_Date DATE,
    Transaction_Type VARCHAR(50),
    Sale_Price_USD DECIMAL(10,2),
    Buyer_Type VARCHAR(50),
    FOREIGN KEY (Property_ID) REFERENCES Property_Details(Property_ID)
);

CREATE TABLE Rental_Income (
    Rental_ID VARCHAR(10) PRIMARY KEY,
    Property_ID VARCHAR(10),
    Period_Month INT,
    Period_Year INT,
    Rental_Income_USD DECIMAL(8,2),
    Occupancy_Status VARCHAR(20),
    Vacancy_Days INT,
    FOREIGN KEY (Property_ID) REFERENCES Property_Details(Property_ID)
);

CREATE TABLE Property_Expenses (
    Expense_ID VARCHAR(10) PRIMARY KEY,
    Property_ID VARCHAR(10),
    Expense_Date DATE,
    Expense_Type VARCHAR(100),
    Amount_USD DECIMAL(8,2),
    Vendor VARCHAR(100),
    FOREIGN KEY (Property_ID) REFERENCES Property_Details(Property_ID)
);

INSERT INTO Property_Details (Property_ID, Property_Type, Address, City, State, Zip_Code, Sq_Footage, Built_Year, Num_Bedrooms, Num_Bathrooms, Zoning) VALUES
('P001', 'Residential', '123 Oak St', 'San Diego', 'CA', '92101', 1500, 1998, 3, 2, 'R1'),
('P002', 'Commercial', '456 Main Ave', 'Phoenix', 'AZ', '85001', 5000, 2005, 0, 2, 'C2'),
('P003', 'Residential', '789 Pine Ln', 'Sacramento', 'CA', '95814', 1200, 1975, 2, 1, 'R1'),
('P004', 'Residential', '101 Maple Rd', 'Austin', 'TX', '78701', 2000, 2010, 4, 3, 'R1'),
('P005', 'Commercial', '202 Market St', 'Denver', 'CO', '80202', 8000, 1990, 0, 4, 'C1');

INSERT INTO Transaction_History (Transaction_ID, Property_ID, Transaction_Date, Transaction_Type, Sale_Price_USD, Buyer_Type) VALUES
('T001', 'P001', '2019-05-20', 'Acquisition', 550000.00, 'Investor'),
('T002', 'P003', '2020-01-15', 'Acquisition', 380000.00, 'Investor'),
('T003', 'P004', '2021-03-01', 'Acquisition', 720000.00, 'Investor'),
('T004', 'P001', '2023-08-10', 'Sale', 680000.00, 'Individual'),
('T005', 'P002', '2022-06-25', 'Acquisition', 1200000.00, 'Investor');

INSERT INTO Rental_Income (Rental_ID, Property_ID, Period_Month, Period_Year, Rental_Income_USD, Occupancy_Status, Vacancy_Days) VALUES
('R001', 'P001', 1, 2023, 2800.00, 'Occupied', 0),
('R002', 'P001', 2, 2023, 2800.00, 'Occupied', 0),
('R003', 'P003', 1, 2023, 2000.00, 'Occupied', 0),
('R004', 'P002', 1, 2023, 6000.00, 'Occupied', 0),
('R005', 'P001', 9, 2023, 0.00, 'Vacant', 20),
('R006', 'P004', 10, 2023, 3500.00, 'Occupied', 0);

INSERT INTO Property_Expenses (Expense_ID, Property_ID, Expense_Date, Expense_Type, Amount_USD, Vendor) VALUES
('E001', 'P001', '2023-01-10', 'Property Tax', 500.00, 'City of SD'),
('E002', 'P001', '2023-02-15', 'Repair (Plumbing)', 300.00, 'PlumbGenius'),
('E003', 'P003', '2023-03-01', 'Landscaping', 150.00, 'Green Thumb'),
('E004', 'P002', '2023-04-20', 'Utilities', 800.00, 'Phoenix Power'),
('E005', 'P001', '2023-08-05', 'Cleaning', 200.00, 'Spotless');
