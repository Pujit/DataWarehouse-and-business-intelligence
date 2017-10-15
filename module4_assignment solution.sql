-- 1.	List the city, state, and zip codes in the customer table.  Your result should not have duplicates. (Hint: The DISTINCT keyword eliminates duplicates.)
select custcity, custstate, custzip from customer;

-- 2.	List the name, department, phone number, and email address of employees with a phone number beginning with “3-”.
select empname,empdepartment,empphone,empemail from employee 
where empphone like '3%';

-- 3.	List all columns of the resource table with a rate between $10 and $20. Sort the result by rate.
select * from resourcetbl where resrate between 10 and 20;

--4.	List the event requests with a status of “Approved” or “Denied” and an authorized date in July 2013. 
-- Include the event number, authorization date, and status in the output. (Hint: see the examples in Module 4 for date constants in Oracle and MySQL.)
select eventno,dateauth,status from eventrequest where
status in ('Approved','Denied') and extract(year from dateauth)=2013 and extract(month from dateauth)= 07 ;

-- 5.	List the location number and name of locations that are part of the “Basketball arena”.  Your WHERE clause should not have a condition 
--involving the facility number compared to a constant (“F101”). 
-- Instead, you should use a condition on the FacName column for the value of “Basketball arena”.

select locno, l.locname from location l join facility f
on l.facno = f.facno and upper(f.facname)=upper('Basketball arena');

-- 6.	For each event plan, list the plan number, count of the event plan lines, and sum of the number of resources assigned. 
--  For example, plan number “P100” has 4 lines and 7 resources assigned.
--  You only need to consider event plans that have at least one line.

select planno, count(lineno) as linenumbers ,sum(numberfld) resources from eventplanline
group by planno ;