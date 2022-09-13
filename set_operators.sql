use test3;


SELECT * from tableA
EXCEPT
select * from tableB;

SELECT * FROM tableA
WHERE id not in ( SELECT id from tableB)




SELECT * FROM tableA 
INTERSECT
select * from tableB

SELECT * FROM tableA 
WHERE id in (SELECT id from tableB)

SELECT t1.id, t1.Name, t1.Gender 
FROM tableA as t1 
inner join tableB as t2 
on t1.id = t2.id

