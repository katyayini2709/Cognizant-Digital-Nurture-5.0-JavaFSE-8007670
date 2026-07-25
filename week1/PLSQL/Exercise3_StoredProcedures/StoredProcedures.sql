-- ============================================
-- EXERCISE 3 : STORED PROCEDURES
-- ============================================

CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    DOB DATE,
    Balance NUMBER,
    LastModified DATE
);

CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    AccountType VARCHAR2(20),
    Balance NUMBER,
    LastModified DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Transactions (
    TransactionID NUMBER PRIMARY KEY,
    AccountID NUMBER,
    TransactionDate DATE,
    Amount NUMBER,
    TransactionType VARCHAR2(10),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    LoanAmount NUMBER,
    InterestRate NUMBER,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Position VARCHAR2(50),
    Salary NUMBER,
    Department VARCHAR2(50),
    HireDate DATE
);

--------------------------------------------------------
-- INSERT SAMPLE DATA
--------------------------------------------------------

INSERT INTO Customers VALUES
(1,'John Doe',TO_DATE('1960-05-15','YYYY-MM-DD'),1000,SYSDATE);

INSERT INTO Customers VALUES
(2,'Jane Smith',TO_DATE('1990-07-20','YYYY-MM-DD'),15000,SYSDATE);

INSERT INTO Accounts VALUES
(1,1,'Savings',1000,SYSDATE);

INSERT INTO Accounts VALUES
(2,2,'Checking',15000,SYSDATE);

INSERT INTO Employees VALUES
(1,'Alice Johnson','Manager',70000,'HR',DATE '2015-06-15');

INSERT INTO Employees VALUES
(2,'Bob Brown','Developer',60000,'IT',DATE '2017-03-20');

COMMIT;

--------------------------------------------------------
-- SCENARIO 1
-- Process Monthly Interest
--------------------------------------------------------

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest
IS
BEGIN
    UPDATE Accounts
    SET Balance = Balance + (Balance * 0.01)
    WHERE AccountType = 'Savings';

    COMMIT;
END;
/

BEGIN
    ProcessMonthlyInterest;
END;
/

SELECT AccountID,
       CustomerID,
       AccountType,
       Balance
FROM Accounts;

--------------------------------------------------------
-- SCENARIO 2
-- Update Employee Bonus
--------------------------------------------------------

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus
(
    p_department IN VARCHAR2,
    p_bonus IN NUMBER
)
IS
BEGIN

    UPDATE Employees
    SET Salary = Salary + (Salary * p_bonus / 100)
    WHERE Department = p_department;

    COMMIT;

END;
/

BEGIN
    UpdateEmployeeBonus('HR',10);
END;
/

SELECT EmployeeID,
       Name,
       Department,
       Salary
FROM Employees;

--------------------------------------------------------
-- SCENARIO 3
-- Transfer Funds
--------------------------------------------------------

CREATE OR REPLACE PROCEDURE TransferFunds
(
    p_sourceAccount IN NUMBER,
    p_targetAccount IN NUMBER,
    p_amount IN NUMBER
)
IS
    v_balance NUMBER;
BEGIN

    SELECT Balance
    INTO v_balance
    FROM Accounts
    WHERE AccountID = p_sourceAccount;

    IF v_balance >= p_amount THEN

        UPDATE Accounts
        SET Balance = Balance - p_amount
        WHERE AccountID = p_sourceAccount;

        UPDATE Accounts
        SET Balance = Balance + p_amount
        WHERE AccountID = p_targetAccount;

        COMMIT;

        DBMS_OUTPUT.PUT_LINE('Transfer Successful.');

    ELSE

        DBMS_OUTPUT.PUT_LINE('Insufficient Balance.');

    END IF;

END;
/

BEGIN
    TransferFunds(2,1,500);
END;
/

SELECT AccountID,
       CustomerID,
       AccountType,
       Balance
FROM Accounts;