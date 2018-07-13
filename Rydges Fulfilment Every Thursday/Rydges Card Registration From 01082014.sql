select * from cardregistration
where productmgrid in (22181,22191)
and createddate >= to_date('01/08/2014','dd/mm/yyyy') 