select * from test_db.dbo.Data1
select * from test_db.dbo.Data2

-- number of rows into the dataset
select count(*) from test_db..Data1
select count(*) from test_db..Data2

-- dataset for Jharkhand and Bihar
select * from test_db..Data1 where state in ('Jharkhand', 'Bihar')

-- calculate total population of India
select sum(population) population from test_db..Data2 

-- avg growth in India
select avg(growth)*100 avg_growth from test_db..Data1

-- avg growth in India in each state
select state,avg(growth)*100 avg_growth from test_db..Data1 group by state

-- avg sex ratio
select state,round(avg(sex_ratio), 0) avg_sex_ratio from test_db..Data1 group by state order by avg_sex_ratio desc

-- avg literacy ratio with value > 90
select state,round(avg(literacy), 0) avg_literacy_ratio from test_db..Data1 
group by state having round(avg(literacy), 0) > 90 order by avg_literacy_ratio desc

-- top 3 states having the highest growth rate
select top 3 state, avg(growth)*100 avg_growth from test_db..Data1 group by state order by avg_growth desc

-- bottom 3 states having the lowest sex ratio
select top 3 state, round(avg(sex_ratio), 0) avg_sex_ration from test_db..Data1 group by state order by avg_sex_ration asc

-- top 3 states in literacy
drop table if exists #top_states
create table #top_states
(state nvarchar(255),
 topstates float
)

insert into #top_states
select state, round(avg(literacy), 0) avg_literacy_ratio from test_db..Data1 
group by state order by avg_literacy_ratio desc

select top 3 * from #top_states order by #top_states.topstates desc

--bottom 3 states in literacy
drop table if exists #bottom_states
create table #bottom_states
(state nvarchar(255),
 bottomstates float
)

insert into #bottom_states
select state, round(avg(literacy), 0) avg_literacy_ratio from test_db..Data1 
group by state order by avg_literacy_ratio asc

select top 3 * from #bottom_states order by #bottom_states.bottomstates asc;

--using union operator to combine "top" and "bottom" tables
select * from( select top 3 * from #bottom_states order by #bottom_states.bottomstates desc) a

union

select * from( select top 3 * from #top_states order by #top_states.topstates asc) b

--states starting with letter A
select distinct state from test_db..Data1 where state like 'A%' or state like '%d'



