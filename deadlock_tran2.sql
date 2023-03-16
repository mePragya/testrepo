select * from accounts;
-- trying to update a roll,which is not yet visible in this session i.e not yet commited in the session where change was made
update accounts set name ='Cassy' where id=7 --nothing upddeadlockated anywhere .......... after commit in that transaction it did reflect here

begin;
update accounts set name ='Coco' where id=7
commit;

rollback;
 ----------------- deadlock implementation transaction 2 -----------
CREATE TABLE t_data (id int, data int);

INSERT INTO t_data VALUES (1, 100), (2, 200);

select * from t_data;

--drop table t_data;
begin;
UPDATE t_data
SET data = data * 10
WHERE id = 2
  -- go to transaction 1
UPDATE t_data
SET data = data * 10
WHERE id = 1
-- deadlock
rollback; 

------------------------------ Deadlock Avoidance transaction 2 ------------------
begin;
UPDATE t_data
SET data = data * 10
WHERE id = 1
-- waits , go to tran 1

UPDATE t_data
SET data = data * 10
WHERE id = 2
commit;