USE testingsystem;

-- ==========================================================================
-- Q1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ

SELECT A.Email, A.Username , A.FullName, D.DepartmentName
FROM `Account` A 
INNER JOIN Department D 
ON A.DepartmentID = D.DepartmentID;

-- ===========================================================================
-- Q2: : Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010

SELECT * FROM `Account`
WHERE CreateDate > '2010-12-20';


-- ======================================================================================================
-- Q3: Viết lệnh để lấy ra tất cả các developer

SELECT A.FullName, A.Email, P.PositionName
FROM `Account` A 
INNER JOIN Position P 
ON A.PositionID = P.PositionID
WHERE P.PositionName = 'Dev';

-- ============================================================================================
-- Q4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên

SELECT A.DepartmentID, D.DepartmentName, count(A.AccountID) AS SLNV
FROM `Account` A
INNER JOIN department D 
ON A.DepartmentID = D.DepartmentID
GROUP BY A.DepartmentID
HAVING COUNT(A.AccountID) >3;

-- ======================================================================================
-- Q5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất

SELECT E.QuestionID, Q.Content 
FROM examquestion E
INNER JOIN question Q 
ON Q.QuestionID = E.QuestionID
GROUP BY E.QuestionID
HAVING count(E.QuestionID) = (SELECT MAX(countQ) as maxcountQues 
FROM ( SELECT COUNT(E.QuestionID) AS countQ 
FROM examquestion E
GROUP BY E.QuestionID) AS countTable);


-- ===============================================================================
-- Q6: Thông kê mỗi Category Question được sử dụng trong bao nhiêu Question ???

SELECT cq.CategoryID, cq.CategoryName, count(q.CategoryID) AS SLhoi
FROM categoryquestion cq 
JOIN question q 
ON cq.CategoryID = q.CategoryID
GROUP BY q.CategoryID;


-- =============================================================================
-- Q7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam

-- Sử dụng LeftJoin
SELECT Q.questionID, Q.Content, COUNT(EQ.QuestionID) AS 'SO LUONG'
FROM Question Q 
LEFT JOIN ExamQuestion EQ 
ON EQ.QuestionID = Q.QuestionID
GROUP BY Q.QuestionID
ORDER BY EQ.QuestionID ASC;

-- =============================================================================
-- Q8: Lấy ra Question có nhiều câu trả lời nhất
SELECT Q.QuestionID, Q.Content, count(A.QuestionID) AS SLQ
FROM answer A
INNER JOIN question Q 
ON Q.QuestionID = A.QuestionID
GROUP BY A.QuestionID
HAVING count(A.QuestionID) = (
SELECT max(countQues) 
FROM (SELECT count(B.QuestionID) AS countQues 
FROM answer B
GROUP BY B.QuestionID) AS countAnsw);

-- ==============================================================================
-- Q9: Thống kê số lượng account trong mỗi group

SELECT G.GroupID, COUNT(GA.AccountID) AS 'SO LUONG'
FROM GroupAccount GA 
JOIN `Group` G ON GA.GroupID = G.GroupID
GROUP BY G.GroupID
ORDER BY G.GroupID ASC;


-- =============================================================================
-- Q10: Tìm chức vụ có ít người nhất
SELECT P.PositionID, P.PositionName, count( A.PositionID) AS SLNV 
FROM `account` A
INNER JOIN position P 
ON A.PositionID = P.PositionID
GROUP BY A.PositionID
HAVING count(A.PositionID)= (SELECT MIN(minP) FROM(
SELECT count(B.PositionID) AS minP FROM account B
GROUP BY B.PositionID) AS minPA);


-- =============================================================================
-- Q11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM

SELECT d.DepartmentID,d.DepartmentName, p.PositionName, count(p.PositionName) AS SLNV
FROM `account` a
INNER JOIN department d 
ON a.DepartmentID = d.DepartmentID
INNER JOIN position p 
ON a.PositionID = p.PositionID
GROUP BY d.DepartmentID, p.PositionID
ORDER BY SLNV ASC;


-- =============================================================================
-- Q12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, …

SELECT Q.QuestionID, Q.Content, A.FullName, TQ.TypeName AS Author, ANS.Content 
FROM question Q
INNER JOIN categoryquestion CQ 
ON Q.CategoryID = CQ.CategoryID
INNER JOIN typequestion TQ 
ON Q.TypeID = TQ.TypeID
INNER JOIN account A 
ON A.AccountID = Q.CreatorID
INNER JOIN Answer AS ANS 
ON Q.QuestionID = ANS.QuestionID
ORDER BY Q.QuestionID ASC

-- ===========================================================================
-- Q13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm

SELECT TQ.TypeID, TQ.TypeName, COUNT(Q.TypeID) AS SL 
FROM question Q
INNER JOIN typequestion TQ ON Q.TypeID = TQ.TypeID
GROUP BY Q.TypeID;


-- =============================================================================

-- Q14:Lấy ra group không có account nào

SELECT * FROM `group` g
LEFT JOIN groupaccount ga 
ON g.GroupID = ga.GroupID
WHERE GA.AccountID IS NULL;
-- =============================================================================

-- Q15: Lấy ra group không có account nào
SELECT * FROM `Group` 
WHERE GroupID NOT IN (SELECT GroupID
FROM GroupAccount);

-- =============================================================================
-- Q16: Lấy ra question không có answer nào
SELECT * FROM Question
WHERE QuestionID NOT IN (SELECT QuestionID FROM Answer);
SELECT q.QuestionID FROM answer a
RIGHT JOIN question q ON  a.QuestionID = q.QuestionID 
WHERE a.AnswerID IS NULL;

-- =============================================================================

-- Q17:
-- 17a) Lấy các account thuộc nhóm thứ 1
SELECT A.FullName FROM `Account` A
JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 1;

-- 17b) Lấy các account thuộc nhóm thứ 2
SELECT A.FullName FROM `Account` A
JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 2;

-- 17c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT A.FullName
FROM `Account` A
JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 1
UNION
SELECT A.FullName
FROM `Account` A
JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 2;

-- =====================================================================================

-- Q18:
-- 18a) Lấy các group có lớn hơn 5 thành viên
SELECT g.GroupName, COUNT(ga.GroupID) AS SL
FROM GroupAccount ga
JOIN `Group` g ON ga.GroupID = g.GroupID
GROUP BY g.GroupID
HAVING COUNT(ga.GroupID) >= 5;
-- 18b) Lấy các group có nhỏ hơn 7 thành viên
SELECT g.GroupName, COUNT(ga.GroupID) AS SL
FROM GroupAccount ga
JOIN `Group` g ON ga.GroupID = g.GroupID
GROUP BY g.GroupID
HAVING COUNT(ga.GroupID) <= 7;
-- 18c) Ghép 2 kết quả từ câu a) và câu b)
SELECT g.GroupName, COUNT(ga.GroupID) AS SL
FROM GroupAccount ga
JOIN `Group` g ON ga.GroupID = g.GroupID
GROUP BY g.GroupID
HAVING COUNT(ga.GroupID) >= 5
UNION
SELECT g.GroupName, COUNT(ga.GroupID) AS SL
FROM GroupAccount ga
JOIN `Group` g ON ga.GroupID = g.GroupID
GROUP BY g.GroupID
HAVING COUNT(ga.GroupID) <= 7;