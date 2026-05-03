--Creating a table.
CREATE TABLE Loan_DB(
I_d SERIAL PRIMARY KEY,
Income INT,
Credit_Score INT,
Loan_Amount INT,
DTI_Ratio FLOAT,
Employment_Status VARCHAR(20),
Approval VARCHAR(30),
Risk_Level VARCHAR(20)
)

--Approval & Rejection Rates
SELECT 
	COUNT(CASE WHEN Approval = 'Approved' THEN 1 END)*100.0/COUNT(*) AS Approval_rate,
	COUNT(CASE WHEN Approval = 'Rejected' THEN 1 END)*100.0/COUNT(*) AS Rejection_rate
FROM Loan_db;

--Risk Distribution
SELECT 
	Risk_Level,COUNT(*) AS Total_Customers, ROUND(COUNT(*) * 100.0/SUM(COUNT(*)) OVER(), 2) AS Percentage
FROM Loan_db
GROUP BY Risk_Level;

--High Risk Customers
SELECT *
FROM Loan_db
WHERE Risk_Level = 'High Risk';

--Loan Amount vs Approval
SELECT Approval, AVG(Loan_Amount) AS Avg_loan, COUNT(*) AS Total
From Loan_db
GROUP BY Approval;

--Income vs Risk
SELECT Risk_Level, AVG(income) AS Avg_income, Count(*) AS Total
FROM Loan_db
GROUP BY Risk_Level
ORDER BY Avg_income;

--Credit Score vs Approval
SELECT Approval,AVG(Credit_Score) AS Avg_Credit_Score
FROM Loan_db
GROUP BY Approval;

--DTI Ratio(Debt-to-Income) Risk Analysis
SELECT Risk_Level, AVG(DTI_Ratio) AS Avg_dti
FROM Loan_db
GROUP BY Risk_Level
ORDER BY Avg_dti DESC;

--Employment Status Impact
SELECT Employment_Status, COUNT(*) AS Total, SUM(CASE WHEN Approval='Approved ' THEN 1 ELSE 0 END) AS Approved
FROM Loan_db
GROUP BY Employment_Status;

--Create Risk Segmentation
SELECT 
	CASE
		WHEN DTI_Ratio>0.5 THEN 'High Risk'
		WHEN DTI_Ratio BETWEEN 0.3 AND 0.5 THEN 'Medium Risk'
		ELSE 'Low Risk'
	END AS Calculated_risk, COUNT(*) AS Total
FROM Loan_db
GROUP BY Calculated_Risk;

--Top Risk Factor
SELECT Employment_Status, (AVG(DTI_Ratio),2) AS Avg_dti, (AVG(Credit_Score),2) AS Avg_Score, COUNT(*) AS Total
FROM Loan_db
GROUP BY Employment_Status
ORDER BY Avg_dti DESC;