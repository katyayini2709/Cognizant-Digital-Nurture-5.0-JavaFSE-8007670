SET SERVEROUTPUT ON;

-- =========================
-- CREATE TABLES
-- =========================

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

-- =========================
-- INSERT SAMPLE DATA
-- =========================

INSERT INTO Customers VALUES (1,'John Doe',TO_DATE('1960-05-15','YYYY-MM-DD'),1000,SYSDATE);
INSERT INTO Customers VALUES (2,'Jane Smith',TO_DATE('1990-07-20','YYYY-MM-DD'),15000,SYSDATE);

INSERT INTO Accounts VALUES (1,1,'Savings',1000,SYSDATE);
INSERT INTO Accounts VALUES (2,2,'Checking',15000,SYSDATE);

INSERT INTO Loans VALUES (1,1,5000,5,SYSDATE,ADD_MONTHS(SYSDATE,20));
INSERT INTO Loans VALUES (2,2,8000,7,SYSDATE,SYSDATE+25);

INSERT INTO Employees VALUES (1,'Alice Johnson','Manager',70000,'HR',DATE '2015-06-15');
INSERT INTO Employees VALUES (2,'Bob Brown','Developer',60000,'IT',DATE '2017-03-20');

COMMIT;

-- ======================================================
-- EXERCISE 1 - SCENARIO 1
-- Apply 1% discount to loan interest for customers >60
-- ======================================================

BEGIN
    FOR customer_rec IN (
        SELECT CustomerID,
               FLOOR(MONTHS_BETWEEN(SYSDATE,DOB)/12) AS Age
        FROM Customers
    )
    LOOP
        IF customer_rec.Age > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE CustomerID = customer_rec.CustomerID;
        END IF;
    END LOOP;

    COMMIT;
END;
/

SELECT LoanID,CustomerID,InterestRate
FROM Loans;
SELECT LoanID, CustomerID, InterestRate
FROM Loans;

-- ======================================================
-- EXERCISE 1 - SCENARIO 2
-- VIP Customers
-- ======================================================

ALTER TABLE Customers
ADD IsVIP VARCHAR2(5);

BEGIN

    FOR customer_rec IN (
        SELECT CustomerID,Balance
        FROM Customers
    )
    LOOP

        IF customer_rec.Balance>10000 THEN

            UPDATE Customers
            SET IsVIP='TRUE'
            WHERE CustomerID=customer_rec.CustomerID;

        END IF;

    END LOOP;

    COMMIT;

END;
/

SELECT CustomerID,Name,Balance,IsVIP
FROM Customers;

-- ======================================================
-- EXERCISE 1 - SCENARIO 3
-- Loan Reminder
-- ======================================================

BEGIN

    FOR loan_rec IN (
        SELECT LoanID,
               CustomerID,
               EndDate
        FROM Loans
        WHERE EndDate BETWEEN SYSDATE
        AND SYSDATE+30
    )
    LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Reminder : Loan ID '
            ||loan_rec.LoanID||
            ' is due on '
            ||TO_CHAR(loan_rec.EndDate,'DD-MON-YYYY')
        );

    END LOOP;

END;
/
