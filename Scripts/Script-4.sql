PRAGMA foreign_keys = ON

drop table Accounts 
drop table Categories 
drop table Transactions 

CREATE TABLE Types(
	Type_id INTEGER,
	Name TEXT,
	PRIMARY KEY (Type_id)
);


CREATE TABLE Icons (
	Icon_id INTEGER,
	Type INTEGER,
	Name TEXT,
	PRIMARY KEY (Icon_id),
	FOREIGN KEY (Type) REFERENCES Types(Type_id)
);

CREATE TABLE Users (
	UserID INTEGER,
	Login TEXT(15),
	Password Text(15),
	PRIMARY KEY (UserID)
);

CREATE TABLE Categories (
	Cat_id INTEGER,
	Name TEXT,
	Type INTEGER, 
	Icon INTEGER,
	UserID INTEGER,
	date_insert TEXT,
	date_update TEXT,
	date_delete TEXT,
	PRIMARY KEY (Cat_id),
	FOREIGN KEY (Icon) REFERENCES Icons(Icon_id),
	FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE ON UPDATE CASCADE	
);

CREATE TABLE Accounts (
	Acc_id INTEGER,
	Name TEXT,
	Currency TEXT,
	Balance REAL, 
	Icon INTEGER,
	UserID INTEGER,
	date_insert TEXT,
	date_update TEXT,
	date_delete TEXT,
	PRIMARY KEY (Acc_id),
	FOREIGN KEY (Icon) REFERENCES Icons(Icon_id),
	FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE ON UPDATE CASCADE	
);

CREATE TABLE Transactions (
	Trans_id INTEGER,
	Type INTEGER,
	Date TEXT,
	Account INTEGER,
	Value REAL,
	Note TEXT, 
	Category INTEGER,
	UserID INTEGER,
	date_insert TEXT,
	date_update TEXT,
	date_delete TEXT,
	PRIMARY KEY (Trans_id),
	FOREIGN KEY (Type) REFERENCES Types(Type_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Account) REFERENCES Accounts(Acc_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Category) REFERENCES Categories(Cat_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE ON UPDATE CASCADE
);

drop view WeekInfo 
create view WeekInfo as
select 
	Date(t.Date) date,
    strftime('%W', t.Date ) week,
    max(date(t.Date, 'weekday 0', '-7 day')) weekStart,
    max(date(t.Date, 'weekday 0', '-1 day')) weekEnd,
    count(*) as countVal,
    UserID 
from Transactions t
group by strftime('%Y', t.Date ), week
order by date;

drop view DateInfo 
CREATE VIEW DateInfo as SELECT DISTINCT 
	DATE(t.Date) as date, 
	strftime('%j', t.Date) as day,
	strftime('%W', t.Date) as week,
	strftime('%m', t.Date) as month,
	strftime('%Y', t.Date) as year,
	UserID 
FROM Transactions t  order by date;

select * from Categories c 



select * from DateInfo di where UserID = 1 GROUP by di."year" 

drop view DateInfoWithWeek 
create view DateInfoWithWeek as
	select wi.date, di."day", wi.week, wi.weekStart, wi.weekEnd, di."month", di."year", di.UserID 
		from WeekInfo wi 
			join DateInfo di 
				on wi.date = di.date and wi.UserID = di.UserID; 
			
drop view DateAll 			
create view DateAll as 
select   
    min(date(t.Date)) timeStart,
    max(date(t.Date)) timeEnd,
    UserID 
from Transactions t


CREATE TRIGGER InsertCategoryTrigger AFTER INSERT 
	ON Categories 
BEGIN
	UPDATE Categories SET date_insert = DATETIME('now', 'localtime') WHERE Cat_id = NEW.Cat_id; 
END;

CREATE TRIGGER UpdateCategoryTrigger AFTER UPDATE 
	ON Categories 
BEGIN
	UPDATE Categories SET date_update = DATETIME('now', 'localtime') WHERE Cat_id = OLD.Cat_id; 
END;

CREATE TRIGGER DeleteCategoryTrigger Before DELETE 
	ON Categories 
BEGIN
	UPDATE Categories SET date_delete = DATETIME('now', 'localtime') WHERE Cat_id = OLD.Cat_id; 
END;



CREATE TRIGGER InsertAccountTrigger AFTER INSERT 
	ON Accounts 
BEGIN
	UPDATE Accounts SET date_insert = DATETIME('now', 'localtime') WHERE Acc_id = NEW.Acc_id; 
END;

CREATE TRIGGER UpdateAccountTrigger AFTER UPDATE 
	ON Accounts 
BEGIN
	UPDATE Accounts SET date_update = DATETIME('now', 'localtime') WHERE Acc_id = OLD.Acc_id; 
END;

CREATE TRIGGER DeleteAccountTrigger Before DELETE 
	ON Accounts 
BEGIN
	UPDATE Accounts SET date_delete = DATETIME('now', 'localtime') WHERE Acc_id = OLD.Acc_id; 
END;


CREATE TRIGGER InsertTransactionsTrigger AFTER INSERT 
	ON Transactions 
BEGIN
	UPDATE Transactions SET date_insert = DATETIME('now', 'localtime') WHERE Trans_id = NEW.Trans_id; 
END;

CREATE TRIGGER UpdateTransactionsTrigger AFTER UPDATE 
	ON Transactions 
BEGIN
	UPDATE Transactions SET date_update = DATETIME('now', 'localtime') WHERE Trans_id = OLD.Trans_id; 
END;

CREATE TRIGGER DeleteTransactionsTrigger Before DELETE 
	ON Transactions 
BEGIN
	UPDATE Transactions SET date_delete = DATETIME('now', 'localtime') WHERE Trans_id = OLD.Trans_id; 
END;


SELECT * from T

INSERT INTO Types (Type_id,Name) VALUES (
1,'income');
INSERT INTO Types (Type_id,Name) VALUES (
2,'expense');
INSERT INTO Types (Type_id,Name) VALUES (
3,'transfer');
INSERT INTO Types (Type_id,Name) VALUES (
4,'account');
INSERT INTO Types (Type_id,Name) VALUES (
5,'category');


INSERT INTO Accounts (Acc_id,Name,Currency,Balance,Icon, UserID, date_delete) VALUES (
1,'Cash','BYN',0,108,1,''),(
2,'Debit card','BYN',0,128,1,'');

 
INSERT INTO Categories (Cat_id,Name,"Type",Icon,UserID, date_delete) VALUES 
(1,'Hygiene',2,91,1,''),
(2,'Food',2,44,1,''),
(3,'House',2,71,1,''),
(4,'Health',2,54,1,''),
(5,'Cafe',2,34,1,''),
(6,'Car',2,14,1,''),
(7,'Clothes',2,21,1,''),
(8,'Pets',2,16,1,''),
(9,'Gifts',2,49,1,''),
(10,'Relax',2,38,1,''),
(11,'Communication',2,23,1,''),
(12,'Sport',2,82,1,''),
(13,'Expense',2,29,1,''),
(14,'Taxi',2,87,1,''),
(15,'Transport',2,94,1,''),
(16,'Deposits',1,63,1,''),
(17,'Salary',1,22,1,''),
(18,'Savings',1,65,1,'');


INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
1,5,'aircraft.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
2,5,'apartment.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
3,5,'armchair.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
4,5,'baby.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
5,5,'babyroom.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
6,5,'barbershop.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
7,5,'basketball.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
8,5,'beach.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
9,5,'beer.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
10,5,'brush.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
11,5,'bus.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
12,5,'camera.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
13,5,'campfire.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
14,5,'car.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
15,5,'cardinuse.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
16,5,'cat.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
17,5,'cell_phone.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
18,5,'chiansaw.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
19,5,'chokolate.png');

INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
20,5,'clipperboard.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
21,5,'clothes.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
22,5,'coins.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
23,5,'communications.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
24,5,'cook.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
25,5,'cooker.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
26,5,'cookingpot.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
27,5,'credit_card.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
28,5,'dating.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
29,5,'default_category_icon.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
30,5,'devices.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
31,5,'doctor_suitecase.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
32,5,'dog.png');

INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
33,5,'dress.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
34,5,'eating_out.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
35,5,'electricity.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
36,5,'electronics.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
37,5,'emptybox.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
38,5,'entertainment.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
39,5,'face.png');

INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
40,5,'film.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
41,5,'fish.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
42,5,'flippers.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
43,5,'flower.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
44,5,'food.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
45,5,'football.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
46,5,'fridge.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
47,5,'gardenshears.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
48,5,'gas_station.png');

INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
49,5,'gifts.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
50,5,'glasses.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
51,5,'grapes.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
52,5,'guitar.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
53,5,'hand_biceps.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
54,5,'health.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
55,5,'horse.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
56,5,'icecream.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
57,5,'iphone.png');


INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
58,5,'joystick.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
59,5,'laptop.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
60,5,'literature.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
61,5,'loundry.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
62,5,'manshoe.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
63,5,'moneybag.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
64,5,'moneybox.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
65,5,'money_box.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
66,5,'motorcycle.png');


INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
67,5,'pacifier.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
68,5,'pig.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
69,5,'policeman.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
70,5,'regular_biking.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
71,5,'rent.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
72,5,'rifle.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
73,5,'roller_brush.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
74,5,'rugby.png');


INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
75,5,'scissors.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
76,5,'scooter.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
77,5,'screwdriver.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
78,5,'shop.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
79,5,'shopping.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
80,5,'skiing.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
81,5,'smoking.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
82,5,'sports.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
83,5,'strawberry.png');

INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
84,5,'stroller.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
85,5,'study.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
86,5,'sushi.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
87,5,'taxi.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
88,5,'teddybear.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
89,5,'tennis.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
90,5,'tire.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
91,5,'toilet.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
92,5,'train.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
93,5,'trainers.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
94,5,'transport.png');


INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
95,5,'trumpet.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
96,5,'two_hearts.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
97,5,'university.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
98,5,'violin.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
99,5,'wardrobe.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
100,5,'washing_machine.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
101,5,'wateringcan.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
102,5,'weightlift.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
103,5,'wine_bottle.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
104,5,'womenshoe.png');


INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
105,5,'www.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
106,5,'yacht.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
107,4,'amex.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
108,4,'banknotes.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
109,4,'bitcoin.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
110,4,'cashreceiving.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
111,4,'cashregister.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
112,4,'chf.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
113,4,'diners_club.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
114,4,'discover.png');

INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
115,4,'euro.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
116,4,'googlewallet.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
117,4,'gpb.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
118,4,'jcb.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
119,4,'jpy.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
120,4,'mastercard.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
121,4,'money.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
122,4,'money_bag.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
123,4,'paypal.png');


INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
124,4,'qiwi.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
125,4,'rouble.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
126,4,'stripe.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
127,4,'usd.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
128,4,'visa.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
129,4,'yandex_money.png');
INSERT INTO Icons (Icon_id,"Type",Name) VALUES (
130,4,'default_category_icon.png');


DELETE  Transactions 

INSERT INTO Transactions (Trans_id,"Type",Date,Account,Value,Note,Category, UserID, date_delete) VALUES 
(1,1,'2020-05-03 00:00:00.000',1,42585,'',17,1,''),
(2,2,'2020-05-06 00:00:00.000',1,885,'',5,1,''),
(3,2,'2020-05-03 00:00:00.000',1,6558,'',2,1,''),
(4,2,'2020-05-11 00:00:00.000',1,84848,'',2,1,''),
(5,2,'2020-05-21 00:00:00.000',1,5.494,'',2,1,''),
(6,2,'2020-05-26 00:00:00.000',1,789797,'',8,1,''),
(7,1,'2020-05-28 19:35:15.289818',1,4949,'',17,1,''),
(8,2,'2020-05-28 19:35:43.642766',1,9878,'',2,1,''),
(9,2,'2020-05-28 19:35:43.6426',1,9878,'',2,1,'');

UPDATE Transactions set UserID = 1 WHERE Trans_id  = 9

select * from Transactions t 
select * from Categories 

select * from DateInfo di where UserID = 1


UPDATE Transactions
	SET date_update =''
	WHERE date_update ISNULL 