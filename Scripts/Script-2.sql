SELECT * FROM Transactions t where strftime('%j', t.Date) = strftime('%j', DATE('2020-05-27'))

select DISTINCT  DATE(t.Date) as date from Transactions t


select 
    strftime('%W', t.Date, 'weekday 1') WeekNumber,
    max(date(t.Date, 'weekday 1', '-7 day')) WeekStart,
    max(date(t.Date, 'weekday 1', '-1 day')) WeekEnd,
    count(*) as GroupedValues
from Transactions t
group by WeekNumber;

select 
    strftime('%W', t.Date, 'weekday 1') WeekNumber,
    max(date(t.Date, 'weekday 1')) WeekStart,
    max(date(t.Date, 'weekday 1', '+6 day')) WeekEnd,
    count(*) as GroupedValues
from Transactions t
group by WeekNumber;