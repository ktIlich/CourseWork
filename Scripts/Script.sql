PRAGMA foreign_keys = ON
 
drop TABLE  Icons 

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

CREATE TABLE Accounts (
	Acc_id INTEGER,
	Name TEXT,
	Currency TEXT,
	Balance REAL, 
	Icon INTEGER,
	PRIMARY KEY (Acc_id),
	FOREIGN KEY (Icon) REFERENCES Icons(Icon_id)
);

CREATE TABLE Categories (
	Cat_id INTEGER,
	Name TEXT,
	Type INTEGER, 
	Icon INTEGER,
	PRIMARY KEY (Cat_id),
	FOREIGN KEY (Icon) REFERENCES Icons(Icon_id)
);

drop table Transactions 

CREATE TABLE Transactions (
	Trans_id INTEGER,
	Type INTEGER,
	Date TEXT,
	Account INTEGER,
	Value REAL,
	Note TEXT, 
	Category INTEGER,
	PRIMARY KEY (Trans_id),
	FOREIGN KEY (Type) REFERENCES Types(Type_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Account) REFERENCES Accounts(Acc_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Category) REFERENCES Categories(Cat_id) ON DELETE CASCADE ON UPDATE CASCADE
);

drop view WeekInfo 
create view WeekInfo as
select 
Date(t.Date) date,
    strftime('%W', t.Date ) week,
    max(date(t.Date, 'weekday 0', '-7 day')) weekStart,
    max(date(t.Date, 'weekday 0', '-1 day')) weekEnd,
    count(*) as countVal
from Transactions t
group by strftime('%Y', t.Date ), week
order by date;

select * from Transactions t 



drop view DateInfo 
CREATE VIEW DateInfo as SELECT DISTINCT 
	DATE(t.Date) as date, 
	strftime('%j', t.Date) as day,
	strftime('%W', t.Date) as week,
	strftime('%m', t.Date) as month,
	strftime('%Y', t.Date) as year
	FROM Transactions t  order by date
	
	
drop view DateInfoWithWeek
create view DateInfoWithWeek as
	select wi.date, di."day", wi.week, wi.weekStart, wi.weekEnd, di."month", di."year"  
		from WeekInfo wi 
			join DateInfo di 
				on wi.date = di.date 
	
				select * from DateInfoWithWeek diww 
				
create view DateAll as 
select   
    min(date(t.Date)) timeStart,
    max(date(t.Date)) timeEnd    
from Transactions t;

select 
	Date,
    strftime('%W', Date) WeekNumber,
    max(date(Date, 'weekday 0', '-7 day')) WeekStart,
    max(date(Date, 'weekday 0', '-1 day')) WeekEnd,
    count(*) as GroupedValues
from Transactions 
group by WeekNumber;

SELECT * FROM Transactions t where strftime('%W', t.Date) = strftime('%W', DATE('2020-05-12 00:00:00.000')) and strftime('%Y', t.Date) = strftime('%Y', DATE('2020-05-12 00:00:00.000'))  order by t.Date