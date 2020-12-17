SELECT * FROM Transactions t WHERE t.Account = 1 GROUP BY t.Date 

SELECT * FROM Transactions t WHERE strftime('%j', t.Date ) = STRFTIME('%j', datetime('now','localtime')) GROUP BY 

SELECT * FROM Transactions t where strftime('%j', t.Date) = strftime('%j', DATE('2020-05-15 21:00:00.000Z'))  

select DISTINCT DATE(t.Date) as date from Transactions t 

SELECT * FROM Transactions t where strftime('%j', t.Date) = strftime('%j', '2020-05-15 21:00:00.000Z')

select GROUPS.Name as group, GROUPS.Course as course, AVG
" + "(PROGRESS.Mark) as \"mark\", PROGRESS.ExamDate as \"date\" 
from " + "STUDENT 
join GROUPS on GROUPS.Group_id = STUDENT.Group_id 
join PROGRESS on PROGRESS.Student = STUDENT.Student_id 
WHERE PROGRESS.ExamDate BETWEEN \"" + from.toString() + "\" and \"" + to.toString() + "\" 
GROUP BY GROUPS.Group_id ORDER BY GROUPS.Group_id