-- 1.	For event requests, list the event number, event date (eventrequest.dateheld), and count of the event plans. 
-- Only include event requests in the result if the event request has more than one related event plan with a work date in December 2013.

select  er.eventno,er.dateheld,
count(ep.eventno) 
from 
eventrequest er join eventplan ep
on 
er.eventno=ep.eventno
group by er.eventno,er.dateheld
having to_char(er.dateheld,'MM-YY')='12-13'
and count(ep.eventno) >1;

--2. List the plan number, event number, work date, and activity of event plans meeting the following two conditions: 
-- (1) the work date is in December 2013 and 
-- (2) the event is held in the “Basketball arena”.  
--Your query must not use the facility number (“F101”) of the basketball arena in the WHERE clause. Instead, 
-- you should use a condition on the FacName column for the value of “Basketball arena”.

select ep.planno,ep.eventno,ep.workdate,ep.activity ,ep.eventno
from eventplan ep join eventrequest er on 
ep.eventno=er.eventno
join facility f on 
er.facno=f.facno
where f.facname='Basketball arena'
and to_char(workdate,'MM-YY') = '12-13';

-- 3.	List the event number, event date, status, and estimated cost of events where there is an event plan managed by Mary Manager and the event is held in the basketball arena 
--in the period October 1 to December 31, 2013.
--  Your query must not use the facility number (“F101”) of the basketball arena or the employee number (“E101”) of “Mary Manager” in the WHERE clause.
-- Thus, the WHERE clause should not have conditions involving the facility number or employee number compared to constant values.

select er.eventno,er.dateheld,er.estcost,er.status,ep.eventno,f.facname,e.empno from eventplan ep join employee e
on e.empno=ep.empno
join eventrequest er
on er.eventno=ep.eventno
join facility f on 
f.facno=er.facno
where e.empname='Mary Manager'
and f.FACNAME='Basketball arena'
and to_char(er.dateheld) between '01-10-2013' and '31-12-2013';

--4.List the plan number, line number, resource name, number of resources (eventplanline.number), location name, time start, 
--and time end where the event is held at the basketball arena, the event plan has activity of activity of “Operation”,
--and the event plan has a work date in the period October 1 to December 31, 2013. 
--Your query must not use the facility number (“F101”) of the basketball arena in the WHERE clause.
--Instead, you should use a condition on the FacName column for the value of “Basketball arena”.


select epl.planno,epl.lineno,r.resname as resourceName,epl.numberfld as NumberOfResources,l.locname,epl.timestart,epl.timeend
-- ,ep.eventno,er.facno,f.facname,ep.activity
from 
eventplanline epl join resourcetbl r
on epl.resno=r.resno
join eventplan ep on ep.planno= epl.planno
join location l on l.locno=epl.locno
join eventrequest er on er.eventno=ep.eventno
join facility f on er.facno=f.facno
where f.facname='Basketball arena' and ep.activity= 'Operation';

