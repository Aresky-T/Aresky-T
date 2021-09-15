DROP DATABASE IF EXISTS TestingSystem;
CREATE DATABASE TestingSystem;
USE TestingSystem;
DROP TABLE IF EXISTS Department;
CREATE TABLE Department(
  DepartmentID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  DepartmentName NVARCHAR(30) NOT NULL UNIQUE KEY
);
INSERT INTO Department(DepartmentName) 
VALUES
		(N'Marketing' ),
		(N'Sale' ),
		(N'Bảo vệ' ),
		(N'Nhân sự' ),
		(N'Kỹ thuật' ),
		(N'Tài chính' ),
		(N'Phó giám đốc'),
		(N'Giám đốc' ),
		(N'Thư kí' ),
		(N'No person' ),
		(N'Bán hàng' );

DROP TABLE IF EXISTS Position;
CREATE TABLE `Position` (
  PositionID   TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  PositionName ENUM('Dev','Test','Scrum Master','PM') NOT NULL UNIQUE KEY
);

INSERT INTO Position (PositionName ) 
VALUES  ('Dev' ),
		('Test' ),
		('Scrum Master'),
		('PM' ); 


DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account`(
	 AccountID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	 Email VARCHAR(50) NOT NULL UNIQUE KEY,
	 Username VARCHAR(50) NOT NULL UNIQUE KEY,
	 FullName NVARCHAR(50) NOT NULL,
	 DepartmentID TINYINT UNSIGNED NOT NULL,
	 PositionID TINYINT UNSIGNED NOT NULL,
	 CreateDate DATETIME DEFAULT NOW(),
	 FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
	 FOREIGN KEY(PositionID) REFERENCES `Position`(PositionID)
);
INSERT INTO `Account`(Email , Username, FullName , DepartmentID , PositionID, CreateDate)
VALUES   ('anhtuan@gmail.com' , 'aresky' ,'Nguyễn Anh Tuấn' , '5' , '1','2020-03-05'),
		 ('hiha2@gmail.com' , 'hiha' ,'hihi haha' , '1' , '2','2020-03-05'),
		 ('ngtai3@gmail.com' , 'ngtai' ,'Nguyễn Tài', '2' , '2' ,'2020-03-07'),
		 ('tikaka4@gmail.com' , 'tikaka' ,'tiki kaka', '3' , '4' ,'2020-03-08'),
		 ('minhveo5@gmail.com' , 'minhveo' ,'Mai Minh', '4' , '4' ,'2020-03-10'),
		 ('bezos6@gmail.com' , '100billionsusd' ,'Jeff Bezos', '6' , '3' ,'2020-04-05'),
		 ('CR7@gmail.com' , '5Goalball' ,'Cristiano Ronaldo', '2' , '2' , NULL ),
		 ('emi8@gmail.com' , 'eimija' ,'Eimi fukuda', '8' , '1' ,'2020-04-07'),
		 ('MU9@gmail.com' , 'UnitedFan' ,'Manchester United', '2' , '2' ,'2020-04-07'),
		 ('name10@gmail.com' , 'nousername' ,'no name', '10' , '1' ,'2020-04-09'),
		 ('Trump11@gmail.com' , 'TrumpD' ,'Donald Trump', '10' , '1' , DEFAULT),
		 ('yongun12@gmail.com' , 'kimkimun','kim yong-un' , '10' , '1' , DEFAULT);

DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group`(
	 GroupID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	 GroupName NVARCHAR(50) NOT NULL UNIQUE KEY,
	 CreatorID TINYINT UNSIGNED,
	 CreateDate DATETIME DEFAULT NOW(),
	 FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);

INSERT INTO `Group` ( GroupName , CreatorID , CreateDate)
VALUES   (N'Testing System' , 5,'2019-03-05'),
		 (N'Development' , 1,'2020-03-07'),
		 (N'Sale1' , 2 ,'2020-03-09'),
		 (N'Sale2' , 3 ,'2020-03-10'),
		 (N'Sale3' , 4 ,'2020-03-28'),
		 (N'Creator' , 6 ,'2020-04-06'),
		 (N'Marketing1' , 7 ,'2020-04-07'),
		 (N'Management' , 8 ,'2020-04-08'),
		 (N'Chat MYGroup' , 9 ,'2017-04-09'),
		 (N'My Class' , 10 ,'2017-04-10');
         
         
DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount(
	 GroupID TINYINT UNSIGNED NOT NULL,
	 AccountID TINYINT UNSIGNED NOT NULL,
	 JoinDate DATETIME DEFAULT NOW(),
	 PRIMARY KEY (GroupID,AccountID),
	 FOREIGN KEY(GroupID) REFERENCES `Group`(GroupID), 
	 FOREIGN KEY(AccountID) REFERENCES `Account`(AccountID) 
);

INSERT INTO `GroupAccount` ( GroupID , AccountID , JoinDate )
					VALUES  ( 1 , 		1,	'2020-03-05'),
							( 1 ,		2,	'2020-03-07'),
							( 3 ,		3,	'2020-03-09'),
							( 3 ,		4,	'2020-03-10'),
							( 5 ,		5,	'2020-03-28'),
							( 1 ,		3,	'2020-04-06'),
							( 1 ,		7,	'2020-04-07'),
							( 8 ,		3,	'2020-04-08'),
							( 1 ,		9,	'2020-04-09'),
							( 10 ,		10, '2020-04-10');
        
        
DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion (
	 TypeID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	 TypeName ENUM('Essay','Multiple-Choice') NOT NULL UNIQUE KEY
);

INSERT INTO TypeQuestion (TypeName ) 
VALUES ('Essay' ), ('Multiple-Choice' ); 

        
        
DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion(
 CategoryID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 CategoryName NVARCHAR(50) NOT NULL UNIQUE KEY
);

INSERT INTO CategoryQuestion (CategoryName )
VALUES  ('Java' ),
		('C/C++' ),
		('Game' ),
		('mySQL' ),
		('Web Basic' ),
		('Thoi tiet' ),
		('Football'),
		('Covid' ),
		('VietNam' ),
		('Mobile App' );
        
        
DROP TABLE IF EXISTS Question;
CREATE TABLE Question(
	 QuestionID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	 Content NVARCHAR(100) NOT NULL,
	 CategoryID TINYINT UNSIGNED NOT NULL,
	 TypeID TINYINT UNSIGNED NOT NULL,
	 CreatorID TINYINT UNSIGNED NOT NULL,
	 CreateDate DATETIME DEFAULT NOW(),
	 FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
	 FOREIGN KEY(TypeID) REFERENCES TypeQuestion(TypeID),
	 FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountId) 
);

INSERT INTO Question (Content ,                                            CategoryID, TypeID , CreatorID, CreateDate )
			VALUES  (N'What is Java?' ,                       					 1 ,  	 '1' ,	 '1' ,	'2020-04-05'),
					(N'can you Build HelloWorld With C/C++?' ,       		     2 ,	 '2' ,	 '2' ,	'2020-04-05'),
					(N'Can you play Lien Quan Mobile Game?' ,					 3 , 	 '2' ,	 '3' ,	'2020-04-06'),
					(N'Nhật Bản có mấy mùa trong năm?' ,     					 6 ,	 '1' ,	 '4' ,	'2020-04-06'),
					(N'Full Stack Dev là gì?' ,    					             5 ,	 '1' ,	 '5' ,	'2020-04-06'),
					(N'Có bao nhiêu loại Join trong mySQL?' ,					 4 ,	 '2' ,	 '6' ,	'2020-04-06'),
					(N'Việt Nam Có tham gia vòng loại World Cup 2022 không?' ,   9 ,	 '1' ,	 '7' ,	'2020-04-06'),
					(N'Viruss corona xuất hiện khi nao?' ,                 	     8 ,	 '1' ,	 '8' ,	'2020-04-07'),
					(N'Facebook ra đời năm nào?' ,                              10 ,	 '2' ,	 '9' ,	'2020-04-07'),
					(N'MU vô địch EPL bao nhiêu lần rồi?' ,                      7 ,	 '1' ,	 '10',	'2020-04-07');


DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer(
 AnswerID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 Content NVARCHAR(200) NOT NULL,
 QuestionID TINYINT UNSIGNED NOT NULL,
 isCorrect BIT DEFAULT 1,
 FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);

INSERT INTO Answer   ( Content ,          			 QuestionID ,      isCorrect )
			VALUES   (N'Java is Game' , 				1 ,				 0),
					 (N'Yes' , 							2 , 			 1),
					 (N'không biết',    				3 ,				 0 ),
					 (N'nhiều hơn 3 loại', 	   	        4 ,			     1 ),
					 (N'Dev web toàn năng',  			5 , 			 1 ),
					 (N'hai mùa',					    6 ,				 1 ),
					 (N'19', 					   		   7 ,				 0 ),
					 (N'2000',  						   8 , 			 0 ),
					 (N'có tham gia và bị loại rồi',       9 ,				 1 ),
					 (N'Chính thức ra đời năm 2005',       10 ,			     1) ,
					 (N'Chính thức ra đời năm 2009',       10 ,			     0 ),
					 (N'Java là một ngôn ngữ lập trình',   2 ,			     1 ),
					 (N'4 mùa',    						   6 ,			     0 ),
					 (N'không được tham gia',   		   9 ,			     0 ),
					 (N'có đúng 3 loại',				   4 ,			     0 ),
					 (N'không biết',  					   4 ,			     0 ),
					 (N'20 lần lần cuối mùa 2012/2013',    7 ,			     1 ),
					 (N'game ko rác', 					   3 ,			     1 );

				 

DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam(
	 ExamID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	 `Code` CHAR(10) NOT NULL,
	 Title NVARCHAR(100) NOT NULL,
	 CategoryID TINYINT UNSIGNED NOT NULL,
	 Duration TINYINT UNSIGNED NOT NULL,
	 CreatorID TINYINT UNSIGNED NOT NULL,
	 CreateDate DATETIME DEFAULT NOW(),
	 FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
	 FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountId)
);

INSERT INTO Exam (`Code` , Title ,            CategoryID, Duration , CreatorID , CreateDate )
		VALUES   ('EX1' , N'Đề thi Java' ,		 1 ,      60 ,      	'5' ,	'2020-04-05'),
				 ('EX2' , N'Đề thi Mobile app' , 10 ,	  60 , 			'2' ,	'2020-04-05'),
				 ('EX3' , N'Đề thi Vienam' , 	 9 ,	  120 ,		    '2' ,	'2020-04-07'),
				 ('EX4' , N'Đề thi Thoi tiet' ,  6 ,	  60, 		    '3' ,	'2020-04-08'),
				 ('EX5' , N'Đề thi web basic' ,  5 ,	  120,		    '4' ,	'2020-04-10'),
				 ('EX6' , N'Đề thi Game' , 	 	 3 ,	  60 ,   		'6' ,	'2020-04-05'),
				 ('EX7' , N'Đề thi C/C++' ,  	 2 , 	  60 ,		    '7' ,	'2020-04-05'),
				 ('EX8' , N'Đề thi Covid' , 	 8 , 	  60 ,   		'8' ,	'2020-04-07'),
				 ('EX9' , N'Đề thi MySQL' ,      4 ,	  90 ,		    '9' ,	'2020-04-07'),
				 ('EX10', N'Đề thi Football' ,   7 , 	  90 ,    		'10' ,	'2020-04-08');
         
         
DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion(
	ExamID TINYINT UNSIGNED NOT NULL,
	QuestionID TINYINT UNSIGNED NOT NULL,
	FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID),
	FOREIGN KEY(ExamID) REFERENCES Exam(ExamID) ,
	PRIMARY KEY (ExamID,QuestionID)
);

INSERT INTO ExamQuestion(ExamID , QuestionID ) 
VALUES  ( 1 , 1),
		( 2 , 10 ), 
		( 3 , 9 ), 
		( 4 , 6 ), 
		( 5 , 5 ), 
		( 6 , 3 ), 
		( 7 , 2 ), 
		( 8 , 8 ), 
		( 9 , 4 ), 
		( 10 , 7 );
        
        