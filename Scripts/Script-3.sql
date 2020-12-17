CREATE VIEW WeekInfo as select 
    strftime('%W', t.Date, 'weekday 1') WeekNumber,
    max(date(t.Date, 'weekday 1', '-7 day')) WeekStart,
    max(date(t.Date, 'weekday 1', '-1 day')) WeekEnd,
    count(*) as GroupedValues
from Transactions t
group by WeekNumber;

select * from WeekInfo 