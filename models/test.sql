
/* 
Create a model using sources
*/

select * 
{{ source('demo', 'bike') }}
limit 10;