-- ===================================================================================================
-- Q1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
-- //VIEW
CREATE OR REPLACE VIEW DSNVSALE AS
SELECT A.*, D.DepartmentName 
FROM `account` A
INNER JOIN department D 
ON  A.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'sale';

SELECT * FROM DSNVSALE;
DROP VIEW DSNVSALE;
-- //CTE :

WITH DSNVSALE AS (
SELECT A.*, D.DepartmentName
FROM `account` A
INNER JOIN department D 
ON A.DepartmentID = D.DepartmentID
WHERE D.DepartmentID = 'sale')
SELECT * FROM DSNVSALE;



-- ===================================================================================================
-- Q2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất

-- //VIEW 
CREATE OR REPLACE VIEW Q2 AS
WITH Q2A AS (
SELECT count(GA1.AccountID) AS countGA1 
FROM groupaccount GA1
GROUP BY GA1.AccountID
) 
SELECT A.AccountID, A.Username, count(GA.AccountID) AS SL FROM groupaccount GA
INNER JOIN account A ON GA.AccountID = A.AccountID
GROUP BY GA.AccountID
HAVING count(GA.AccountID) = (
SELECT MAX(countGA1) AS maxCount FROM Q2A
);
SELECT * FROM Q2;


-- ====================================================================================
-- Q3: : Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi

CREATE OR REPLACE VIEW Q3 AS
SELECT Q.questionID, Q.content 
FROM question Q 
WHERE LENGTH(Content) > 300;

SELECT * FROM Q3;
DELETE FROM Q3;

-- ========================================================================================

-- Q4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất

CREATE OR REPLACE VIEW Q4 AS 
SELECT D.DepartmentID, D.DepartmentName, count(A.AccountID) AS SL
FROM `Account` A 
INNER JOIN Department D ON A.DepartmentID = D.DepartmentID
GROUP BY A.DepartmentID
HAVING count(A.AccountID) = (SELECT MAX(A2.MAXSL) 
FROM (SELECT A1.DepartmentID, count(A1.AccountID) AS MAXSL  
FROM `account` A1 GROUP BY A1.DepartmentID) AS A2);
 
SELECT * FROM Q4;


-- ==========================================================================================
-- Q5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo

CREATE OR REPLACE VIEW Q5 AS
SELECT Q.questionID, Q.content, A.Fullname AS Cre_Name 
FROM question Q
INNER JOIN `account` A ON A.accountID = Q.creatorID
WHERE SUBSTRING_INDEX( A.FullName,' ', 1 ) = 'Nguyễn';

SELECT * FROM Q5;
